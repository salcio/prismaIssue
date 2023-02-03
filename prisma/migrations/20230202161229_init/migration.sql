-- CreateTable
CREATE TABLE "AppSetting" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "key" VARCHAR(500) NOT NULL,
    "value" VARCHAR NOT NULL,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "AppSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntityHistory" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "entityId" UUID NOT NULL,
    "entityTable" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "changeDate" TEXT NOT NULL,
    "changeUserId" UUID NOT NULL,
    "changedProperties" TEXT NOT NULL,
    "entity" TEXT NOT NULL,

    CONSTRAINT "EntityHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" VARCHAR(255) NOT NULL,
    "email" TEXT,
    "providerId" VARCHAR(255) NOT NULL,
    "organisationId" UUID,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',
    "username" VARCHAR(255) NOT NULL,
    "givenName" VARCHAR(255),
    "surname" VARCHAR(255),

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Organisation" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" VARCHAR(255) NOT NULL,
    "providerId" VARCHAR(255),
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "Organisation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,
    "providerId" VARCHAR(255) NOT NULL,
    "tcpPrefix" TEXT,
    "applicationId" UUID,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',
    "groupCode" TEXT,
    "order" INTEGER NOT NULL DEFAULT 100,
    "providerName" TEXT,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserGroups" (
    "userId" UUID NOT NULL,
    "groupId" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "UserGroups_pkey" PRIMARY KEY ("groupId","userId")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "providerProfile" TEXT NOT NULL,
    "bio" TEXT,
    "userId" UUID NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,

    CONSTRAINT "Profile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScheduledTaskRunLog" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "handlerType" TEXT,
    "schedulerType" TEXT,
    "cronTime" TEXT,
    "interval" INTEGER,
    "timeout" INTEGER,
    "dependsOnTimeoutTaskId" UUID,
    "scheduledTaskId" TEXT NOT NULL,
    "runId" TEXT NOT NULL,
    "correlationId" TEXT,
    "state" TEXT NOT NULL,
    "runStarted" TIMESTAMP(3) NOT NULL,
    "runFinished" TIMESTAMP(3),
    "detailsJson" VARCHAR,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',
    "logStreamId" UUID,

    CONSTRAINT "ScheduledTaskRunLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LogStream" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "entries" VARCHAR NOT NULL,

    CONSTRAINT "LogStream_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SyncLog" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "type" TEXT NOT NULL,
    "target" TEXT NOT NULL,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',
    "actionName" TEXT,
    "scheduledTaskRunLogId" UUID,
    "parentSyncLogId" UUID,
    "state" TEXT NOT NULL DEFAULT '',
    "finished" TIMESTAMP(3),
    "started" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "logStreamId" UUID,
    "deltaLink" VARCHAR,
    "deltaLinkSourcedFromId" UUID,
    "deltaLinkUsedAt" TIMESTAMP(3),
    "sourceDeltaLink" VARCHAR,
    "deltaLinkRetiredById" UUID,

    CONSTRAINT "SyncLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,
    "url" TEXT,
    "tcpPrefix" TEXT,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',
    "order" INTEGER NOT NULL DEFAULT 100,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationOwner" (
    "applicationId" UUID NOT NULL,
    "groupId" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "ApplicationOwner_pkey" PRIMARY KEY ("groupId","applicationId")
);

