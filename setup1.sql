-- Create Database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest_IM_27March1')
BEGIN
    CREATE DATABASE AutoTest_IM_27March1;
END
GO

-- Switch to AutoTest2DB
USE AutoTest_IM_27March1;
GO

-- Create or update Stored Procedure
IF OBJECT_ID('dbo.SetupAutoTestDB', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SetupAutoTestDB;
GO

CREATE PROCEDURE dbo.SetupAutoTestDB
AS
BEGIN
    -- Create Table if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
    BEGIN
        CREATE TABLE Users (
            Id INT PRIMARY KEY IDENTITY(1,1),
            Name NVARCHAR(100),
            Email NVARCHAR(100)
        );
    END
    -- Insert Sample Data only if not already present
    IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'john@example.com')
    BEGIN
        INSERT INTO Users (Name, Email)
        VALUES ('John Doe', 'john@example.com');
    END
    IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'jane@example.com')
    BEGIN
        INSERT INTO Users (Name, Email)
        VALUES ('Jane Smith', 'jane@example.com');
    END
END
GO

-- Execute the Stored Procedure
EXEC dbo.SetupAutoTestDB;
GO
