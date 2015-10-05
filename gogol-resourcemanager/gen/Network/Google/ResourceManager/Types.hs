{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE NoImplicitPrelude  #-}
{-# LANGUAGE OverloadedStrings  #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- |
-- Module      : Network.Google.ResourceManager.Types
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
module Network.Google.ResourceManager.Types
    (
    -- * Service URL
      resourceManagerURL

    -- * ResourceId
    , ResourceId
    , resourceId
    , riId
    , riType

    -- * ListProjectsResponse
    , ListProjectsResponse
    , listProjectsResponse
    , lprNextPageToken
    , lprProjects

    -- * GetIAMPolicyRequest
    , GetIAMPolicyRequest
    , getIAMPolicyRequest

    -- * OrganizationOwner
    , OrganizationOwner
    , organizationOwner
    , ooDirectoryCustomerId

    -- * Project
    , Project
    , project
    , pParent
    , pProjectNumber
    , pName
    , pLabels
    , pProjectId
    , pLifecycleState
    , pCreateTime

    -- * Empty
    , Empty
    , empty

    -- * SetIAMPolicyRequest
    , SetIAMPolicyRequest
    , setIAMPolicyRequest
    , siprPolicy

    -- * TestIAMPermissionsRequest
    , TestIAMPermissionsRequest
    , testIAMPermissionsRequest
    , tiprPermissions

    -- * TestIAMPermissionsResponse
    , TestIAMPermissionsResponse
    , testIAMPermissionsResponse
    , tiamprPermissions

    -- * Policy
    , Policy
    , policy
    , pEtag
    , pVersion
    , pBindings

    -- * ProjectLabels
    , ProjectLabels
    , projectLabels

    -- * Organization
    , Organization
    , organization
    , oOwner
    , oDisplayName
    , oOrganizationId

    -- * Binding
    , Binding
    , binding
    , bMembers
    , bRole

    -- * ListOrganizationsResponse
    , ListOrganizationsResponse
    , listOrganizationsResponse
    , lorNextPageToken
    , lorOrganizations
    ) where

import           Network.Google.Prelude
import           Network.Google.ResourceManager.Types.Product
import           Network.Google.ResourceManager.Types.Sum

-- | URL referring to version 'v1beta1' of the Google Cloud Resource Manager API.
resourceManagerURL :: BaseUrl
resourceManagerURL
  = BaseUrl Https
      "https://cloudresourcemanager.googleapis.com/"
      443
