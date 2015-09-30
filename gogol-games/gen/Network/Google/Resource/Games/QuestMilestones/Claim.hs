{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}
{-# LANGUAGE TypeOperators      #-}

{-# OPTIONS_GHC -fno-warn-unused-imports    #-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports #-}

-- |
-- Module      : Network.Google.Resource.Games.QuestMilestones.Claim
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- | Report that a reward for the milestone corresponding to milestoneId for
-- the quest corresponding to questId has been claimed by the currently
-- authorized user.
--
-- /See:/ <https://developers.google.com/games/services/ Google Play Game Services API Reference> for @GamesQuestMilestonesClaim@.
module Network.Google.Resource.Games.QuestMilestones.Claim
    (
    -- * REST Resource
      QuestMilestonesClaimResource

    -- * Creating a Request
    , questMilestonesClaim'
    , QuestMilestonesClaim'

    -- * Request Lenses
    , qmcRequestId
    , qmcQuotaUser
    , qmcPrettyPrint
    , qmcUserIp
    , qmcMilestoneId
    , qmcKey
    , qmcOauthToken
    , qmcQuestId
    , qmcFields
    , qmcAlt
    ) where

import           Network.Google.Games.Types
import           Network.Google.Prelude

-- | A resource alias for @GamesQuestMilestonesClaim@ which the
-- 'QuestMilestonesClaim'' request conforms to.
type QuestMilestonesClaimResource =
     "quests" :>
       Capture "questId" Text :>
         "milestones" :>
           Capture "milestoneId" Text :>
             "claim" :>
               QueryParam "requestId" Int64 :>
                 QueryParam "quotaUser" Text :>
                   QueryParam "prettyPrint" Bool :>
                     QueryParam "userIp" Text :>
                       QueryParam "key" Text :>
                         QueryParam "oauth_token" Text :>
                           QueryParam "fields" Text :>
                             QueryParam "alt" Alt :> Put '[JSON] ()

-- | Report that a reward for the milestone corresponding to milestoneId for
-- the quest corresponding to questId has been claimed by the currently
-- authorized user.
--
-- /See:/ 'questMilestonesClaim'' smart constructor.
data QuestMilestonesClaim' = QuestMilestonesClaim'
    { _qmcRequestId   :: !Int64
    , _qmcQuotaUser   :: !(Maybe Text)
    , _qmcPrettyPrint :: !Bool
    , _qmcUserIp      :: !(Maybe Text)
    , _qmcMilestoneId :: !Text
    , _qmcKey         :: !(Maybe Text)
    , _qmcOauthToken  :: !(Maybe Text)
    , _qmcQuestId     :: !Text
    , _qmcFields      :: !(Maybe Text)
    , _qmcAlt         :: !Alt
    } deriving (Eq,Read,Show,Data,Typeable,Generic)

-- | Creates a value of 'QuestMilestonesClaim'' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'qmcRequestId'
--
-- * 'qmcQuotaUser'
--
-- * 'qmcPrettyPrint'
--
-- * 'qmcUserIp'
--
-- * 'qmcMilestoneId'
--
-- * 'qmcKey'
--
-- * 'qmcOauthToken'
--
-- * 'qmcQuestId'
--
-- * 'qmcFields'
--
-- * 'qmcAlt'
questMilestonesClaim'
    :: Int64 -- ^ 'requestId'
    -> Text -- ^ 'milestoneId'
    -> Text -- ^ 'questId'
    -> QuestMilestonesClaim'
questMilestonesClaim' pQmcRequestId_ pQmcMilestoneId_ pQmcQuestId_ =
    QuestMilestonesClaim'
    { _qmcRequestId = pQmcRequestId_
    , _qmcQuotaUser = Nothing
    , _qmcPrettyPrint = True
    , _qmcUserIp = Nothing
    , _qmcMilestoneId = pQmcMilestoneId_
    , _qmcKey = Nothing
    , _qmcOauthToken = Nothing
    , _qmcQuestId = pQmcQuestId_
    , _qmcFields = Nothing
    , _qmcAlt = JSON
    }

-- | A numeric ID to ensure that the request is handled correctly across
-- retries. Your client application must generate this ID randomly.
qmcRequestId :: Lens' QuestMilestonesClaim' Int64
qmcRequestId
  = lens _qmcRequestId (\ s a -> s{_qmcRequestId = a})

-- | Available to use for quota purposes for server-side applications. Can be
-- any arbitrary string assigned to a user, but should not exceed 40
-- characters. Overrides userIp if both are provided.
qmcQuotaUser :: Lens' QuestMilestonesClaim' (Maybe Text)
qmcQuotaUser
  = lens _qmcQuotaUser (\ s a -> s{_qmcQuotaUser = a})

-- | Returns response with indentations and line breaks.
qmcPrettyPrint :: Lens' QuestMilestonesClaim' Bool
qmcPrettyPrint
  = lens _qmcPrettyPrint
      (\ s a -> s{_qmcPrettyPrint = a})

-- | IP address of the site where the request originates. Use this if you
-- want to enforce per-user limits.
qmcUserIp :: Lens' QuestMilestonesClaim' (Maybe Text)
qmcUserIp
  = lens _qmcUserIp (\ s a -> s{_qmcUserIp = a})

-- | The ID of the milestone.
qmcMilestoneId :: Lens' QuestMilestonesClaim' Text
qmcMilestoneId
  = lens _qmcMilestoneId
      (\ s a -> s{_qmcMilestoneId = a})

-- | API key. Your API key identifies your project and provides you with API
-- access, quota, and reports. Required unless you provide an OAuth 2.0
-- token.
qmcKey :: Lens' QuestMilestonesClaim' (Maybe Text)
qmcKey = lens _qmcKey (\ s a -> s{_qmcKey = a})

-- | OAuth 2.0 token for the current user.
qmcOauthToken :: Lens' QuestMilestonesClaim' (Maybe Text)
qmcOauthToken
  = lens _qmcOauthToken
      (\ s a -> s{_qmcOauthToken = a})

-- | The ID of the quest.
qmcQuestId :: Lens' QuestMilestonesClaim' Text
qmcQuestId
  = lens _qmcQuestId (\ s a -> s{_qmcQuestId = a})

-- | Selector specifying which fields to include in a partial response.
qmcFields :: Lens' QuestMilestonesClaim' (Maybe Text)
qmcFields
  = lens _qmcFields (\ s a -> s{_qmcFields = a})

-- | Data format for the response.
qmcAlt :: Lens' QuestMilestonesClaim' Alt
qmcAlt = lens _qmcAlt (\ s a -> s{_qmcAlt = a})

instance GoogleRequest QuestMilestonesClaim' where
        type Rs QuestMilestonesClaim' = ()
        request = requestWithRoute defReq gamesURL
        requestWithRoute r u QuestMilestonesClaim'{..}
          = go (Just _qmcRequestId) _qmcQuotaUser
              (Just _qmcPrettyPrint)
              _qmcUserIp
              _qmcMilestoneId
              _qmcKey
              _qmcOauthToken
              _qmcQuestId
              _qmcFields
              (Just _qmcAlt)
          where go
                  = clientWithRoute
                      (Proxy :: Proxy QuestMilestonesClaimResource)
                      r
                      u