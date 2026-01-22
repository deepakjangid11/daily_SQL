create database managementevent;
-- Create table: events
use managementevent;
-- -------------------------
CREATE TABLE events (
  event_id   INT PRIMARY KEY,
  event_name VARCHAR(100) NOT NULL,
  city       VARCHAR(50)  NOT NULL
);

-- -------------------------
-- Create table: ticket_sales
-- -------------------------
CREATE TABLE ticket_sales (
  sale_id          INT PRIMARY KEY,
  event_id         INT NOT NULL,
  sale_date        DATE NOT NULL,
  ticket_type      VARCHAR(20) NOT NULL,
  qty              INT NOT NULL,
  price_per_ticket INT NOT NULL,
  CONSTRAINT fk_ticket_sales_event
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- -------------------------
-- Insert data: events
-- -------------------------
INSERT INTO events (event_id, event_name, city) VALUES
(1, 'Music Fest', 'Mumbai'),
(2, 'Tech Summit', 'Bengaluru'),
(3, 'Food Carnival', 'Delhi'),
(4, 'Startup Meetup', 'Mumbai');

-- -------------------------
-- Insert data: ticket_sales
-- -------------------------
INSERT INTO ticket_sales (sale_id, event_id, sale_date, ticket_type, qty, price_per_ticket) VALUES
(101, 1, '2025-01-05', 'Regular', 2, 1500),
(102, 1, '2025-01-10', 'VIP',     1, 5000),
(103, 2, '2025-02-03', 'Regular', 3, 2000),
(104, 2, '2025-02-10', 'VIP',     1, 6000),
(105, 3, '2025-03-01', 'Regular', 5,  800),
(106, 3, '2025-03-15', 'VIP',     2, 2500),
(107, 4, '2025-01-20', 'Regular', 4, 1200),
(108, 4, '2025-02-05', 'Regular', 1, 1200);

-- Quick check
SELECT * FROM events ORDER BY event_id;
SELECT * FROM ticket_sales ORDER BY sale_id;

-- 1 find total qty sold per event_id.
select event_id, sum(qty) from ticket_sales group by event_id;

-- 2 Find total revenue per event_id.
select event_id, sum(qty*price_per_ticket) from ticket_sales group by event_id;

-- 3Find monthly total revenue(group by month of sale_date).
select month(sale_date), sum(qty*price_per_ticket) from ticket_sales group by month(sale_date);

-- 4 Find max price_per_ticket per event.
select event_id, max(price_per_ticket) from ticket_sales group by event_id;

-- 5 find total revenue per month and ticket_type.
select month(sale_date), ticket_type, sum(qty*price_per_ticket) from ticket_sales
 group by month(sale_date), ticket_type;

-- 6 List all sales with event_name and sale_date.
select sale_id, event_name,sale_date from events
join ticket_sales
on events.event_id = ticket_sales.event_id;

-- 7 show event_name,ticket_type, qty for each sale.
select e.event_name, t.ticket_type, t.qty from events as e
join ticket_sales as t 
on e.event_id = t.event_id;

-- 8 Show sales where the event_city is mumbai.
select sale_id, event_name, city, sale_date from events
join ticket_sales
on events.event_id = ticket_sales.event_id 
where city = 'Mumbai';

-- 9 Show all event and matching sales
select event_name, sale_id, sale_Date from events
left join ticket_sales 
on events.event_id = ticket_sales.event_id;

-- 10 show distinct event names that have atleast one sale.
select distinct event_name from events
inner join ticket_sales
on events.event_id = ticket_sales.event_id;

-- 11 show each sale's computed revenue with event name.
select event_name, sale_id, qty*price_per_ticket from events
join ticket_sales 
on events.event_id = ticket_sales.event_id;

-- 12 find total qty per event_name.
select event_name,sum(qty) from events
join ticket_sales
on events.event_id = ticket_sales.event_id 
group by event_name;

