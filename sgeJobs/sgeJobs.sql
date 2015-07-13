create user sgeJobs password 'sgeJobs#123';

create database sgeJobs owner sgeJobs;

\c sgejobs;

-- -----------------------------------------------------
-- Table "sgeJobs"
-- -----------------------------------------------------
DROP TABLE IF EXISTS sgejobs;

CREATE TABLE IF NOT EXISTS sgeJobs(
  "qname" VARCHAR(15) NULL,
  "hostname" VARCHAR(45) NULL,
  "group" VARCHAR(15) NULL,
  "owner" VARCHAR(15) NULL,
  "job_name" VARCHAR(45) NULL,
  "job_number" INT NOT NULL,
  "account" VARCHAR(25) NULL,
  "priority" INT NULL,
  "submission_time" timestamp NOT NULL,
  "start_time" timestamp NULL,
  "end_time" timestamp NULL,
  "failed" INT NULL,
  "exit_status" INT NULL,
  "ru_wallclock" BIGINT NULL,
  "ru_utime" BIGINT NULL,
  "ru_stime" BIGINT NULL,
  "ru_maxrss" BIGINT NULL,
  "ru_ixrss" BIGINT NULL,
  "ru_ismrss" BIGINT NULL,
  "ru_idrss" BIGINT NULL,
  "ru_isrss" BIGINT NULL,
  "ru_minflt" BIGINT NULL,
  "ru_majflt" BIGINT NULL,
  "ru_nswap" BIGINT NULL,
  "ru_inblock" BIGINT NULL,
  "ru_oublock" BIGINT NULL,
  "ru_msgsnd" BIGINT NULL,
  "ru_msgrcv" BIGINT NULL,
  "ru_nsignals" BIGINT NULL,
  "ru_nvcsw" BIGINT NULL,
  "ru_nivcsw" BIGINT NULL,
  "project" VARCHAR(25) NULL,
  "department" VARCHAR(25) NULL,
  "granted_pe" VARCHAR(15) NULL,
  "slots" INT NULL,
  "task_number" INT NULL,
  "cpu" FLOAT NULL,
  "mem" FLOAT NULL,
  "io" FLOAT NULL,
  "category" VARCHAR(45) NULL,
  "iow" BIGINT NULL,
  "maxvmem" BIGINT NULL,
  "arid" INT NULL,
  PRIMARY KEY ("job_number", "submission_time"));


grant all privileges on sgeJobs to sgejobs;
