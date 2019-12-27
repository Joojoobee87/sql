/* Similar Query to above, but join the track table to the Genre table, show the names of the tracks and genres in the results. Figure out the columns you can join on, any aliases that you need. Filter the results to only show 'Jazz' tracks

            Expected: 130 rows (Here's a sample, actual tracks may be different)

            Desafinado	                              Jazz
            Garota De Ipanema	                      Jazz
            Samba De Uma Nota Só (One Note Samba)	  Jazz
            */
SELECT Track.Name as Track, Genre.Name as Genre FROM Track
INNER JOIN Genre ON Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Jazz';
 /* Create a Query that shows: The name of a track, the name of it's MediaType, and the name of it's genre. You'll need to join 3 tables together with the appropriate join columns. Add a filter to only show tracks with a MediaType of "Protected AAC audio file" and a Genre of "Soundtrack".

            Expected: 1 row

            Koyaanisqatsi	    Protected AAC audio file	    Soundtrack */

SELECT Track.Name AS Track, MediaType.Name as MediaType, Genre.Name AS Genre FROM Track
INNER JOIN Genre ON Track.GenreId = Genre.GenreId
INNER JOIN MediaType ON Track.MediaTypeId = MediaType.MediaTypeId
WHERE MediaType.Name = 'Protected AAC audio file' AND Genre.Name = 'Soundtrack';

/* Filter to only show results for the 'Grunge' playlist

            Expected: 15 rows (example)

            Grunge	  Hunger Strike	      Temple of the Dog	      Temple of the Dog
            Grunge	  Man In The Box	  Facelift	              Alice In Chains
            Grunge	  Evenflow	          Ten	                  Pearl Jam */

SELECT Track.Name AS Track, Playlist.Name AS Playlist FROM Track
INNER JOIN PlaylistTrack ON Track.TrackId = PlaylistTrack.TrackId
INNER JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
WHERE Playlist.Name = 'Grunge';

/* Find a playlist that contains only 1 track. */
  
SELECT Playlist.Name as Playlist, COUNT(*) From Playlist 
INNER JOIN PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId  
GROUP BY Playlist HAVING count(*) = 1;

/* Select the InvoiceDate, BillingAddress, and Total from the Invoices table, Ordered by InvoiceDate Descending

Expected : 412 rows (starting with the following) */

SELECT InvoiceDate, BillingAddress, Total FROM Invoice
ORDER BY InvoiceDate desc;

/* We need to fire the last three people hired.

Select the EmployeeId, LastName, FirstName and HireDate of the 3 Employees with the most recent HireDate

Expected : 3 rows (starting with the following) */

SELECT EmployeeId, LastName, FirstName, HireDate FROM Employee
ORDER BY HireDate desc
LIMIT 3;

/* Disaster, we've heard from Steve Johnson's lawyers.

He claims that Michael Mitchell was hired on the same day as him, but was hired later in the day. Mitchell should have been let go, not him.

Confirm this by extending the number of results and make sure nobody else was hired on that day.

Then modify the query to return the correct 3 people.

Continue to use HireDate as the primary sort column, but use EmployeeId as the tie breaker.

Assume that a higher EmployeeId means they were hired later.

Expected : 3 rows (starting with the following) */

SELECT EmployeeId, LastName, FirstName, HireDate FROM Employee
ORDER BY HireDate desc, EmployeeId desc
LIMIT 3;

/* Create a query that shows our 10 biggest invoices by Total value, in descending order.

If two invoices have the same Total, the more recent should appear first.

The query should also show the Name of the Customer

Expected: 10 rows */

SELECT CONCAT(Customer.FirstName, ' ', Customer.LastName) AS CustomerName, InvoiceDate, Total FROM Customer
INNER JOIN Invoice ON Invoice.CustomerId = Customer.CustomerId
ORDER BY Total desc
LIMIT 10;

/* How Many Customers is Employee 4 the Sales Support Agent For? */

SELECT COUNT(*) FROM Customer
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
WHERE EmployeeId = '4';

/* How Many Customers is Jane Peacock the Sales Support Agent For? */

SELECT COUNT(*) FROM Customer
INNER JOIN Employee ON Customer.SupportRepId = Employee.EmployeeId
WHERE Employee.FirstName = 'Jane' AND Employee.LastName = 'Peacock';

/* Which Media Type is most popular? How could you answer this with a single query? 
You probably cannot based on what you know so far. We will get there.*/

/* What is the date of birth of our oldest employee? */

SELECT MIN(Employee.BirthDate) FROM Employee;

/* On what date was our most recent employee hired? */

SELECT MAX(Employee.HireDate) FROM Employee;

/* How many customers do we have in the City of Berlin Expected : 2 */

SELECT City, COUNT(*) FROM Customer
WHERE Customer.City = 'Berlin';

/* How much has been made in sales for the track "The Woman King". Expected : 3.98 */

SELECT Track.Name, SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity) FROM Track
INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
WHERE Track.Name = 'The Woman King';

/* Create a list of the top 5 acts by number of tracks. The table should include the name of the artist and the number of tracks they have.

            Iron Maiden	    213
            U2	            135
            Led Zeppelin	114
            Metallica	    112
            Deep Purple	    92
            */

SELECT Artist.Name, COUNT(*) FROM Track
INNER JOIN Album ON Track.AlbumId = Album.AlbumId
INNER JOIN Artist ON Album.ArtistId = Artist.ArtistId
GROUP BY Artist.Name
ORDER BY COUNT(*) desc
LIMIT 5;

/* Insert the remaining Tracks for the Album Boy (except for the last 2-3, insert those as part of Challenge Three) */

INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice) 
VALUES ("Twilight", 348, 2, 1, "U2", 210000, 1234, 0.99);

/* Run the following Query. It gives an error. Read and understand the error, then fix the problem

            Insert into Track (Name, AlbumId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
            values("Extra Track", 348, 1, "U2", 290000, 1234, 0.99);
            */
Insert into Track (Name, AlbumId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
values("Extra Track", 348, 1, "U2", 290000, 1234, 0.99);

/* Use one insert statement to insert multiple tracks at the same time */

  
INSERT INTO Track
    (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES
    ("Another Time, Another Place", 348, 2, 1, "U2", 210000, 1234, 0.99),
    ("The Electric Co.", 348, 2, 1, "U2", 200000, 1234, 0.99),
    ("Shadows and Tall Trees", 348, 2, 1, "U2", 150000, 1234, 0.99)
