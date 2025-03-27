-- Create Database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Test3DB')
BEGIN
    CREATE DATABASE Test3DB;
END
GO

-- Switch to Test3DB
USE Test3DB;
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
