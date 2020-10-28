--3. Create table driverStat
USE MidTerm_4223
CREATE TABLE dbo.driverStat
(
	ID_STAT numeric IDENTITY(1,1) NOT NULL,
	DESC_STAT TEXT,
	DATE_STAT datetime,
	CONSTRAINT [PK_driverStat] PRIMARY KEY CLUSTERED
	(
		ID_STAT ASC
	)
)

--4. Create triger
CREATE TRIGGER Zad_4 ON dbo.Bus
AFTER INSERT 
AS
	DECLARE @vehicleID numeric
	SELECT @vehicleID = dbo.Bus.vehicle FROM inserted

	DECLARE @scheduleID numeric
	SELECT @scheduleID = dbo.Bus.Scheduleid FROM inserted
	
	INSERT INTO driverStat(opis, vreme)

	VALUES('A new vehicle has been inserted with ID ' + @vehicleID + ' which will go on a route  ' + @scheduleID, GETDATE());


----5. Create procedure
GO
CREATE PROCEDURE Zad_5 @vehicle_ID NUMERIC
AS
SELECT stopid, arrival, vehicle
	FROM BUS AS B 
		INNER JOIN SCHEDULE AS S
	ON B.vehicle=S.id
		INNER JOIN ROUTE AS R
	ON R.id=S.RouteId
		INNER JOIN RouteStop AS RS
	ON R.id=RS.RouteId

	WHERE vehicle = @vehicle_ID
GO

EXEC Zad_5 2


--6. Create function
CREATE FUNCTION dbo.zad6
(
	@MyDate DATETIME
)
RETURNS INT
AS
BEGIN
	SET @MyDate = GETDATE()
	RETURN DAY(DATEADD(DD,-1,DATEADD(MM,DATEDIFF(MM,-1,@MyDate),0)))
END
GO


--7. Create view
GO
CREATE VIEW Zad_7
AS
	SELECT S.name, S.Terminus, S.id, R.id 
	FROM Stop AS S 
		INNER JOIN RouteStop 
	AS RS
	ON S.id = RS.Stopid
		INNER JOIN ROUTE AS R
	ON R.id = RS.Routeid

