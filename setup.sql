-- Create Database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest2DB')
BEGIN
    PRINT 'Creating database AutoTest2DB';
    CREATE DATABASE AutoTest2DB;
END
ELSE
BEGIN
    PRINT 'Database AutoTest2DB already exists';
END
GO

-- Switch to AutoTest2DB
PRINT 'Switching to AutoTest2DB';
USE AutoTest2DB;
GO

-- Create or update Stored Procedure
IF OBJECT_ID('dbo.SetupAutoTestDB', 'P') IS NOT NULL
BEGIN
    PRINT 'Dropping existing procedure SetupAutoTestDB';
    DROP PROCEDURE dbo.SetupAutoTestDB;
END
GO

PRINT 'Creating procedure SetupAutoTestDB';
CREATE PROCEDURE dbo.SetupAutoTestDB
AS
BEGIN
    -- Create Table if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
    BEGIN
        PRINT 'Creating table Users';
        CREATE TABLE Users (
            Id INT PRIMARY KEY IDENTITY(1,1),
            Name NVARCHAR(100),
            Email NVARCHAR(100)
        );
    END
    ELSE
    BEGIN
        PRINT 'Table Users already exists';
    END
    -- Insert Sample Data only if not already present
    IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'john@example.com')
    BEGIN
        PRINT 'Inserting John Doe';
        INSERT INTO Users (Name, Email)
        VALUES ('John Doe', 'john@example.com');
    END
    ELSE
    BEGIN
        PRINT 'John Doe already exists';
    END
    IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'jane@example.com')
    BEGIN
        PRINT 'Inserting Jane Smith';
        INSERT INTO Users (Name, Email)
        VALUES ('Jane Smith', 'jane@example.com');
    END
    ELSE
    BEGIN
        PRINT 'Jane Smith already exists';
    END
END
GO

-- Execute the Stored Procedure
PRINT 'Executing SetupAutoTestDB';
EXEC dbo.SetupAutoTestDB;
GO
