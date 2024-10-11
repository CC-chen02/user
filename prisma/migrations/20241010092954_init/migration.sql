-- CreateTable
CREATE TABLE `Project` (
    `id` VARCHAR(191) NOT NULL,
    `communityId` VARCHAR(191) NULL,
    `name` VARCHAR(191) NOT NULL,
    `areaName` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `industryFormat` ENUM('Residential', 'PublicBuildings', 'Commercial', 'Hospital', 'School', 'UrbanServices') NOT NULL DEFAULT 'Residential',
    `centralControlTelephone` VARCHAR(191) NULL,
    `attachedFileUrl` TEXT NULL,
    `provinceCode` CHAR(6) NOT NULL,
    `addressDetail` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Project_communityId_key`(`communityId`),
    UNIQUE INDEX `Project_areaName_key`(`areaName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Indicator` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `value` DOUBLE NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Indicator_name_projectId_key`(`name`, `projectId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AreaValue` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `value` DOUBLE NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `AreaValue_name_projectId_key`(`name`, `projectId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `gender` ENUM('Male', 'Female', 'Other') NOT NULL DEFAULT 'Other',
    `phone` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `User_phone_key`(`phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Resident` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `secondaryPhone` VARCHAR(191) NULL,
    `avatar` VARCHAR(191) NULL,
    `politicsStatus` ENUM('PartyMember', 'Mass') NOT NULL DEFAULT 'Mass',
    `openid` VARCHAR(191) NULL,
    `primaryHouseholdId` VARCHAR(191) NULL,
    `birth` CHAR(8) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `healthState` ENUM('Healthy', 'VisionDisability', 'HearingDisability', 'SpeechDisability', 'LimbDisability', 'IntellectualDisability', 'MentalDisability', 'MultipleDisabilities') NOT NULL DEFAULT 'Healthy',
    `identity` ENUM('AdministrativeInstitution', 'StateEnterprise', 'Retired', 'Veteran', 'IntroducedTalent') NULL,
    `personId` VARCHAR(191) NULL,
    `visitAcceptable` BOOLEAN NULL,
    `isVip` BOOLEAN NOT NULL DEFAULT false,
    `remark` TEXT NULL,

    UNIQUE INDEX `Resident_phone_key`(`phone`),
    UNIQUE INDEX `Resident_personId_key`(`personId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ResidentParkingSpot` (
    `id` VARCHAR(191) NOT NULL,
    `residentPhone` VARCHAR(191) NOT NULL,
    `parkingSpotId` VARCHAR(191) NOT NULL,
    `role` ENUM('Owner', 'Tenant', 'Member', 'Staff', 'Other') NOT NULL,
    `isFeePayer` BOOLEAN NOT NULL,

    UNIQUE INDEX `ResidentParkingSpot_residentPhone_parkingSpotId_key`(`residentPhone`, `parkingSpotId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ResidentHousehold` (
    `id` VARCHAR(191) NOT NULL,
    `residentPhone` VARCHAR(191) NOT NULL,
    `householdId` VARCHAR(191) NOT NULL,
    `role` ENUM('Owner', 'Tenant', 'Member', 'Staff', 'Other') NOT NULL,
    `isFeePayer` BOOLEAN NOT NULL,

    UNIQUE INDEX `ResidentHousehold_residentPhone_householdId_key`(`residentPhone`, `householdId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Diversification` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `type` ENUM('Personal', 'Corporation') NOT NULL,
    `taxPayerId` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT true,
    `remark` VARCHAR(600) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProposalInfo` (
    `id` VARCHAR(191) NOT NULL,
    `total` DOUBLE NOT NULL,
    `attachmentUrl` TEXT NULL,
    `costMethod` ENUM('FixedAmount', 'Percentage') NOT NULL,
    `diversificationId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `ProposalInfo_diversificationId_key`(`diversificationId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProposalExpense` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `value` DOUBLE NOT NULL,
    `validityStart` DATETIME(3) NOT NULL,
    `validityEnd` DATETIME(3) NOT NULL,
    `paymentStart` DATETIME(3) NOT NULL,
    `paymentEnd` DATETIME(3) NOT NULL,
    `proposalInfoId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Corporation` (
    `id` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `legalPerson` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `contactInfo` VARCHAR(191) NOT NULL,
    `residentId` VARCHAR(191) NULL,

    UNIQUE INDEX `Corporation_code_key`(`code`),
    UNIQUE INDEX `Corporation_residentId_key`(`residentId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `IDInfo` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('IDCard', 'Passport', 'OfficerMilitary', 'Other') NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `frontPicUrl` TEXT NULL,
    `backPicUrl` TEXT NULL,
    `residentId` VARCHAR(191) NULL,

    UNIQUE INDEX `IDInfo_residentId_key`(`residentId`),
    UNIQUE INDEX `IDInfo_type_code_key`(`type`, `code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Staff` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `avatar` VARCHAR(191) NULL,
    `openid` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `wwUserId` VARCHAR(191) NULL,
    `department` ENUM('ProjectCustomer', 'ProjectEngineering', 'ProjectOrder', 'ProjectEnvironment', 'ProjectOffice', 'ProjectAccounting', 'HeadGeneralManagerOffice', 'HeadOperationalQuality', 'HeadHrAndAdmin', 'HeadEngineering', 'HeadAccounting', 'HeadBusinessDevelopment', 'RealEstate', 'RealEstateDreamer', 'Other') NOT NULL,
    `positionId` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `Staff_phone_key`(`phone`),
    UNIQUE INDEX `Staff_wwUserId_key`(`wwUserId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Coord` (
    `id` VARCHAR(191) NOT NULL,
    `lat` DOUBLE NOT NULL,
    `lng` DOUBLE NOT NULL,
    `time` DATETIME(3) NOT NULL,
    `staffId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `GuardsAccessRecord` (
    `id` VARCHAR(191) NOT NULL,
    `longitude` DOUBLE NOT NULL,
    `latitude` DOUBLE NOT NULL,
    `guardId` VARCHAR(191) NOT NULL,
    `result` BOOLEAN NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdByResidentId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Device` (
    `id` VARCHAR(191) NOT NULL,
    `scope` ENUM('Area', 'Unit') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Position` (
    `id` VARCHAR(191) NOT NULL,
    `department` ENUM('ProjectCustomer', 'ProjectEngineering', 'ProjectOrder', 'ProjectEnvironment', 'ProjectOffice', 'ProjectAccounting', 'HeadGeneralManagerOffice', 'HeadOperationalQuality', 'HeadHrAndAdmin', 'HeadEngineering', 'HeadAccounting', 'HeadBusinessDevelopment', 'RealEstate', 'RealEstateDreamer', 'Other') NOT NULL,
    `position` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FacilityOrder` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('Pending', 'InProgress', 'Completed', 'Overtime', 'Unfinished') NOT NULL DEFAULT 'Pending',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `name` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,
    `type` ENUM('Engineering', 'Order', 'Management') NOT NULL,
    `tookAt` DATETIME(3) NULL,
    `assignerId` VARCHAR(191) NULL,
    `operatorId` VARCHAR(191) NULL,
    `startAt` DATETIME(3) NULL,
    `endAt` DATETIME(3) NULL,
    `scheduledStartAt` DATETIME(3) NOT NULL,
    `scheduledEndAt` DATETIME(3) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Facility` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `place` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `inspectionTypes` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Questionnaire` (
    `id` VARCHAR(191) NOT NULL,
    `facilityId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Questionnaire_facilityId_key`(`facilityId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Question` (
    `id` VARCHAR(191) NOT NULL,
    `code` INTEGER NOT NULL,
    `questionnaireId` VARCHAR(191) NOT NULL,
    `text` VARCHAR(191) NOT NULL,
    `type` ENUM('Text', 'SingleChoice', 'MultipleChoice', 'Pictures') NOT NULL,

    UNIQUE INDEX `Question_code_questionnaireId_key`(`code`, `questionnaireId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `QuestionOption` (
    `id` VARCHAR(191) NOT NULL,
    `questionId` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `text` TEXT NOT NULL,

    UNIQUE INDEX `QuestionOption_questionId_code_key`(`questionId`, `code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AnswerSheet` (
    `id` VARCHAR(191) NOT NULL,
    `signInUrl` TEXT NULL,
    `signInTime` DATETIME(3) NOT NULL,
    `signInLongitude` DOUBLE NOT NULL,
    `signInLatitude` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `facilityId` VARCHAR(191) NOT NULL,
    `facilityOrderId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `AnswerSheet_facilityId_facilityOrderId_key`(`facilityId`, `facilityOrderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Answer` (
    `id` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NULL,
    `description` VARCHAR(191) NOT NULL,
    `selections` TEXT NULL,
    `text` TEXT NOT NULL,
    `answerSheetId` VARCHAR(191) NULL,
    `type` ENUM('Text', 'SingleChoice', 'MultipleChoice', 'Pictures') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WorkWxDepartment` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `parentid` INTEGER NOT NULL,
    `order` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Inspection` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,
    `type` ENUM('Engineering', 'Order', 'Management') NOT NULL,
    `directorId` VARCHAR(191) NULL,
    `startAt` DATETIME(3) NOT NULL,
    `endAt` DATETIME(3) NOT NULL,
    `repeatType` ENUM('None', 'EveryDay', 'EveryWeek', 'EveryMonth') NOT NULL,
    `status` ENUM('Active', 'Off') NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `createdById` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WechatVideo` (
    `id` VARCHAR(191) NOT NULL,
    `token` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Building` (
    `id` VARCHAR(191) NOT NULL,
    `communityId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `number` CHAR(3) NOT NULL,
    `floorUpCount` CHAR(3) NOT NULL,
    `floorDownCount` CHAR(1) NOT NULL DEFAULT '0',
    `floorFamilyCount` CHAR(2) NOT NULL,
    `unitSize` CHAR(2) NOT NULL,
    `remark` VARCHAR(191) NULL,
    `type` ENUM('Residential', 'Villa', 'Apartment', 'Office', 'Storefront', 'Basement', 'Warehouse', 'StorageRoom') NOT NULL DEFAULT 'Residential',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ParkingSpot` (
    `id` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `status` ENUM('Occupied', 'Vacant', 'SoldVacant', 'Prohibited') NOT NULL,
    `classification` ENUM('Standard', 'Protective', 'MajorMinor') NOT NULL,
    `type` ENUM('Fixed', 'Property', 'Temporary') NOT NULL,
    `floor` VARCHAR(191) NOT NULL,
    `area` DOUBLE NULL,
    `number` INTEGER NULL,
    `remark` TEXT NULL,
    `effective` BOOLEAN NOT NULL DEFAULT true,
    `enableQrcode` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `projectId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ParkingStatusHistory` (
    `id` VARCHAR(191) NOT NULL,
    `oldStatus` ENUM('Occupied', 'Vacant', 'SoldVacant', 'Prohibited') NOT NULL,
    `status` ENUM('Occupied', 'Vacant', 'SoldVacant', 'Prohibited') NOT NULL,
    `updatedTime` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdById` VARCHAR(191) NOT NULL,
    `parkingSpotId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `ParkingStatusHistory_parkingSpotId_key`(`parkingSpotId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Unit` (
    `id` VARCHAR(191) NOT NULL,
    `buildingId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `number` CHAR(2) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Household` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('PendingMoveIn', 'InUse', 'UnderRenovation', 'VacantAfterRenovation', 'VacantAfterHandover', 'Vacant') NOT NULL DEFAULT 'InUse',
    `warrantyStart` DATETIME(3) NULL,
    `expiredAt` DATETIME(3) NULL,
    `building` VARCHAR(191) NOT NULL,
    `buildingId` VARCHAR(191) NULL,
    `type` ENUM('Residential', 'Villa', 'Apartment', 'Office', 'Storefront', 'Basement', 'Warehouse', 'StorageRoom') NOT NULL DEFAULT 'Residential',
    `unit` VARCHAR(191) NULL,
    `floor` VARCHAR(191) NULL,
    `unitId` VARCHAR(191) NULL,
    `roomId` VARCHAR(191) NULL,
    `room` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `insideArea` DOUBLE NULL,
    `structuralArea` DOUBLE NULL,
    `remark` TEXT NULL,
    `renovated` BOOLEAN NOT NULL DEFAULT false,
    `projectId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Household_roomId_key`(`roomId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `HouseholdStatusHistory` (
    `id` VARCHAR(191) NOT NULL,
    `oldStatus` ENUM('PendingMoveIn', 'InUse', 'UnderRenovation', 'VacantAfterRenovation', 'VacantAfterHandover', 'Vacant') NOT NULL,
    `status` ENUM('PendingMoveIn', 'InUse', 'UnderRenovation', 'VacantAfterRenovation', 'VacantAfterHandover', 'Vacant') NOT NULL,
    `saleUpdatedAt` DATETIME(3) NOT NULL,
    `useStatusUpdatedAt` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdById` VARCHAR(191) NOT NULL,
    `householdId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RenovationViolation` (
    `id` VARCHAR(191) NOT NULL,
    `householdId` VARCHAR(191) NOT NULL,
    `time` DATETIME(3) NOT NULL,
    `description` TEXT NOT NULL,
    `picturesUrl` TEXT NULL,
    `abarbeitung` VARCHAR(191) NULL,
    `abarbeitungPicturesUrl` TEXT NULL,
    `createdById` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RenovationStep` (
    `id` VARCHAR(191) NOT NULL,
    `stage` INTEGER NOT NULL,
    `status` ENUM('Pending', 'InProgress', 'Completed') NOT NULL DEFAULT 'Pending',
    `householdId` VARCHAR(191) NOT NULL,
    `picturesUrl` TEXT NULL,

    UNIQUE INDEX `RenovationStep_householdId_stage_key`(`householdId`, `stage`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Activity` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` TEXT NOT NULL,
    `place` VARCHAR(191) NOT NULL,
    `meetingPlace` VARCHAR(191) NULL,
    `peopleLimit` INTEGER NULL,
    `fullPrice` DOUBLE NOT NULL,
    `discountPrice` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NOT NULL,
    `appToken` VARCHAR(191) NULL,
    `tableId` VARCHAR(191) NULL,
    `tableUrl` TEXT NULL,
    `pictureUrl` TEXT NOT NULL,
    `createdByStaffId` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,
    `status` ENUM('Pending', 'Active', 'Canceled', 'Done') NOT NULL DEFAULT 'Pending',
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ActivityRecord` (
    `id` VARCHAR(191) NOT NULL,
    `applicantId` VARCHAR(191) NOT NULL,
    `activityId` VARCHAR(191) NOT NULL,
    `numberOfPeople` INTEGER NOT NULL,
    `room` VARCHAR(191) NOT NULL,
    `recordId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `contactPhone` VARCHAR(191) NOT NULL,
    `remark` VARCHAR(191) NULL,
    `volunteerWilling` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AssociationRecord` (
    `id` VARCHAR(191) NOT NULL,
    `applicantId` VARCHAR(191) NOT NULL,
    `associationId` VARCHAR(191) NOT NULL,
    `room` VARCHAR(191) NULL,
    `recordId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `contactPhone` VARCHAR(191) NULL,
    `remark` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WorkOrder` (
    `id` VARCHAR(191) NOT NULL,
    `isRealEstate` BOOLEAN NOT NULL DEFAULT false,
    `status` ENUM('Initial', 'Unassigned', 'AssignedAndWaitingWorkerTaking', 'WorkerAcceptedAndWaitingOperating', 'WorkerRefusedAndWaitingReassign', 'Operating', 'WaitingApplicantConfirmingAmount', 'SuspendedAndWaitingApplicantConfirming', 'Canceled', 'AmountConfirmedByApplicant', 'Unchecked', 'CheckedAndWaitingAddingComment', 'Completed') NOT NULL DEFAULT 'Initial',
    `projectId` VARCHAR(191) NOT NULL,
    `householdId` VARCHAR(191) NULL,
    `payer` ENUM('Resident', 'Property', 'RealEstate') NOT NULL DEFAULT 'Resident',
    `applicantPhone` VARCHAR(191) NULL,
    `agentPhone` VARCHAR(191) NULL,
    `isCommonArea` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `isCharged` BOOLEAN NULL,
    `workOrderType` ENUM('Customer', 'Environment', 'Engineering', 'Order', 'RealEstate') NOT NULL,
    `classification` VARCHAR(191) NOT NULL,
    `description` TEXT NOT NULL,
    `appointmentTime` VARCHAR(191) NOT NULL,
    `operatorPhone` VARCHAR(191) NULL,
    `amount` DOUBLE NULL,
    `islocked` BOOLEAN NOT NULL DEFAULT false,
    `reportPicsUrl` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WorkOrderStatusChangeHistory` (
    `id` VARCHAR(191) NOT NULL,
    `oldStatus` ENUM('Initial', 'Unassigned', 'AssignedAndWaitingWorkerTaking', 'WorkerAcceptedAndWaitingOperating', 'WorkerRefusedAndWaitingReassign', 'Operating', 'WaitingApplicantConfirmingAmount', 'SuspendedAndWaitingApplicantConfirming', 'Canceled', 'AmountConfirmedByApplicant', 'Unchecked', 'CheckedAndWaitingAddingComment', 'Completed') NOT NULL,
    `status` ENUM('Initial', 'Unassigned', 'AssignedAndWaitingWorkerTaking', 'WorkerAcceptedAndWaitingOperating', 'WorkerRefusedAndWaitingReassign', 'Operating', 'WaitingApplicantConfirmingAmount', 'SuspendedAndWaitingApplicantConfirming', 'Canceled', 'AmountConfirmedByApplicant', 'Unchecked', 'CheckedAndWaitingAddingComment', 'Completed') NOT NULL,
    `updatedType` ENUM('Customer', 'Environment', 'Engineering', 'Order', 'RealEstate') NULL,
    `workOrderId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdByPhone` VARCHAR(191) NULL,
    `createdByName` VARCHAR(191) NULL,
    `tempValue` TEXT NULL,
    `description` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comment` (
    `id` VARCHAR(191) NOT NULL,
    `content` VARCHAR(191) NULL,
    `rating` VARCHAR(191) NOT NULL,
    `attitude` VARCHAR(191) NOT NULL,
    `suggestion` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `workOrderId` VARCHAR(191) NULL,

    UNIQUE INDEX `Comment_workOrderId_key`(`workOrderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Expense` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `description` VARCHAR(191) NULL,
    `workOrderId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `visible` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ExpenseCategory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `parentId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ExpenseItem` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `feeType` ENUM('Income', 'Collection', 'Temporary') NOT NULL,
    `precisiion` ENUM('Yuan', 'Jiao', 'Fen') NOT NULL,
    `roundType` ENUM('Ceiling', 'Floor', 'Nearest') NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT true,
    `remark` VARCHAR(191) NULL,
    `expenseCategoryId` INTEGER NULL,
    `projectId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ExpenseStandard` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `cycleMonths` INTEGER NOT NULL,
    `dataSource` ENUM('StructuralArea', 'ParkingSpotArea', 'FixedValue') NOT NULL,
    `precisiion` ENUM('Yuan', 'Jiao', 'Fen') NOT NULL,
    `roundType` ENUM('Ceiling', 'Floor', 'Nearest') NOT NULL,
    `allowInput` BOOLEAN NOT NULL,
    `houseOrParkingRequired` BOOLEAN NOT NULL,
    `baseValue` DOUBLE NOT NULL DEFAULT 0,
    `calculateLiquidated` BOOLEAN NOT NULL,
    `remark` TEXT NULL,
    `expenseItemId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ConditionCalculation` (
    `id` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL DEFAULT 'none',
    `expenseStandardId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FeeCalculation` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('UnitPrice', 'FixedValue') NOT NULL,
    `value` DOUBLE NOT NULL,
    `conditionCalculationId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FeeOrder` (
    `id` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `trasactionId` VARCHAR(191) NULL,
    `status` ENUM('Unpaid', 'Paid') NOT NULL DEFAULT 'Unpaid',
    `workOrderId` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `visible` BOOLEAN NOT NULL DEFAULT true,
    `paidAmount` VARCHAR(191) NULL,
    `paidAt` DATETIME(3) NULL,
    `paidMethod` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `remark` VARCHAR(191) NULL,
    `userPhone` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `FeeOrder_code_key`(`code`),
    UNIQUE INDEX `FeeOrder_trasactionId_key`(`trasactionId`),
    UNIQUE INDEX `FeeOrder_workOrderId_key`(`workOrderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Perspective` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('Praise', 'Suggestions', 'Complaints') NOT NULL,
    `content` TEXT NOT NULL,
    `pictureUrl` TEXT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdById` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,
    `contactPhone` VARCHAR(191) NULL,
    `contactAddress` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Announcement` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('Pending', 'Active', 'Canceled', 'Done') NOT NULL DEFAULT 'Pending',
    `top` BOOLEAN NOT NULL DEFAULT false,
    `title` VARCHAR(191) NOT NULL,
    `expiredAt` DATETIME(3) NULL,
    `content` TEXT NOT NULL,
    `pictureUrl` TEXT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `createdById` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Association` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `kol` VARCHAR(191) NULL,
    `intro` TEXT NULL,
    `projectId` VARCHAR(191) NOT NULL,
    `initiatorId` VARCHAR(191) NULL,
    `pictureUrls` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Permission` (
    `id` VARCHAR(191) NOT NULL,
    `menuId` INTEGER NOT NULL,
    `action` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Menu` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `parentId` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Role` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdById` VARCHAR(191) NOT NULL,
    `deletable` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ScreenData` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `project` VARCHAR(191) NOT NULL,
    `prospectiveOwners` INTEGER NOT NULL,
    `satisfactionSurveyCompletionRate` DOUBLE NOT NULL,
    `ownerActivitySatisfaction` DOUBLE NOT NULL,
    `numberOfCommunities` INTEGER NOT NULL,
    `communityEventCount` INTEGER NOT NULL,
    `communityParticipants` INTEGER NOT NULL,
    `totalCommunityEventCost` INTEGER NOT NULL,
    `communityKolCount` INTEGER NOT NULL,
    `kolActivityEngagement` DOUBLE NOT NULL,
    `preVideos` INTEGER NOT NULL,
    `preImages` INTEGER NOT NULL,
    `preTexts` INTEGER NOT NULL,
    `postVideos` INTEGER NOT NULL,
    `postImages` INTEGER NOT NULL,
    `postTexts` INTEGER NOT NULL,
    `holiday` INTEGER NOT NULL,
    `weather` INTEGER NOT NULL,
    `birthday` INTEGER NOT NULL,
    `memorable` INTEGER NOT NULL,
    `consultationFeedbackCount` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Prepayment` (
    `id` VARCHAR(191) NOT NULL,
    `remark` VARCHAR(191) NULL,
    `householdId` VARCHAR(191) NULL,
    `remaining` DOUBLE NOT NULL DEFAULT 0,
    `updatedAt` DATETIME(3) NOT NULL,
    `parkingSpotId` VARCHAR(191) NULL,
    `resourceId` VARCHAR(191) NOT NULL,
    `autoOffset` BOOLEAN NOT NULL DEFAULT false,
    `expenseItemId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Prepayment_resourceId_expenseItemId_key`(`resourceId`, `expenseItemId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PrepaymentDetail` (
    `id` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `totalRemaining` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `operatorId` VARCHAR(191) NOT NULL,
    `remark` VARCHAR(191) NULL,
    `prepaymentId` VARCHAR(191) NOT NULL,
    `billingRecordId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BillingRequest` (
    `id` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `expenseItemName` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `status` ENUM('Approved', 'Rejected', 'Pending') NOT NULL,
    `frozen` ENUM('None', 'Manual', 'System') NOT NULL DEFAULT 'None',
    `frozenReason` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `feeCalculationId` VARCHAR(191) NULL,
    `createdById` VARCHAR(191) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,
    `approverId` VARCHAR(191) NULL,
    `approvedAt` DATETIME(3) NULL,
    `expenseStartAt` INTEGER NOT NULL,
    `expenseEndAt` INTEGER NOT NULL,
    `belongToMonth` INTEGER NOT NULL,
    `remark` VARCHAR(191) NULL,
    `dueDate` DATETIME(3) NOT NULL,
    `attachmentUrl` TEXT NULL,
    `parkingSpotId` VARCHAR(191) NULL,
    `householdId` VARCHAR(191) NULL,
    `residentId` VARCHAR(191) NOT NULL,
    `role` ENUM('Owner', 'Tenant', 'Member', 'Staff', 'Other') NOT NULL DEFAULT 'Owner',
    `feeType` ENUM('Income', 'Collection', 'Temporary') NOT NULL DEFAULT 'Collection',
    `area` DOUBLE NOT NULL DEFAULT 130,
    `calculationType` ENUM('UnitPrice', 'FixedValue') NOT NULL DEFAULT 'UnitPrice',
    `calculationValue` DOUBLE NOT NULL DEFAULT 15,
    `expenseStandard` VARCHAR(191) NOT NULL DEFAULT 'test1',
    `dataSource` ENUM('StructuralArea', 'ParkingSpotArea', 'FixedValue') NOT NULL DEFAULT 'StructuralArea',
    `cycleMonths` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `BillingRequest_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BillingRecord` (
    `id` VARCHAR(191) NOT NULL,
    `approvalBookId` VARCHAR(191) NOT NULL,
    `approvalCode` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `paidAt` DATETIME(3) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,
    `payer` VARCHAR(191) NOT NULL,
    `roundMethod` ENUM('NoRounding', 'RoundUpToYuan', 'RoundUpToJiao', 'RoundDownToYuan', 'RoundDownToJiao') NOT NULL DEFAULT 'NoRounding',
    `remark` VARCHAR(191) NULL,
    `operatorId` VARCHAR(191) NOT NULL,
    `status` ENUM('Normal', 'Invalid') NOT NULL DEFAULT 'Normal',
    `handover` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `BillingRecord_approvalCode_key`(`approvalCode`),
    UNIQUE INDEX `BillingRecord_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PrintRecord` (
    `id` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `operatorId` VARCHAR(191) NOT NULL,
    `billingRecordId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Receipt` (
    `id` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `paymethod` ENUM('Cash', 'POS', 'CreditCard', 'DebitCard', 'QrCode', 'Scan', 'OnlineBanking') NOT NULL,
    `billingRecordId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Discount` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('BreachPenaltyWaiver', 'EmployeeDiscount', 'VacantRoomDiscount', 'DepositDiscount', 'OtherDiscount') NOT NULL,
    `amount` DOUBLE NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `reason` VARCHAR(191) NULL,
    `applicantId` VARCHAR(191) NOT NULL,
    `approverId` VARCHAR(191) NOT NULL,
    `approvedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `billingRequestId` VARCHAR(191) NULL,

    UNIQUE INDEX `Discount_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Adjustment` (
    `id` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `reason` VARCHAR(191) NULL,
    `type` ENUM('VoidedBill', 'RoundUp', 'RoundDown', 'TailDifference', 'PriceDifference', 'Other') NOT NULL,
    `applicantId` VARCHAR(191) NOT NULL,
    `approverId` VARCHAR(191) NOT NULL,
    `approvedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `billingRequestId` VARCHAR(191) NULL,

    UNIQUE INDEX `Adjustment_code_key`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transfer` (
    `id` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `reason` VARCHAR(191) NULL,
    `applicantId` VARCHAR(191) NOT NULL,
    `approverId` VARCHAR(191) NOT NULL,
    `approvedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `billingRequestId` VARCHAR(191) NULL,
    `prepaymentId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Offset` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('Auto', 'Manual') NOT NULL,
    `amount` DOUBLE NOT NULL,
    `operatorId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `billingRequestId` VARCHAR(191) NULL,
    `prepaymentId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Voiding` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('Pending', 'Approved', 'Rejected', 'Canceled') NOT NULL DEFAULT 'Pending',
    `applicantId` VARCHAR(191) NOT NULL,
    `reason` VARCHAR(191) NULL,
    `approverId` VARCHAR(191) NULL,
    `billingRequestId` VARCHAR(191) NULL,
    `billingRecordId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `approvedAt` DATETIME(3) NULL,

    UNIQUE INDEX `Voiding_billingRequestId_key`(`billingRequestId`),
    UNIQUE INDEX `Voiding_billingRecordId_key`(`billingRecordId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ApprovalBook` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `acronym` VARCHAR(191) NOT NULL,
    `projectId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `ApprovalBook_projectId_key`(`projectId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `VerificationCode` (
    `id` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `casbin_rule` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ptype` VARCHAR(191) NOT NULL,
    `v0` VARCHAR(191) NULL,
    `v1` VARCHAR(191) NULL,
    `v2` VARCHAR(191) NULL,
    `v3` VARCHAR(191) NULL,
    `v4` VARCHAR(191) NULL,
    `v5` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ProjectToStaff` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ProjectToStaff_AB_unique`(`A`, `B`),
    INDEX `_ProjectToStaff_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_DiversificationToProject` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_DiversificationToProject_AB_unique`(`A`, `B`),
    INDEX `_DiversificationToProject_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_FacilityToInspection` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_FacilityToInspection_AB_unique`(`A`, `B`),
    INDEX `_FacilityToInspection_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_FacilityToFacilityOrder` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_FacilityToFacilityOrder_AB_unique`(`A`, `B`),
    INDEX `_FacilityToFacilityOrder_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_JoinedAssociations` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_JoinedAssociations_AB_unique`(`A`, `B`),
    INDEX `_JoinedAssociations_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_PermissionToRole` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_PermissionToRole_AB_unique`(`A`, `B`),
    INDEX `_PermissionToRole_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_StaffRoles` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_StaffRoles_AB_unique`(`A`, `B`),
    INDEX `_StaffRoles_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_BillingRecordToBillingRequest` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_BillingRecordToBillingRequest_AB_unique`(`A`, `B`),
    INDEX `_BillingRecordToBillingRequest_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Indicator` ADD CONSTRAINT `Indicator_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AreaValue` ADD CONSTRAINT `AreaValue_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Resident` ADD CONSTRAINT `Resident_phone_fkey` FOREIGN KEY (`phone`) REFERENCES `User`(`phone`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ResidentParkingSpot` ADD CONSTRAINT `ResidentParkingSpot_residentPhone_fkey` FOREIGN KEY (`residentPhone`) REFERENCES `Resident`(`phone`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ResidentParkingSpot` ADD CONSTRAINT `ResidentParkingSpot_parkingSpotId_fkey` FOREIGN KEY (`parkingSpotId`) REFERENCES `ParkingSpot`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ResidentHousehold` ADD CONSTRAINT `ResidentHousehold_residentPhone_fkey` FOREIGN KEY (`residentPhone`) REFERENCES `Resident`(`phone`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ResidentHousehold` ADD CONSTRAINT `ResidentHousehold_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProposalInfo` ADD CONSTRAINT `ProposalInfo_diversificationId_fkey` FOREIGN KEY (`diversificationId`) REFERENCES `Diversification`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProposalExpense` ADD CONSTRAINT `ProposalExpense_proposalInfoId_fkey` FOREIGN KEY (`proposalInfoId`) REFERENCES `ProposalInfo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Corporation` ADD CONSTRAINT `Corporation_residentId_fkey` FOREIGN KEY (`residentId`) REFERENCES `Resident`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `IDInfo` ADD CONSTRAINT `IDInfo_residentId_fkey` FOREIGN KEY (`residentId`) REFERENCES `Resident`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Staff` ADD CONSTRAINT `Staff_phone_fkey` FOREIGN KEY (`phone`) REFERENCES `User`(`phone`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Staff` ADD CONSTRAINT `Staff_positionId_fkey` FOREIGN KEY (`positionId`) REFERENCES `Position`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Coord` ADD CONSTRAINT `Coord_staffId_fkey` FOREIGN KEY (`staffId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `GuardsAccessRecord` ADD CONSTRAINT `GuardsAccessRecord_guardId_fkey` FOREIGN KEY (`guardId`) REFERENCES `Device`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `GuardsAccessRecord` ADD CONSTRAINT `GuardsAccessRecord_createdByResidentId_fkey` FOREIGN KEY (`createdByResidentId`) REFERENCES `Resident`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacilityOrder` ADD CONSTRAINT `FacilityOrder_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacilityOrder` ADD CONSTRAINT `FacilityOrder_assignerId_fkey` FOREIGN KEY (`assignerId`) REFERENCES `Staff`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacilityOrder` ADD CONSTRAINT `FacilityOrder_operatorId_fkey` FOREIGN KEY (`operatorId`) REFERENCES `Staff`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Facility` ADD CONSTRAINT `Facility_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Questionnaire` ADD CONSTRAINT `Questionnaire_facilityId_fkey` FOREIGN KEY (`facilityId`) REFERENCES `Facility`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Question` ADD CONSTRAINT `Question_questionnaireId_fkey` FOREIGN KEY (`questionnaireId`) REFERENCES `Questionnaire`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `QuestionOption` ADD CONSTRAINT `QuestionOption_questionId_fkey` FOREIGN KEY (`questionId`) REFERENCES `Question`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AnswerSheet` ADD CONSTRAINT `AnswerSheet_facilityId_fkey` FOREIGN KEY (`facilityId`) REFERENCES `Facility`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AnswerSheet` ADD CONSTRAINT `AnswerSheet_facilityOrderId_fkey` FOREIGN KEY (`facilityOrderId`) REFERENCES `FacilityOrder`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_answerSheetId_fkey` FOREIGN KEY (`answerSheetId`) REFERENCES `AnswerSheet`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Inspection` ADD CONSTRAINT `Inspection_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Inspection` ADD CONSTRAINT `Inspection_directorId_fkey` FOREIGN KEY (`directorId`) REFERENCES `Staff`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Inspection` ADD CONSTRAINT `Inspection_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Building` ADD CONSTRAINT `Building_communityId_fkey` FOREIGN KEY (`communityId`) REFERENCES `Project`(`communityId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ParkingSpot` ADD CONSTRAINT `ParkingSpot_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ParkingStatusHistory` ADD CONSTRAINT `ParkingStatusHistory_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ParkingStatusHistory` ADD CONSTRAINT `ParkingStatusHistory_parkingSpotId_fkey` FOREIGN KEY (`parkingSpotId`) REFERENCES `ParkingSpot`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Unit` ADD CONSTRAINT `Unit_buildingId_fkey` FOREIGN KEY (`buildingId`) REFERENCES `Building`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Household` ADD CONSTRAINT `Household_buildingId_fkey` FOREIGN KEY (`buildingId`) REFERENCES `Building`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Household` ADD CONSTRAINT `Household_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `HouseholdStatusHistory` ADD CONSTRAINT `HouseholdStatusHistory_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `HouseholdStatusHistory` ADD CONSTRAINT `HouseholdStatusHistory_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RenovationViolation` ADD CONSTRAINT `RenovationViolation_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RenovationViolation` ADD CONSTRAINT `RenovationViolation_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RenovationStep` ADD CONSTRAINT `RenovationStep_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Activity` ADD CONSTRAINT `Activity_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Activity` ADD CONSTRAINT `Activity_createdByStaffId_fkey` FOREIGN KEY (`createdByStaffId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ActivityRecord` ADD CONSTRAINT `ActivityRecord_activityId_fkey` FOREIGN KEY (`activityId`) REFERENCES `Activity`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ActivityRecord` ADD CONSTRAINT `ActivityRecord_applicantId_fkey` FOREIGN KEY (`applicantId`) REFERENCES `Resident`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AssociationRecord` ADD CONSTRAINT `AssociationRecord_associationId_fkey` FOREIGN KEY (`associationId`) REFERENCES `Association`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AssociationRecord` ADD CONSTRAINT `AssociationRecord_applicantId_fkey` FOREIGN KEY (`applicantId`) REFERENCES `Resident`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrder` ADD CONSTRAINT `WorkOrder_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrder` ADD CONSTRAINT `WorkOrder_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrder` ADD CONSTRAINT `WorkOrder_applicantPhone_fkey` FOREIGN KEY (`applicantPhone`) REFERENCES `Resident`(`phone`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrder` ADD CONSTRAINT `WorkOrder_agentPhone_fkey` FOREIGN KEY (`agentPhone`) REFERENCES `Staff`(`phone`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrder` ADD CONSTRAINT `WorkOrder_operatorPhone_fkey` FOREIGN KEY (`operatorPhone`) REFERENCES `Staff`(`phone`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrderStatusChangeHistory` ADD CONSTRAINT `WorkOrderStatusChangeHistory_workOrderId_fkey` FOREIGN KEY (`workOrderId`) REFERENCES `WorkOrder`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WorkOrderStatusChangeHistory` ADD CONSTRAINT `WorkOrderStatusChangeHistory_createdByPhone_fkey` FOREIGN KEY (`createdByPhone`) REFERENCES `User`(`phone`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_workOrderId_fkey` FOREIGN KEY (`workOrderId`) REFERENCES `WorkOrder`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Expense` ADD CONSTRAINT `Expense_workOrderId_fkey` FOREIGN KEY (`workOrderId`) REFERENCES `WorkOrder`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExpenseCategory` ADD CONSTRAINT `ExpenseCategory_parentId_fkey` FOREIGN KEY (`parentId`) REFERENCES `ExpenseCategory`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExpenseItem` ADD CONSTRAINT `ExpenseItem_expenseCategoryId_fkey` FOREIGN KEY (`expenseCategoryId`) REFERENCES `ExpenseCategory`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExpenseItem` ADD CONSTRAINT `ExpenseItem_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ExpenseStandard` ADD CONSTRAINT `ExpenseStandard_expenseItemId_fkey` FOREIGN KEY (`expenseItemId`) REFERENCES `ExpenseItem`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ConditionCalculation` ADD CONSTRAINT `ConditionCalculation_expenseStandardId_fkey` FOREIGN KEY (`expenseStandardId`) REFERENCES `ExpenseStandard`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FeeCalculation` ADD CONSTRAINT `FeeCalculation_conditionCalculationId_fkey` FOREIGN KEY (`conditionCalculationId`) REFERENCES `ConditionCalculation`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FeeOrder` ADD CONSTRAINT `FeeOrder_workOrderId_fkey` FOREIGN KEY (`workOrderId`) REFERENCES `WorkOrder`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FeeOrder` ADD CONSTRAINT `FeeOrder_userPhone_fkey` FOREIGN KEY (`userPhone`) REFERENCES `Resident`(`phone`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Perspective` ADD CONSTRAINT `Perspective_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Resident`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Perspective` ADD CONSTRAINT `Perspective_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Announcement` ADD CONSTRAINT `Announcement_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Announcement` ADD CONSTRAINT `Announcement_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Association` ADD CONSTRAINT `Association_initiatorId_fkey` FOREIGN KEY (`initiatorId`) REFERENCES `Resident`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Association` ADD CONSTRAINT `Association_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Permission` ADD CONSTRAINT `Permission_menuId_fkey` FOREIGN KEY (`menuId`) REFERENCES `Menu`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Menu` ADD CONSTRAINT `Menu_parentId_fkey` FOREIGN KEY (`parentId`) REFERENCES `Menu`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Role` ADD CONSTRAINT `Role_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Prepayment` ADD CONSTRAINT `Prepayment_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Prepayment` ADD CONSTRAINT `Prepayment_parkingSpotId_fkey` FOREIGN KEY (`parkingSpotId`) REFERENCES `ParkingSpot`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Prepayment` ADD CONSTRAINT `Prepayment_expenseItemId_fkey` FOREIGN KEY (`expenseItemId`) REFERENCES `ExpenseItem`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PrepaymentDetail` ADD CONSTRAINT `PrepaymentDetail_operatorId_fkey` FOREIGN KEY (`operatorId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PrepaymentDetail` ADD CONSTRAINT `PrepaymentDetail_prepaymentId_fkey` FOREIGN KEY (`prepaymentId`) REFERENCES `Prepayment`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PrepaymentDetail` ADD CONSTRAINT `PrepaymentDetail_billingRecordId_fkey` FOREIGN KEY (`billingRecordId`) REFERENCES `BillingRecord`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRequest` ADD CONSTRAINT `BillingRequest_feeCalculationId_fkey` FOREIGN KEY (`feeCalculationId`) REFERENCES `FeeCalculation`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRequest` ADD CONSTRAINT `BillingRequest_createdById_fkey` FOREIGN KEY (`createdById`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRequest` ADD CONSTRAINT `BillingRequest_approverId_fkey` FOREIGN KEY (`approverId`) REFERENCES `Staff`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRequest` ADD CONSTRAINT `BillingRequest_parkingSpotId_fkey` FOREIGN KEY (`parkingSpotId`) REFERENCES `ParkingSpot`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRequest` ADD CONSTRAINT `BillingRequest_householdId_fkey` FOREIGN KEY (`householdId`) REFERENCES `Household`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRequest` ADD CONSTRAINT `BillingRequest_residentId_fkey` FOREIGN KEY (`residentId`) REFERENCES `Resident`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRecord` ADD CONSTRAINT `BillingRecord_approvalBookId_fkey` FOREIGN KEY (`approvalBookId`) REFERENCES `ApprovalBook`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BillingRecord` ADD CONSTRAINT `BillingRecord_operatorId_fkey` FOREIGN KEY (`operatorId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PrintRecord` ADD CONSTRAINT `PrintRecord_operatorId_fkey` FOREIGN KEY (`operatorId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PrintRecord` ADD CONSTRAINT `PrintRecord_billingRecordId_fkey` FOREIGN KEY (`billingRecordId`) REFERENCES `BillingRecord`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Receipt` ADD CONSTRAINT `Receipt_billingRecordId_fkey` FOREIGN KEY (`billingRecordId`) REFERENCES `BillingRecord`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Discount` ADD CONSTRAINT `Discount_applicantId_fkey` FOREIGN KEY (`applicantId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Discount` ADD CONSTRAINT `Discount_approverId_fkey` FOREIGN KEY (`approverId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Discount` ADD CONSTRAINT `Discount_billingRequestId_fkey` FOREIGN KEY (`billingRequestId`) REFERENCES `BillingRequest`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Adjustment` ADD CONSTRAINT `Adjustment_applicantId_fkey` FOREIGN KEY (`applicantId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Adjustment` ADD CONSTRAINT `Adjustment_approverId_fkey` FOREIGN KEY (`approverId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Adjustment` ADD CONSTRAINT `Adjustment_billingRequestId_fkey` FOREIGN KEY (`billingRequestId`) REFERENCES `BillingRequest`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transfer` ADD CONSTRAINT `Transfer_applicantId_fkey` FOREIGN KEY (`applicantId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transfer` ADD CONSTRAINT `Transfer_approverId_fkey` FOREIGN KEY (`approverId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transfer` ADD CONSTRAINT `Transfer_billingRequestId_fkey` FOREIGN KEY (`billingRequestId`) REFERENCES `BillingRequest`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transfer` ADD CONSTRAINT `Transfer_prepaymentId_fkey` FOREIGN KEY (`prepaymentId`) REFERENCES `Prepayment`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Offset` ADD CONSTRAINT `Offset_operatorId_fkey` FOREIGN KEY (`operatorId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Offset` ADD CONSTRAINT `Offset_billingRequestId_fkey` FOREIGN KEY (`billingRequestId`) REFERENCES `BillingRequest`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Offset` ADD CONSTRAINT `Offset_prepaymentId_fkey` FOREIGN KEY (`prepaymentId`) REFERENCES `Prepayment`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Voiding` ADD CONSTRAINT `Voiding_applicantId_fkey` FOREIGN KEY (`applicantId`) REFERENCES `Staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Voiding` ADD CONSTRAINT `Voiding_billingRequestId_fkey` FOREIGN KEY (`billingRequestId`) REFERENCES `BillingRequest`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Voiding` ADD CONSTRAINT `Voiding_approverId_fkey` FOREIGN KEY (`approverId`) REFERENCES `Staff`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Voiding` ADD CONSTRAINT `Voiding_billingRecordId_fkey` FOREIGN KEY (`billingRecordId`) REFERENCES `BillingRecord`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ApprovalBook` ADD CONSTRAINT `ApprovalBook_projectId_fkey` FOREIGN KEY (`projectId`) REFERENCES `Project`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ProjectToStaff` ADD CONSTRAINT `_ProjectToStaff_A_fkey` FOREIGN KEY (`A`) REFERENCES `Project`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ProjectToStaff` ADD CONSTRAINT `_ProjectToStaff_B_fkey` FOREIGN KEY (`B`) REFERENCES `Staff`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_DiversificationToProject` ADD CONSTRAINT `_DiversificationToProject_A_fkey` FOREIGN KEY (`A`) REFERENCES `Diversification`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_DiversificationToProject` ADD CONSTRAINT `_DiversificationToProject_B_fkey` FOREIGN KEY (`B`) REFERENCES `Project`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FacilityToInspection` ADD CONSTRAINT `_FacilityToInspection_A_fkey` FOREIGN KEY (`A`) REFERENCES `Facility`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FacilityToInspection` ADD CONSTRAINT `_FacilityToInspection_B_fkey` FOREIGN KEY (`B`) REFERENCES `Inspection`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FacilityToFacilityOrder` ADD CONSTRAINT `_FacilityToFacilityOrder_A_fkey` FOREIGN KEY (`A`) REFERENCES `Facility`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_FacilityToFacilityOrder` ADD CONSTRAINT `_FacilityToFacilityOrder_B_fkey` FOREIGN KEY (`B`) REFERENCES `FacilityOrder`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_JoinedAssociations` ADD CONSTRAINT `_JoinedAssociations_A_fkey` FOREIGN KEY (`A`) REFERENCES `Association`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_JoinedAssociations` ADD CONSTRAINT `_JoinedAssociations_B_fkey` FOREIGN KEY (`B`) REFERENCES `Resident`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_PermissionToRole` ADD CONSTRAINT `_PermissionToRole_A_fkey` FOREIGN KEY (`A`) REFERENCES `Permission`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_PermissionToRole` ADD CONSTRAINT `_PermissionToRole_B_fkey` FOREIGN KEY (`B`) REFERENCES `Role`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_StaffRoles` ADD CONSTRAINT `_StaffRoles_A_fkey` FOREIGN KEY (`A`) REFERENCES `Role`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_StaffRoles` ADD CONSTRAINT `_StaffRoles_B_fkey` FOREIGN KEY (`B`) REFERENCES `Staff`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BillingRecordToBillingRequest` ADD CONSTRAINT `_BillingRecordToBillingRequest_A_fkey` FOREIGN KEY (`A`) REFERENCES `BillingRecord`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_BillingRecordToBillingRequest` ADD CONSTRAINT `_BillingRecordToBillingRequest_B_fkey` FOREIGN KEY (`B`) REFERENCES `BillingRequest`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
