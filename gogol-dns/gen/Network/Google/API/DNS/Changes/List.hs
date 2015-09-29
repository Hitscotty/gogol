{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}
{-# LANGUAGE TypeOperators      #-}

{-# OPTIONS_GHC -fno-warn-unused-imports    #-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports #-}

-- |
-- Module      : Network.Google.API.DNS.Changes.List
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- | Enumerate Changes to a ResourceRecordSet collection.
--
-- /See:/ <https://developers.google.com/cloud-dns Google Cloud DNS API Reference> for @dns.changes.list@.
module Network.Google.API.DNS.Changes.List
    (
    -- * REST Resource
      ChangesListAPI

    -- * Creating a Request
    , changesList'
    , ChangesList'

    -- * Request Lenses
    , clQuotaUser
    , clPrettyPrint
    , clProject
    , clUserIp
    , clSortOrder
    , clKey
    , clPageToken
    , clOauthToken
    , clManagedZone
    , clMaxResults
    , clFields
    , clAlt
    , clSortBy
    ) where

import           Network.Google.DNS.Types
import           Network.Google.Prelude

-- | A resource alias for dns.changes.list which the
-- 'ChangesList'' request conforms to.
type ChangesListAPI =
     Capture "project" Text :>
       "managedZones" :>
         Capture "managedZone" Text :>
           "changes" :>
             QueryParam "quotaUser" Text :>
               QueryParam "prettyPrint" Bool :>
                 QueryParam "userIp" Text :>
                   QueryParam "sortOrder" Text :>
                     QueryParam "key" Text :>
                       QueryParam "pageToken" Text :>
                         QueryParam "oauth_token" Text :>
                           QueryParam "maxResults" Int32 :>
                             QueryParam "fields" Text :>
                               QueryParam "alt" Alt :>
                                 QueryParam "sortBy" ChangesList'SortBy :>
                                   Get '[JSON] ChangesListResponse

-- | Enumerate Changes to a ResourceRecordSet collection.
--
-- /See:/ 'changesList'' smart constructor.
data ChangesList' = ChangesList'
    { _clQuotaUser   :: !(Maybe Text)
    , _clPrettyPrint :: !Bool
    , _clProject     :: !Text
    , _clUserIp      :: !(Maybe Text)
    , _clSortOrder   :: !(Maybe Text)
    , _clKey         :: !(Maybe Text)
    , _clPageToken   :: !(Maybe Text)
    , _clOauthToken  :: !(Maybe Text)
    , _clManagedZone :: !Text
    , _clMaxResults  :: !(Maybe Int32)
    , _clFields      :: !(Maybe Text)
    , _clAlt         :: !Alt
    , _clSortBy      :: !ChangesList'SortBy
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'ChangesList'' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'clQuotaUser'
--
-- * 'clPrettyPrint'
--
-- * 'clProject'
--
-- * 'clUserIp'
--
-- * 'clSortOrder'
--
-- * 'clKey'
--
-- * 'clPageToken'
--
-- * 'clOauthToken'
--
-- * 'clManagedZone'
--
-- * 'clMaxResults'
--
-- * 'clFields'
--
-- * 'clAlt'
--
-- * 'clSortBy'
changesList'
    :: Text -- ^ 'project'
    -> Text -- ^ 'managedZone'
    -> ChangesList'
changesList' pClProject_ pClManagedZone_ =
    ChangesList'
    { _clQuotaUser = Nothing
    , _clPrettyPrint = True
    , _clProject = pClProject_
    , _clUserIp = Nothing
    , _clSortOrder = Nothing
    , _clKey = Nothing
    , _clPageToken = Nothing
    , _clOauthToken = Nothing
    , _clManagedZone = pClManagedZone_
    , _clMaxResults = Nothing
    , _clFields = Nothing
    , _clAlt = JSON
    , _clSortBy = ChangeSequence
    }

-- | Available to use for quota purposes for server-side applications. Can be
-- any arbitrary string assigned to a user, but should not exceed 40
-- characters. Overrides userIp if both are provided.
clQuotaUser :: Lens' ChangesList' (Maybe Text)
clQuotaUser
  = lens _clQuotaUser (\ s a -> s{_clQuotaUser = a})

-- | Returns response with indentations and line breaks.
clPrettyPrint :: Lens' ChangesList' Bool
clPrettyPrint
  = lens _clPrettyPrint
      (\ s a -> s{_clPrettyPrint = a})

-- | Identifies the project addressed by this request.
clProject :: Lens' ChangesList' Text
clProject
  = lens _clProject (\ s a -> s{_clProject = a})

-- | IP address of the site where the request originates. Use this if you
-- want to enforce per-user limits.
clUserIp :: Lens' ChangesList' (Maybe Text)
clUserIp = lens _clUserIp (\ s a -> s{_clUserIp = a})

-- | Sorting order direction: \'ascending\' or \'descending\'.
clSortOrder :: Lens' ChangesList' (Maybe Text)
clSortOrder
  = lens _clSortOrder (\ s a -> s{_clSortOrder = a})

-- | API key. Your API key identifies your project and provides you with API
-- access, quota, and reports. Required unless you provide an OAuth 2.0
-- token.
clKey :: Lens' ChangesList' (Maybe Text)
clKey = lens _clKey (\ s a -> s{_clKey = a})

-- | Optional. A tag returned by a previous list request that was truncated.
-- Use this parameter to continue a previous list request.
clPageToken :: Lens' ChangesList' (Maybe Text)
clPageToken
  = lens _clPageToken (\ s a -> s{_clPageToken = a})

-- | OAuth 2.0 token for the current user.
clOauthToken :: Lens' ChangesList' (Maybe Text)
clOauthToken
  = lens _clOauthToken (\ s a -> s{_clOauthToken = a})

-- | Identifies the managed zone addressed by this request. Can be the
-- managed zone name or id.
clManagedZone :: Lens' ChangesList' Text
clManagedZone
  = lens _clManagedZone
      (\ s a -> s{_clManagedZone = a})

-- | Optional. Maximum number of results to be returned. If unspecified, the
-- server will decide how many results to return.
clMaxResults :: Lens' ChangesList' (Maybe Int32)
clMaxResults
  = lens _clMaxResults (\ s a -> s{_clMaxResults = a})

-- | Selector specifying which fields to include in a partial response.
clFields :: Lens' ChangesList' (Maybe Text)
clFields = lens _clFields (\ s a -> s{_clFields = a})

-- | Data format for the response.
clAlt :: Lens' ChangesList' Alt
clAlt = lens _clAlt (\ s a -> s{_clAlt = a})

-- | Sorting criterion. The only supported value is change sequence.
clSortBy :: Lens' ChangesList' ChangesList'SortBy
clSortBy = lens _clSortBy (\ s a -> s{_clSortBy = a})

instance GoogleRequest ChangesList' where
        type Rs ChangesList' = ChangesListResponse
        request = requestWithRoute defReq dNSURL
        requestWithRoute r u ChangesList'{..}
          = go _clQuotaUser (Just _clPrettyPrint) _clProject
              _clUserIp
              _clSortOrder
              _clKey
              _clPageToken
              _clOauthToken
              _clManagedZone
              _clMaxResults
              _clFields
              (Just _clAlt)
              (Just _clSortBy)
          where go
                  = clientWithRoute (Proxy :: Proxy ChangesListAPI) r u