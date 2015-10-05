{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE NoImplicitPrelude  #-}
{-# LANGUAGE OverloadedStrings  #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- |
-- Module      : Network.Google.AdminReports.Types
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
module Network.Google.AdminReports.Types
    (
    -- * Service URL
      adminReportsURL

    -- * UsageReportParametersItem
    , UsageReportParametersItem
    , usageReportParametersItem
    , urpiDatetimeValue
    , urpiBoolValue
    , urpiIntValue
    , urpiStringValue
    , urpiName
    , urpiMsgValue

    -- * ActivityId
    , ActivityId
    , activityId
    , aiTime
    , aiUniqueQualifier
    , aiCustomerId
    , aiApplicationName

    -- * UsageReports
    , UsageReports
    , usageReports
    , urEtag
    , urNextPageToken
    , urUsageReports
    , urKind
    , urWarnings

    -- * UsageReportParametersItemMsgValueItem
    , UsageReportParametersItemMsgValueItem
    , usageReportParametersItemMsgValueItem

    -- * Activities
    , Activities
    , activities
    , aEtag
    , aNextPageToken
    , aKind
    , aItems

    -- * Channel
    , Channel
    , channel
    , cResourceURI
    , cResourceId
    , cKind
    , cExpiration
    , cToken
    , cAddress
    , cPayload
    , cParams
    , cId
    , cType

    -- * UsageReport
    , UsageReport
    , usageReport
    , uEtag
    , uKind
    , uDate
    , uParameters
    , uEntity

    -- * UsageReportsWarningsItemDataItem
    , UsageReportsWarningsItemDataItem
    , usageReportsWarningsItemDataItem
    , urwidiValue
    , urwidiKey

    -- * UsageReportsWarningsItem
    , UsageReportsWarningsItem
    , usageReportsWarningsItem
    , urwiData
    , urwiCode
    , urwiMessage

    -- * ActivityEventsItem
    , ActivityEventsItem
    , activityEventsItem
    , aeiName
    , aeiParameters
    , aeiType

    -- * ChannelParams
    , ChannelParams
    , channelParams

    -- * Activity
    , Activity
    , activity
    , actEtag
    , actIPAddress
    , actKind
    , actActor
    , actOwnerDomain
    , actEvents
    , actId

    -- * UsageReportEntity
    , UsageReportEntity
    , usageReportEntity
    , ureProFileId
    , ureCustomerId
    , ureUserEmail
    , ureType

    -- * ActivityEventsItemParametersItem
    , ActivityEventsItemParametersItem
    , activityEventsItemParametersItem
    , aeipiBoolValue
    , aeipiIntValue
    , aeipiValue
    , aeipiMultiIntValue
    , aeipiName
    , aeipiMultiValue

    -- * ActivityActor
    , ActivityActor
    , activityActor
    , aaEmail
    , aaCallerType
    , aaProFileId
    , aaKey
    ) where

import           Network.Google.AdminReports.Types.Product
import           Network.Google.AdminReports.Types.Sum
import           Network.Google.Prelude

-- | URL referring to version 'reports_v1' of the Admin Reports API.
adminReportsURL :: BaseUrl
adminReportsURL
  = BaseUrl Https
      "https://www.googleapis.com/admin/reports/v1/"
      443
