-- AlterTable
ALTER TABLE "AppSetting" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "Application" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "ApplicationOwner" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "Authorisation" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "Client" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "Group" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "GroupManager" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "Organisation" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "ScheduledTaskRunLog" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "SyncLog" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';

-- AlterTable
ALTER TABLE "UserGroups" ALTER COLUMN "validFrom" SET DEFAULT NOW(),
ALTER COLUMN "validTo" SET DEFAULT NOW() + interval '1 year';