-- CreateTable
CREATE TABLE "GroupManager" (
    "managerId" UUID NOT NULL,
    "groupId" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "GroupManager_pkey" PRIMARY KEY ("groupId","managerId")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "isTrusted" BOOLEAN NOT NULL,
    "clientSecretHash" TEXT NOT NULL,
    "clientSecretHint" TEXT NOT NULL,
    "clientSecretSalt" TEXT NOT NULL,
    "authenticationUrl" TEXT,
    "grantTypes" TEXT,
    "postLogoutRedirectUri" TEXT,
    "responseTypes" TEXT,
    "allowedCorsOrigins" TEXT,
    "tokenEndpointAuthMethod" TEXT,
    "applicationType" TEXT,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ReturnUrl" (
    "clientId" UUID NOT NULL,
    "url" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "OAuthProviderModel" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "uid" TEXT,
    "grantId" TEXT,
    "userCode" TEXT,
    "kind" TEXT NOT NULL,
    "consumed" INTEGER,
    "payload" VARCHAR NOT NULL,
    "expiry" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "OAuthProviderModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationClients" (
    "clientId" UUID NOT NULL,
    "applicationId" UUID NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,

    CONSTRAINT "ApplicationClients_pkey" PRIMARY KEY ("clientId","applicationId")
);

-- CreateTable
CREATE TABLE "ResourceProfile" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,
    "applicationId" UUID NOT NULL,

    CONSTRAINT "ResourceProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuthorisationProfile" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,
    "resourceProfileId" UUID NOT NULL,

    CONSTRAINT "AuthorisationProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Authorisation" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "parentId" UUID,
    "resourceId" UUID NOT NULL,
    "resourceAttributeValues" VARCHAR NOT NULL,
    "parentAttributeValuesPropertyOperators" TEXT,
    "authorisationProfileId" UUID NOT NULL,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT NOW(),
    "validTo" TIMESTAMP(3) NOT NULL DEFAULT NOW() + interval '1 year',

    CONSTRAINT "Authorisation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuthorisationAction" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,

    CONSTRAINT "AuthorisationAction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Resource" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "key" TEXT NOT NULL,
    "label" TEXT NOT NULL,

    CONSTRAINT "Resource_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubResource" (
    "parentId" UUID NOT NULL,
    "childId" UUID NOT NULL,
    "childNavigationPropertyName" TEXT NOT NULL,

    CONSTRAINT "SubResource_pkey" PRIMARY KEY ("parentId","childId")
);

-- CreateTable
CREATE TABLE "ResourceAttribute" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "scriptId" UUID,

    CONSTRAINT "ResourceAttribute_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Script" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "createdBy" TEXT NOT NULL,
    "updatedBy" TEXT,
    "text" VARCHAR NOT NULL,

    CONSTRAINT "Script_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_AuthorisationProfileToClient" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_AuthorisationProfileToGroup" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_AuthorisationProfileToUser" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_AuthorisationToAuthorisationAction" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_ResourceToResourceAttribute" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateTable
CREATE TABLE "_ResourceToResourceProfile" (
    "A" UUID NOT NULL,
    "B" UUID NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "AppSetting_key_key" ON "AppSetting"("key");

-- CreateIndex
CREATE UNIQUE INDEX "User_providerId_key" ON "User"("providerId");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Organisation_name_key" ON "Organisation"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Organisation_providerId_key" ON "Organisation"("providerId");

-- CreateIndex
CREATE UNIQUE INDEX "Group_name_key" ON "Group"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Group_providerId_key" ON "Group"("providerId");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Application_name_key" ON "Application"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Client_clientId_key" ON "Client"("clientId");

-- CreateIndex
CREATE UNIQUE INDEX "ReturnUrl_clientId_url_key" ON "ReturnUrl"("clientId", "url");

-- CreateIndex
CREATE UNIQUE INDEX "ResourceProfile_name_key" ON "ResourceProfile"("name");

-- CreateIndex
CREATE UNIQUE INDEX "AuthorisationProfile_name_key" ON "AuthorisationProfile"("name");

-- CreateIndex
CREATE UNIQUE INDEX "AuthorisationAction_name_key" ON "AuthorisationAction"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Resource_key_key" ON "Resource"("key");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorisationProfileToClient_AB_unique" ON "_AuthorisationProfileToClient"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorisationProfileToClient_B_index" ON "_AuthorisationProfileToClient"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorisationProfileToGroup_AB_unique" ON "_AuthorisationProfileToGroup"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorisationProfileToGroup_B_index" ON "_AuthorisationProfileToGroup"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorisationProfileToUser_AB_unique" ON "_AuthorisationProfileToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorisationProfileToUser_B_index" ON "_AuthorisationProfileToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorisationToAuthorisationAction_AB_unique" ON "_AuthorisationToAuthorisationAction"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorisationToAuthorisationAction_B_index" ON "_AuthorisationToAuthorisationAction"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ResourceToResourceAttribute_AB_unique" ON "_ResourceToResourceAttribute"("A", "B");

-- CreateIndex
CREATE INDEX "_ResourceToResourceAttribute_B_index" ON "_ResourceToResourceAttribute"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ResourceToResourceProfile_AB_unique" ON "_ResourceToResourceProfile"("A", "B");

-- CreateIndex
CREATE INDEX "_ResourceToResourceProfile_B_index" ON "_ResourceToResourceProfile"("B");

-- AddForeignKey
ALTER TABLE "EntityHistory" ADD CONSTRAINT "EntityHistory_changeUserId_fkey" FOREIGN KEY ("changeUserId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_organisationId_fkey" FOREIGN KEY ("organisationId") REFERENCES "Organisation"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserGroups" ADD CONSTRAINT "UserGroups_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserGroups" ADD CONSTRAINT "UserGroups_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduledTaskRunLog" ADD CONSTRAINT "ScheduledTaskRunLog_logStreamId_fkey" FOREIGN KEY ("logStreamId") REFERENCES "LogStream"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SyncLog" ADD CONSTRAINT "SyncLog_deltaLinkRetiredById_fkey" FOREIGN KEY ("deltaLinkRetiredById") REFERENCES "SyncLog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SyncLog" ADD CONSTRAINT "SyncLog_deltaLinkSourcedFromId_fkey" FOREIGN KEY ("deltaLinkSourcedFromId") REFERENCES "SyncLog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SyncLog" ADD CONSTRAINT "SyncLog_logStreamId_fkey" FOREIGN KEY ("logStreamId") REFERENCES "LogStream"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SyncLog" ADD CONSTRAINT "SyncLog_parentSyncLogId_fkey" FOREIGN KEY ("parentSyncLogId") REFERENCES "SyncLog"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SyncLog" ADD CONSTRAINT "SyncLog_scheduledTaskRunLogId_fkey" FOREIGN KEY ("scheduledTaskRunLogId") REFERENCES "ScheduledTaskRunLog"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationOwner" ADD CONSTRAINT "ApplicationOwner_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ApplicationOwner" ADD CONSTRAINT "ApplicationOwner_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupManager" ADD CONSTRAINT "GroupManager_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "GroupManager" ADD CONSTRAINT "GroupManager_managerId_fkey" FOREIGN KEY ("managerId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ReturnUrl" ADD CONSTRAINT "ReturnUrl_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationClients" ADD CONSTRAINT "ApplicationClients_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationClients" ADD CONSTRAINT "ApplicationClients_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ResourceProfile" ADD CONSTRAINT "ResourceProfile_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuthorisationProfile" ADD CONSTRAINT "AuthorisationProfile_resourceProfileId_fkey" FOREIGN KEY ("resourceProfileId") REFERENCES "ResourceProfile"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Authorisation" ADD CONSTRAINT "Authorisation_authorisationProfileId_fkey" FOREIGN KEY ("authorisationProfileId") REFERENCES "AuthorisationProfile"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Authorisation" ADD CONSTRAINT "Authorisation_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Authorisation"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Authorisation" ADD CONSTRAINT "Authorisation_resourceId_fkey" FOREIGN KEY ("resourceId") REFERENCES "Resource"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SubResource" ADD CONSTRAINT "SubResource_childId_fkey" FOREIGN KEY ("childId") REFERENCES "Resource"("id") ON DELETE RESTRICT ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "SubResource" ADD CONSTRAINT "SubResource_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Resource"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ResourceAttribute" ADD CONSTRAINT "ResourceAttribute_scriptId_fkey" FOREIGN KEY ("scriptId") REFERENCES "Script"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "_AuthorisationProfileToClient" ADD CONSTRAINT "_AuthorisationProfileToClient_A_fkey" FOREIGN KEY ("A") REFERENCES "AuthorisationProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationProfileToClient" ADD CONSTRAINT "_AuthorisationProfileToClient_B_fkey" FOREIGN KEY ("B") REFERENCES "Client"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationProfileToGroup" ADD CONSTRAINT "_AuthorisationProfileToGroup_A_fkey" FOREIGN KEY ("A") REFERENCES "AuthorisationProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationProfileToGroup" ADD CONSTRAINT "_AuthorisationProfileToGroup_B_fkey" FOREIGN KEY ("B") REFERENCES "Group"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationProfileToUser" ADD CONSTRAINT "_AuthorisationProfileToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "AuthorisationProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationProfileToUser" ADD CONSTRAINT "_AuthorisationProfileToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationToAuthorisationAction" ADD CONSTRAINT "_AuthorisationToAuthorisationAction_A_fkey" FOREIGN KEY ("A") REFERENCES "Authorisation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorisationToAuthorisationAction" ADD CONSTRAINT "_AuthorisationToAuthorisationAction_B_fkey" FOREIGN KEY ("B") REFERENCES "AuthorisationAction"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ResourceToResourceAttribute" ADD CONSTRAINT "_ResourceToResourceAttribute_A_fkey" FOREIGN KEY ("A") REFERENCES "Resource"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ResourceToResourceAttribute" ADD CONSTRAINT "_ResourceToResourceAttribute_B_fkey" FOREIGN KEY ("B") REFERENCES "ResourceAttribute"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ResourceToResourceProfile" ADD CONSTRAINT "_ResourceToResourceProfile_A_fkey" FOREIGN KEY ("A") REFERENCES "Resource"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ResourceToResourceProfile" ADD CONSTRAINT "_ResourceToResourceProfile_B_fkey" FOREIGN KEY ("B") REFERENCES "ResourceProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
