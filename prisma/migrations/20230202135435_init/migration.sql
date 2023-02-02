BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[User] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [User_id_df] DEFAULT newid(),
    [name] NVARCHAR(255) NOT NULL,
    [email] NVARCHAR(1000),
    [username] NVARCHAR(255) NOT NULL,
    [organisationId] UNIQUEIDENTIFIER,
    CONSTRAINT [User_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [User_username_key] UNIQUE NONCLUSTERED ([username])
);

-- CreateTable
CREATE TABLE [dbo].[Organisation] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Organisation_id_df] DEFAULT newid(),
    [name] NVARCHAR(255) NOT NULL,
    CONSTRAINT [Organisation_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Organisation_name_key] UNIQUE NONCLUSTERED ([name])
);

-- CreateTable
CREATE TABLE [dbo].[Group] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Group_id_df] DEFAULT newid(),
    [name] NVARCHAR(1000) NOT NULL,
    [tcpPrefix] NVARCHAR(1000),
    [applicationId] UNIQUEIDENTIFIER,
    CONSTRAINT [Group_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Group_name_key] UNIQUE NONCLUSTERED ([name])
);

-- CreateTable
CREATE TABLE [dbo].[Application] (
    [id] UNIQUEIDENTIFIER NOT NULL CONSTRAINT [Application_id_df] DEFAULT newid(),
    [name] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Application_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Application_name_key] UNIQUE NONCLUSTERED ([name])
);

-- CreateTable
CREATE TABLE [dbo].[UserGroups] (
    [userId] UNIQUEIDENTIFIER NOT NULL,
    [groupId] UNIQUEIDENTIFIER NOT NULL,
    [assignedAt] DATETIME2 NOT NULL CONSTRAINT [UserGroups_assignedAt_df] DEFAULT CURRENT_TIMESTAMP,
    [assignedBy] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [UserGroups_pkey] PRIMARY KEY CLUSTERED ([groupId],[userId])
);

-- CreateTable
CREATE TABLE [dbo].[ApplicationOwner] (
    [applicationId] UNIQUEIDENTIFIER NOT NULL,
    [groupId] UNIQUEIDENTIFIER NOT NULL,
    [assignedAt] DATETIME2 NOT NULL CONSTRAINT [ApplicationOwner_assignedAt_df] DEFAULT CURRENT_TIMESTAMP,
    [assignedBy] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [ApplicationOwner_pkey] PRIMARY KEY CLUSTERED ([groupId],[applicationId])
);

-- CreateTable
CREATE TABLE [dbo].[GroupManager] (
    [managerId] UNIQUEIDENTIFIER NOT NULL,
    [groupId] UNIQUEIDENTIFIER NOT NULL,
    [assignedAt] DATETIME2 NOT NULL CONSTRAINT [GroupManager_assignedAt_df] DEFAULT CURRENT_TIMESTAMP,
    [assignedBy] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [GroupManager_pkey] PRIMARY KEY CLUSTERED ([groupId],[managerId])
);

-- AddForeignKey
ALTER TABLE [dbo].[User] ADD CONSTRAINT [User_organisationId_fkey] FOREIGN KEY ([organisationId]) REFERENCES [dbo].[Organisation]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Group] ADD CONSTRAINT [Group_applicationId_fkey] FOREIGN KEY ([applicationId]) REFERENCES [dbo].[Application]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[UserGroups] ADD CONSTRAINT [UserGroups_groupId_fkey] FOREIGN KEY ([groupId]) REFERENCES [dbo].[Group]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[UserGroups] ADD CONSTRAINT [UserGroups_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[User]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[ApplicationOwner] ADD CONSTRAINT [ApplicationOwner_applicationId_fkey] FOREIGN KEY ([applicationId]) REFERENCES [dbo].[Application]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ApplicationOwner] ADD CONSTRAINT [ApplicationOwner_groupId_fkey] FOREIGN KEY ([groupId]) REFERENCES [dbo].[Group]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[GroupManager] ADD CONSTRAINT [GroupManager_groupId_fkey] FOREIGN KEY ([groupId]) REFERENCES [dbo].[Group]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[GroupManager] ADD CONSTRAINT [GroupManager_managerId_fkey] FOREIGN KEY ([managerId]) REFERENCES [dbo].[Group]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
