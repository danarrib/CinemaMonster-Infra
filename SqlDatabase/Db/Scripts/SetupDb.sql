SELECT 'DROP TABLE [' + T.TABLE_SCHEMA + '].[' + T.TABLE_NAME + '];' 
FROM INFORMATION_SCHEMA.TABLES T WHERE TABLE_TYPE = 'BASE TABLE'

DROP TABLE [dbo].[__EFMigrationsHistory];
DROP TABLE [dbo].[OrderDetail];
DROP TABLE [dbo].[Order];
DROP TABLE [dbo].[OrderStatus];
DROP TABLE [dbo].[PaymentMethod];
DROP TABLE [dbo].[Seat];
DROP TABLE [dbo].[SeatType];
DROP TABLE [dbo].[MovieSession];
DROP TABLE [dbo].[Auditorium];
DROP TABLE [dbo].[AuditoriumType];
DROP TABLE [dbo].[Movie];
DROP TABLE [dbo].[MovieGenre];
DROP TABLE [dbo].[Cinema];
DROP TABLE [dbo].[City];
DROP TABLE [dbo].[State];
DROP TABLE [dbo].[Customer];

INSERT INTO [State] SELECT 'SP', 'São Paulo', GETDATE(), NULL;
INSERT INTO [State] SELECT 'RJ', 'Rio de Janeiro', GETDATE(), NULL;
INSERT INTO [State] SELECT 'SP', 'Paraná', GETDATE(), NULL;

INSERT INTO City SELECT 'São Paulo', 1, GETDATE(), NULL;
INSERT INTO City SELECT 'Osasco', 1, GETDATE(), NULL;
INSERT INTO City SELECT 'Rio de Janeiro', 2, GETDATE(), NULL;
INSERT INTO City SELECT 'Niteroi', 2, GETDATE(), NULL;
INSERT INTO City SELECT 'Curitiba', 3, GETDATE(), NULL;
INSERT INTO City SELECT 'Foz do Iguaçu', 3, GETDATE(), NULL;

INSERT INTO Cinema SELECT 'Cinemark Pátio Paulista', 1, 'Rua Treze de Maio, 1234, Piso 3', 1, GETDATE(), NULL;
INSERT INTO Cinema SELECT 'Cinépolis JK Iguatemi', 1, 'Rua Juscelink Kubscheck, 1234, Piso 4', 1, GETDATE(), NULL;
INSERT INTO Cinema SELECT 'Espaço Itaú Shopping Eldorado', 1, 'Avenida Rebolsas, 1234, Piso 5', 1, GETDATE(), NULL;
INSERT INTO Cinema SELECT 'Cinemark Super Shopping', 2, 'Av Bussocaba, 1234', 1, GETDATE(), NULL;
INSERT INTO Cinema SELECT 'Cinemark Barra Shopping', 3, 'Av Ipanema, 1234, Piso 1', 1, GETDATE(), NULL;

INSERT INTO MovieGenre SELECT 'Action', GETDATE(), NULL;
INSERT INTO MovieGenre SELECT 'Adventure', GETDATE(), NULL;
INSERT INTO MovieGenre SELECT 'Animation', GETDATE(), NULL;
INSERT INTO MovieGenre SELECT 'Comedy', GETDATE(), NULL;
INSERT INTO MovieGenre SELECT 'Drama', GETDATE(), NULL;

INSERT INTO Movie SELECT 'Homem Aranha - Sem volta pra casa', 'Spider Man - No Way Home', '', '2021-12-17', 2021, 1, 'O Homem-Aranha precisa lidar com as consequências da sua verdadeira identidade ter sido descoberta.', 140, GETDATE(), NULL;
INSERT INTO Movie SELECT 'Matrix - Ressurections', 'Matrix - Ressurections', '', '2021-12-17', 2021, 1, 'Da visionária realizadora Lana Wachowski chega-nos MATRIX RESURRECTIONS o tão aguardado 4º filme do inovador franchise que redefiniu o género. O novo filme reúne os protagonistas originais Keanu Reeves e Carrie-Anne Moss nos icónicos personagens que os tornaram famosos, Neo e Trinity.', 130, GETDATE(), NULL;
INSERT INTO Movie SELECT 'TENET', 'TENET', '', '2020-10-29', 2020, 1, 'Um agente secreto embarca em uma missão perigosa para evitar o início da Terceira Guerra Mundial.', 125, GETDATE(), NULL;
INSERT INTO Movie SELECT 'Toy Story', 'Toy Story', '', '2011-12-17', 2011, 3, 'O aniversário do garoto Andy está chegando e seus brinquedos ficam nervosos, temendo que ele ganhe novos brinquedos que possam substituí-los. Liderados pelo caubói Woody, o brinquedo predileto de Andy, eles recebem Buzz Lightyear, o boneco de um patrulheiro espacial, que logo passa a receber mais atenção do garoto. Com ciúmes, Woody tenta ensiná-lo uma lição, mas Buzz cai pela janela. É o início da aventura do caubói, que precisa resgatar Buzz para limpar sua barra com os outros brinquedos.', 120, GETDATE(), NULL;

