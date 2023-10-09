select * from invoice;
select * from customer;
Q1:  who is the senior most employee based on the job title?
->   select top 1 * from dbo.employee order by levels desc ;

Q2: which countries have the most invoices?
->  select top 1 count(total) as c, billing_country
    from invoice group by billing_country order by c desc;

Q3: what are the top 3 values of total invoice?
    select top 3 total as top_3 from invoice order by top_3 desc;

Q4: Which city has the best customers? We would like to throw a promotional music festival in the city we made the most money.
    Write a query that returns one city that has the highest sum of invoice totals.Return both city name and sum of all invoice totals.

->  select billing_city,sum(total) as invoice_total from invoice group by billing_city order by invoice_total desc;

Q5: Who is the best customer? The customer who spent the most money will be declared the best customer.Write a query that returns the person 
    who has spent the most money.

->  select top 1 customer.customer_id,customer.first_name,customer.last_name ,sum(invoice.total) as total
   from customer join invoice on customer.customer_id=invoice.customer_id 
   group by customer.customer_id,customer.first_name, customer.last_name 
   order by total desc;

Q6: Return the email, first name, last name and genre of all rock music listeners. Return your list ordered alphabetically 
    by email starting with A.

->  select distinct email,first_name,last_name from customer
    join invoice on customer.customer_id=invoice.customer_id 
	join invoice_line on invoice.invoice_id=invoice_line.invoice_id
	where track_id IN(select track_id from track
	                  join genre on track.genre_id=genre.genre_id
					  where genre.name like 'Rock'
					  )
	order by email;


Q7: Lets invite the artists who have written the most rock music in our datasets. Write a query that
    returns the Artist name and total track count of the top 10 rock bands.

->  select top 10 artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
    from track
	join album on album.album_id=track.album_id
	join artist on artist.artist_id=album.artist_id
	join genre on genre.genre_id=track.genre_id
	where genre.name like 'Rock'
	group by artist.artist_id, artist.name
	order by number_of_songs desc;

Q8: Return all the track names that have a song length longer than the average song length. Return the name and milliseconds for each track.
    Order by the song length with the longest songs listed first.

->  select name,milliseconds from track 
    where milliseconds>(select avg(milliseconds) from track)
	order by milliseconds desc;
