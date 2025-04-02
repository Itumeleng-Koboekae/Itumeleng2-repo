-- Create Database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest_IM_27March1')
BEGIN
    CREATE DATABASE AutoTest_IM_27March1;
END
GO

-- Switch to AutoTest_IM_27March1
USE AutoTest_IM_27March1;
GO

-- Create or update Stored Procedure
IF OBJECT_ID('dbo.SetupAutoTestDB', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SetupAutoTestDB;
GO

CREATE PROCEDURE dbo.SetupAutoTestDB
AS
BEGIN
    BEGIN TRY
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
    END TRY
    BEGIN CATCH
        -- Capture error details
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        -- Raise the error to be captured by sqlcmd
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- Execute the Stored Procedure with error handling
BEGIN TRY
    EXEC dbo.SetupAutoTestDB;
END TRY
BEGIN CATCH
    DECLARE @ExecErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ExecErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ExecErrorState INT = ERROR_STATE();
    RAISERROR (@ExecErrorMessage, @ExecErrorSeverity, @ExecErrorState);
END CATCH
GO