INSERT INTO AuditoriumType SELECT 'Standard', GETDATE(), NULL;
INSERT INTO AuditoriumType SELECT 'IMAX', GETDATE(), NULL;

INSERT INTO Auditorium
SELECT 'Auditorium ' + CONVERT(varchar(10), (ROW_NUMBER() OVER (PARTITION BY C.ID ORDER BY C.ID))) as [Name], C.ID As CinemaID, AUT.ID as AuditoriumTypeID,
10 as SeatRows, 15 as SeatColumns, CASE WHEN AUT.ID = 1 THEN 40 ELSE 50 END as BaseTicketPrice, 1, GETDATE(), NULL
FROM Cinema C
CROSS JOIN AuditoriumType AUT

INSERT INTO SeatType SELECT 'Standard', '', 0, 0, 0, GETDATE(), NULL;
INSERT INTO SeatType SELECT 'VIP', '', 0, 1, 0, GETDATE(), NULL;
INSERT INTO SeatType SELECT 'WheelChair', '', 0, 0, 1, GETDATE(), NULL;
INSERT INTO SeatType SELECT 'Handcap', '', 1, 0, 0, GETDATE(), NULL;

WITH Nbrs (Number) AS (SELECT 1 UNION ALL SELECT 1 + Number FROM Nbrs WHERE Number < 99)
INSERT INTO Seat
SELECT V.RowChar +'-'+CONVERT(varchar(10), CN.Number) as [Name], RN.Number as RowNumber, CN.Number as ColumnNumber,
	A.ID as AuditoriumID, CASE 
		WHEN RN.Number BETWEEN 5 and 8 AND CN.Number BETWEEN 5 AND 10 THEN 2 
		WHEN RN.Number BETWEEN 2 and 3 AND CN.Number BETWEEN 7 AND 9 THEN 3
		WHEN RN.Number = 10 AND CN.Number BETWEEN 2 AND 4 THEN 4
		ELSE 1 END as SeatTypeID,
		1, GETDATE(), NULL
FROM Auditorium A
INNER JOIN Nbrs CN ON CN.Number <= A.SeatColumns
INNER JOIN Nbrs RN ON RN.Number <= A.SeatRows
INNER JOIN VW_RowNumberChar V ON V.RowNumber = RN.Number
ORDER BY A.ID, RN.Number, CN.Number


WITH Nbrs (Number) AS (SELECT 0 UNION ALL SELECT 1 + Number FROM Nbrs WHERE Number < 90)
INSERT INTO MovieSession 
SELECT M.ID as MovieID, A.ID as AuditoriumID, 
DATEADD(hh, HR.Number, DATEADD(dd, DA.Number, CAST(CAST(GETDATE() AS Date) as Datetime))) as ScheduledDateTime, 
CASE WHEN HR.Number IN (12, 18) THEN 1 ELSE 0 END as Flg_Dubbed, CASE WHEN HR.Number IN (18, 21) THEN 1 ELSE 0 END as Flg_3D, 
A.BaseTicketPrice as TicketRetailPrice, 0 as SoldOut, 1 as [Enabled], GETDATE(), NULL
FROM Nbrs as HR
CROSS JOIN Movie M
CROSS JOIN Auditorium A
CROSS JOIN Nbrs DA
WHERE HR.Number IN (12, 15, 18, 21)
AND DA.Number <= 30

INSERT INTO PaymentMethod SELECT 'Credit Card', GETDATE(), NULL;

UPDATE Movie SET Poster = 'assets/spider300.jpg' WHERE ID = 1
UPDATE Movie SET Poster = 'assets/matrix300.jpg' WHERE ID = 2
UPDATE Movie SET Poster = 'assets/tenet300.jpg' WHERE ID = 3
UPDATE Movie SET Poster = 'assets/toystory300.jpg' WHERE ID = 4