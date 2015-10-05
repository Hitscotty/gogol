{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE FlexibleInstances  #-}
{-# LANGUAGE NoImplicitPrelude  #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}
{-# LANGUAGE TypeOperators      #-}

{-# OPTIONS_GHC -fno-warn-unused-imports    #-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports #-}

-- |
-- Module      : Network.Google.Resource.DFAReporting.CreativeFieldValues.Patch
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- | Updates an existing creative field value. This method supports patch
-- semantics.
--
-- /See:/ <https://developers.google.com/doubleclick-advertisers/reporting/ DCM/DFA Reporting And Trafficking API Reference> for @DfareportingCreativeFieldValuesPatch@.
module Network.Google.Resource.DFAReporting.CreativeFieldValues.Patch
    (
    -- * REST Resource
      CreativeFieldValuesPatchResource

    -- * Creating a Request
    , creativeFieldValuesPatch'
    , CreativeFieldValuesPatch'

    -- * Request Lenses
    , cfvpCreativeFieldId
    , cfvpQuotaUser
    , cfvpPrettyPrint
    , cfvpUserIP
    , cfvpProFileId
    , cfvpPayload
    , cfvpKey
    , cfvpId
    , cfvpOAuthToken
    , cfvpFields
    ) where

import           Network.Google.DFAReporting.Types
import           Network.Google.Prelude

-- | A resource alias for @DfareportingCreativeFieldValuesPatch@ which the
-- 'CreativeFieldValuesPatch'' request conforms to.
type CreativeFieldValuesPatchResource =
     "userprofiles" :>
       Capture "profileId" Int64 :>
         "creativeFields" :>
           Capture "creativeFieldId" Int64 :>
             "creativeFieldValues" :>
               QueryParam "id" Int64 :>
                 QueryParam "quotaUser" Text :>
                   QueryParam "prettyPrint" Bool :>
                     QueryParam "userIp" Text :>
                       QueryParam "fields" Text :>
                         QueryParam "key" Key :>
                           QueryParam "oauth_token" OAuthToken :>
                             QueryParam "alt" AltJSON :>
                               ReqBody '[JSON] CreativeFieldValue :>
                                 Patch '[JSON] CreativeFieldValue

-- | Updates an existing creative field value. This method supports patch
-- semantics.
--
-- /See:/ 'creativeFieldValuesPatch'' smart constructor.
data CreativeFieldValuesPatch' = CreativeFieldValuesPatch'
    { _cfvpCreativeFieldId :: !Int64
    , _cfvpQuotaUser       :: !(Maybe Text)
    , _cfvpPrettyPrint     :: !Bool
    , _cfvpUserIP          :: !(Maybe Text)
    , _cfvpProFileId       :: !Int64
    , _cfvpPayload         :: !CreativeFieldValue
    , _cfvpKey             :: !(Maybe Key)
    , _cfvpId              :: !Int64
    , _cfvpOAuthToken      :: !(Maybe OAuthToken)
    , _cfvpFields          :: !(Maybe Text)
    } deriving (Eq,Show,Data,Typeable,Generic)

-- | Creates a value of 'CreativeFieldValuesPatch'' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'cfvpCreativeFieldId'
--
-- * 'cfvpQuotaUser'
--
-- * 'cfvpPrettyPrint'
--
-- * 'cfvpUserIP'
--
-- * 'cfvpProFileId'
--
-- * 'cfvpPayload'
--
-- * 'cfvpKey'
--
-- * 'cfvpId'
--
-- * 'cfvpOAuthToken'
--
-- * 'cfvpFields'
creativeFieldValuesPatch'
    :: Int64 -- ^ 'creativeFieldId'
    -> Int64 -- ^ 'profileId'
    -> CreativeFieldValue -- ^ 'payload'
    -> Int64 -- ^ 'id'
    -> CreativeFieldValuesPatch'
creativeFieldValuesPatch' pCfvpCreativeFieldId_ pCfvpProFileId_ pCfvpPayload_ pCfvpId_ =
    CreativeFieldValuesPatch'
    { _cfvpCreativeFieldId = pCfvpCreativeFieldId_
    , _cfvpQuotaUser = Nothing
    , _cfvpPrettyPrint = True
    , _cfvpUserIP = Nothing
    , _cfvpProFileId = pCfvpProFileId_
    , _cfvpPayload = pCfvpPayload_
    , _cfvpKey = Nothing
    , _cfvpId = pCfvpId_
    , _cfvpOAuthToken = Nothing
    , _cfvpFields = Nothing
    }

-- | Creative field ID for this creative field value.
cfvpCreativeFieldId :: Lens' CreativeFieldValuesPatch' Int64
cfvpCreativeFieldId
  = lens _cfvpCreativeFieldId
      (\ s a -> s{_cfvpCreativeFieldId = a})

-- | Available to use for quota purposes for server-side applications. Can be
-- any arbitrary string assigned to a user, but should not exceed 40
-- characters. Overrides userIp if both are provided.
cfvpQuotaUser :: Lens' CreativeFieldValuesPatch' (Maybe Text)
cfvpQuotaUser
  = lens _cfvpQuotaUser
      (\ s a -> s{_cfvpQuotaUser = a})

-- | Returns response with indentations and line breaks.
cfvpPrettyPrint :: Lens' CreativeFieldValuesPatch' Bool
cfvpPrettyPrint
  = lens _cfvpPrettyPrint
      (\ s a -> s{_cfvpPrettyPrint = a})

-- | IP address of the site where the request originates. Use this if you
-- want to enforce per-user limits.
cfvpUserIP :: Lens' CreativeFieldValuesPatch' (Maybe Text)
cfvpUserIP
  = lens _cfvpUserIP (\ s a -> s{_cfvpUserIP = a})

-- | User profile ID associated with this request.
cfvpProFileId :: Lens' CreativeFieldValuesPatch' Int64
cfvpProFileId
  = lens _cfvpProFileId
      (\ s a -> s{_cfvpProFileId = a})

-- | Multipart request metadata.
cfvpPayload :: Lens' CreativeFieldValuesPatch' CreativeFieldValue
cfvpPayload
  = lens _cfvpPayload (\ s a -> s{_cfvpPayload = a})

-- | API key. Your API key identifies your project and provides you with API
-- access, quota, and reports. Required unless you provide an OAuth 2.0
-- token.
cfvpKey :: Lens' CreativeFieldValuesPatch' (Maybe Key)
cfvpKey = lens _cfvpKey (\ s a -> s{_cfvpKey = a})

-- | Creative Field Value ID
cfvpId :: Lens' CreativeFieldValuesPatch' Int64
cfvpId = lens _cfvpId (\ s a -> s{_cfvpId = a})

-- | OAuth 2.0 token for the current user.
cfvpOAuthToken :: Lens' CreativeFieldValuesPatch' (Maybe OAuthToken)
cfvpOAuthToken
  = lens _cfvpOAuthToken
      (\ s a -> s{_cfvpOAuthToken = a})

-- | Selector specifying which fields to include in a partial response.
cfvpFields :: Lens' CreativeFieldValuesPatch' (Maybe Text)
cfvpFields
  = lens _cfvpFields (\ s a -> s{_cfvpFields = a})

instance GoogleAuth CreativeFieldValuesPatch' where
        authKey = cfvpKey . _Just
        authToken = cfvpOAuthToken . _Just

instance GoogleRequest CreativeFieldValuesPatch'
         where
        type Rs CreativeFieldValuesPatch' =
             CreativeFieldValue
        request = requestWithRoute defReq dFAReportingURL
        requestWithRoute r u CreativeFieldValuesPatch'{..}
          = go _cfvpProFileId _cfvpCreativeFieldId
              (Just _cfvpId)
              _cfvpQuotaUser
              (Just _cfvpPrettyPrint)
              _cfvpUserIP
              _cfvpFields
              _cfvpKey
              _cfvpOAuthToken
              (Just AltJSON)
              _cfvpPayload
          where go
                  = clientWithRoute
                      (Proxy :: Proxy CreativeFieldValuesPatchResource)
                      r
                      u
