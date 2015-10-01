{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DeriveFoldable             #-}
{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DeriveTraversable          #-}
{-# LANGUAGE ExtendedDefaultRules       #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE FunctionalDependencies     #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE KindSignatures             #-}
{-# LANGUAGE LambdaCase                 #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TemplateHaskell            #-}

-- Module      : Gen.Types.Schema
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)

module Gen.Types.Schema where

import           Control.Applicative
import           Control.Lens         hiding ((.=))
import           Control.Monad
import           Data.Aeson           hiding (Array, Bool, Object, String)
import qualified Data.Aeson           as A
import           Data.Aeson.TH
import           Data.Aeson.Types     (Parser)
import qualified Data.HashMap.Strict  as Map
import           Data.Maybe
import           Data.Semigroup       ((<>))
import           Data.Text            (Text)
import qualified Data.Text            as Text
import           Data.Text.Manipulate
import           Gen.Orphans          ()
import           Gen.Text
import           Gen.TH
import           Gen.Types.Help
import           Gen.Types.Id
import           Gen.Types.Map
import           Prelude              hiding (Enum)

keyless :: Map Text a -> [a]
keyless = Map.elems

newtype Fix f = Fix (f (Fix f))

data Location
    = Query
    | Path
      deriving (Eq, Show)

deriveJSON options ''Location

newtype Ann = Ann { annRequired :: [Local] }
    deriving (Eq, Show, Monoid)

deriveJSON options ''Ann

data Info = Info
    { _iId          :: Maybe Global
    , _iDescription :: Maybe Help
    , _iDefault     :: Maybe Text
    , _iRequired    :: Bool
    , _iPattern     :: Maybe Text
    , _iMinimum     :: Maybe Text
    , _iMaximum     :: Maybe Text
    , _iRepeated    :: Bool
    , _iAnnotations :: Ann
    } deriving (Eq, Show)

makeClassy ''Info

instance FromJSON Info where
    parseJSON = withObject "info" $ \o -> Info
        <$> o .:? "id"
        <*> o .:? "description"
        <*> o .:? "default"
        <*> o .:? "required"    .!= False
        <*> o .:? "pattern"
        <*> o .:? "minimum"
        <*> o .:? "maximum"
        <*> o .:? "repeated"    .!= False
        <*> o .:? "annotations" .!= mempty

defaulted, required, parameter :: HasInfo a => a -> Bool
defaulted   = isJust . view iDefault
required    = view iRequired
parameter s = required s && not (defaulted s)

emptyInfo :: Info
emptyInfo = Info
    { _iId          = Nothing
    , _iDescription = Nothing
    , _iDefault     = Nothing
    , _iRequired    = False
    , _iPattern     = Nothing
    , _iMinimum     = Nothing
    , _iMaximum     = Nothing
    , _iRepeated    = False
    , _iAnnotations = mempty
    }

requiredInfo :: Info
requiredInfo = emptyInfo & iRequired .~ True

setRequired :: HasInfo a => a -> a
setRequired = iRequired .~ True

data Schema a
    = SAny Info Any
    | SRef Info Ref
    | SLit Info Lit
    | SEnm Info Enm
    | SArr Info (Arr a)
    | SObj Info (Obj a)
      deriving (Eq, Show)

instance FromJSON (Fix Schema) where
    parseJSON o = do
        i <- parseJSON o
        s <-    SRef i <$> parseJSON o
            <|> SEnm i <$> parseJSON o
            <|> SArr i <$> parseJSON o
            <|> SObj i <$> parseJSON o
            <|> SLit i <$> parseJSON o
            <|> SAny i <$> parseJSON o
        pure (Fix s)

instance HasInfo (Schema a) where
    info = lens f (flip g)
      where
        f = \case
            SAny i _ -> i
            SRef i _ -> i
            SLit i _ -> i
            SEnm i _ -> i
            SArr i _ -> i
            SObj i _ -> i

        g i = \case
            SAny _ x -> SAny i x
            SRef _ x -> SRef i x
            SLit _ x -> SLit i x
            SEnm _ x -> SEnm i x
            SArr _ x -> SArr i x
            SObj _ x -> SObj i x

instance HasInfo (Fix Schema) where
    info = lens (\(Fix f) -> f ^. info) (\(Fix f) a -> Fix (f & info .~ a))

checkType :: Text -> A.Object -> Parser ()
checkType x o = do
   y <- o .: "type"
   unless (x == y) . fail . Text.unpack $
       "Schema type mismatch, expected " <> x <> ", but got " <> y
          <> "\n" <> Text.pack (show o)

data Any = Any
    deriving (Eq, Show)

instance FromJSON Any where
    parseJSON = withObject "any" (\o -> Any <$ checkType "any" o)

newtype Ref = Ref { ref :: Global }
    deriving (Eq, Show)

instance FromJSON Ref where
    parseJSON = withObject "ref" (fmap Ref . (.: "$ref"))

data Lit
    -- Literal types.
    = Text
    | Bool
    | Float
    | Double
    | Byte
    | UInt32
    | UInt64
    | Int32
    | Int64
    | Nat
    | Date
    | Time
    -- Core types.
    | Body
    | Alt Text
    | Key
    | OAuthToken
      deriving (Eq, Show)

instance FromJSON Lit where
    parseJSON = withObject "literal" $ \o -> do
        t <- o .: "format" <|> o .: "type"
        case t of
            -- Types
            "string"    -> pure Text
            "boolean"   -> pure Bool

            -- Formats
            "float"     -> pure Float
            "double"    -> pure Double
            "byte"      -> pure Byte
            "uint32"    -> pure UInt32
            "uint64"    -> pure UInt64
            "int32"     -> pure Int32
            "int64"     -> pure Int64
            "date"      -> pure Date
            "date-time" -> pure Time

            _           -> fail $
                "Unable to parse Literal from: " ++ Text.unpack t

newtype Enm = Enm { _eValues :: [(Text, Help)] }
    deriving (Eq, Show)

instance FromJSON Enm where
    parseJSON = withObject "enum" $ \o -> do
        checkType "string" o
        vs <- o .: "enum"
        ds <- o .: "enumDescriptions"
        pure $! Enm (zip vs (ds ++ repeat mempty))

newtype Arr a = Arr { _aItem :: a }
    deriving (Eq, Show)

instance FromJSON a => FromJSON (Arr a) where
    parseJSON = withObject "array" $ \o -> do
        checkType "array" o
        Arr <$> o .: "items"

data Obj a = Obj
    { _oAdditional :: Maybe a
    , _oProperties :: Map Local a
    } deriving (Eq, Show)

instance FromJSON a => FromJSON (Obj a) where
    parseJSON = withObject "object" $ \o -> do
        checkType "object" o
        Obj <$> o .:? "additionalProperties"
            <*> o .:? "properties" .!= mempty

data Param a = Param
    { _pLocation :: Location
    , _pParam    :: a
    } deriving (Eq, Show, Functor, Foldable, Traversable)

makeLenses ''Param

instance FromJSON a => FromJSON (Param a) where
    parseJSON = withObject "param" $ \o -> Param
        <$> o .: "location"
        <*> parseJSON (A.Object o)

instance HasInfo a => HasInfo (Param a) where
    info = pParam . info

data MediaUpload = MediaUpload
    { _muAccept        :: [Text]
    , _muMaxSize       :: Maybe Text
    , _muResumablePath :: Text
    , _muSimplePath    :: Text
    } deriving (Eq, Show)

instance FromJSON MediaUpload where
    parseJSON = withObject "mediaUpload" $ \o -> MediaUpload
         <$>  o .:  "accept"
         <*>  o .:? "maxSize"
         <*> (o .:  "protocols" >>= (.: "resumable") >>= (.: "path"))
         <*> (o .:  "protocols" >>= (.: "simple")    >>= (.: "path"))

data Method a = Method
    { _mId                    :: Global
    , _mPath                  :: Text
    , _mHttpMethod            :: Text
    , _mDescription           :: Maybe Help
    , _mParameters            :: Map Local (Param a)
    , _mParameterOrder        :: [Local]
    , _mRequest               :: Maybe Ref
    , _mResponse              :: Maybe Ref
    , _mScopes                :: [Text]
    , _mSupportsMediaUpload   :: Bool
    , _mSupportsMediaDownload :: Bool
    , _mMediaUpload           :: Maybe MediaUpload
    , _mSupportsSubscription  :: Bool
    } deriving (Eq, Show, Functor, Foldable, Traversable)

instance FromJSON a => FromJSON (Method a) where
    parseJSON = withObject "method" $ \o -> Method
        <$> o .:  "id"
        <*> o .:  "path"
        <*> o .:  "httpMethod"
        <*> o .:? "description"
        <*> o .:? "parameters"            .!= mempty
        <*> o .:? "parameterOrder"        .!= mempty
        <*> o .:? "request"
        <*> o .:? "response"
        <*> o .:? "scopes"                .!= mempty
        <*> o .:? "supportsMediaUpload"   .!= False
        <*> o .:? "supportsMediaDownload" .!= False
        <*> o .:? "mediaUpload"
        <*> o .:? "supportsSubscription"  .!= False

data Resource a = Resource
    { _rResources :: Map Local (Resource a)
    , _rMethods   :: [Method a]
    } deriving (Eq, Show, Functor, Foldable, Traversable)

instance FromJSON a => FromJSON (Resource a) where
    parseJSON = withObject "resource" $ \o -> Resource
         <$>  o .:? "resources" .!= mempty
         <*> (o .:? "methods"   .!= mempty <&> keyless)

newtype OAuth2 = OAuth2 { scopes :: Map Text Help }
    deriving (Eq, Show)

instance FromJSON OAuth2 where
    parseJSON = withObject "oauth2" $ \x -> do
        y <- x .: "oauth2"
        z <- y .: "scopes"
        OAuth2 <$> traverse (.: "description") z

data Label
    = Deprecated
    | LimitedAvailability
    | Labs
      deriving (Eq, Show)

instance FromJSON Label where
    parseJSON = withText "label" $ \t ->
        case t of
            "deprecated"           -> pure Deprecated
            "limited_availability" -> pure LimitedAvailability
            "labs"                 -> pure Labs
            _                      -> fail $
                Text.unpack ("Unable to parse Label from: " <> t)

instance ToJSON Label where
    toJSON = toJSON . \case
        Deprecated          -> "deprecated" :: Text
        LimitedAvailability -> "limited_availability"
        Labs                -> "labs"

data Description a = Description
    { _dKind              :: Text
    , _dDiscoveryVersion  :: Text
    , _dId                :: Text
    , _dName              :: Text
    , _dVersion           :: Text
    , _dRevision          :: Maybe Text
    , _dTitle             :: Text
    , _dDescription       :: Help
    , _dIcons             :: Map Text Text
    , _dDocumentationLink :: Text
    , _dLabels            :: [Label]
    , _dProtocol          :: Text
    , _dBaseUrl           :: Text
    , _dRootUrl           :: Text
    , _dServicePath       :: Text
    , _dBatchPath         :: Text
    , _dParameters        :: Map Local (Param a)
    , _dAuth              :: Maybe OAuth2
    , _dFeatures          :: [Text]
    , _dSchemas           :: Map Global a
    , _dResources         :: Map Global (Resource a)
    , _dMethods           :: [Method a]
    } deriving (Eq, Show)

makeClassy ''Description

instance FromJSON a => FromJSON (Description a) where
    parseJSON = withObject "description" $ \o -> Description
        <$> o .:  "kind"
        <*> o .:  "discoveryVersion"
        <*> o .:  "id"
        <*> o .:  "name"
        <*> o .:  "version"
        <*> o .:? "revision"
        <*> o .:  "title"
        <*> o .:  "description"
        <*> o .:  "icons"
        <*> o .:  "documentationLink"
        <*> o .:? "labels"     .!= mempty
        <*> o .:  "protocol"
        <*> o .:  "baseUrl"
        <*> o .:  "rootUrl"
        <*> o .:  "servicePath"
        <*> o .:  "batchPath"
        <*> o .:? "parameters" .!= mempty
        <*> o .:? "auth"
        <*> o .:? "features"   .!= mempty
        <*> o .:? "schemas"    .!= mempty
        <*> o .:? "resources"  .!= mempty
        <*> (o .:? "methods"   .!= mempty <&> keyless)

data Service a = Service
    { _sLibrary       :: Text
    , _sCanonicalName :: Text
    , _sOwnerName     :: Text
    , _sOwnerDomain   :: Text
    , _sPackagePath   :: Maybe Text
    , _sDescription   :: (Description a)
    } deriving (Eq, Show)

makeClassy ''Service

instance FromJSON a => FromJSON (Service a) where
    parseJSON = withObject "service" $ \o -> Service
        <$> (o .:  "library"       <&> renameLibrary)
        <*> (o .:  "canonicalName" <&> upperHead . renameAbbrev)
        <*>  o .:  "ownerName"
        <*>  o .:  "ownerDomain"
        <*>  o .:? "packagePath"
        <*> parseJSON (A.Object o)

instance HasDescription (Service a) a where
    description = sDescription

urlName :: Service a -> Text
urlName = (<> "URL") . lowerHead . _sCanonicalName
