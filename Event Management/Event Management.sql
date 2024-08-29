Create database Event_Management;
Use Event_Management;

CREATE TABLE Events (
Event_ID INT PRIMARY KEY,
Event_Name VARCHAR (25),
Event_Date DATE,
Event_Location VARCHAR (25),
Event_Description VARCHAR (50)
);

CREATE TABLE Attendees (
Attendee_ID INT PRIMARY KEY,
Attendee_Name VARCHAR (25),
Attendee_Phone VARCHAR (25),
Attendee_Email VARCHAR (25),
Attendee_City VARCHAR (15)
);

CREATE TABLE Registrations (
Registration_ID INT PRIMARY KEY,
Event_ID INT,
Attendee_ID INT,
Registration_Date DATE,
Registration_Amount DECIMAL(10,2),
FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
FOREIGN KEY (Attendee_ID) REFERENCES Attendees(Attendee_ID)
);

-- Insert sample data into the Events table
INSERT INTO Events (Event_ID, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
(1, 'Tech Conference', '2023-09-15', 'San Francisco', 'Annual tech event'),
(2, 'Music Festival', '2023-07-01', 'New York City', 'Outdoor music fest'),
(3, 'Business Summit', '2023-11-10', 'Chicago', 'Leadership training'),
(4, 'Charity Gala', '2023-05-20', 'Los Angeles', 'Fundraising event'),
(5, 'Art Exhibit', '2023-03-01', 'Seattle', 'Showcase of local art');

-- Insert sample data into the Attendees table
INSERT INTO Attendees (Attendee_ID, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
(1, 'John Doe', '555-1234', 'john.doe@email.com', 'New York'),
(2, 'Jane Smith', '555-5678', 'jane.smith@email.com', 'Los Angeles'),
(3, 'Bob Johnson', '555-9012', 'bob.johnson@email.com', 'Chicago'),
(4, 'Sarah Lee', '555-3456', 'sarah.lee@email.com', 'Seattle'),
(5, 'Michael Brown', '555-7890', 'michael.brown@email.com', 'San Francisco');

-- Insert sample data into the Registrations table
INSERT INTO Registrations (Registration_ID, Event_ID, Attendee_ID, Registration_Date, Registration_Amount)
VALUES
(1, 1, 1, '2023-09-01', 150.00),
(2, 1, 2, '2023-09-05', 150.00),
(3, 2, 2, '2023-06-15', 75.00),
(4, 2, 3, '2023-06-20', 75.00),
(5, 3, 3, '2023-11-01', 300.00),
(6, 3, 4, '2023-11-05', 300.00),
(7, 4, 4, '2023-05-10', 100.00),
(8, 4, 5, '2023-05-15', 100.00),
(9, 5, 5, '2023-02-20', 25.00);

-- Insert New event

INSERT INTO Events (Event_ID, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES (6, 'Greenenergy Business', '2023-10-01', 'San Jose', 'Showcase for Greenenergy');

-- Updating an event's information

UPDATE Events
SET Event_Name = 'Electric Cars',
	Event_Date = '2023-06-24',
    Event_Location = 'Washington DC',
    Event_Description = 'Annual Electric Car conference'
WHERE Event_ID = 3;

-- Deleting an Event

DELETE FROM Registrations WHERE Event_ID = 4; -- To delete any dependent data
DELETE FROM Events WHERE Event_ID = 4; -- To delete the event

-- Insert a New Attandee

INSERT INTO Attendees (Attendee_ID, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES (6, 'Julius Ceasar', '012-3457', 'julius.ceasar@email.com', 'New York');

-- Registering a New Attendee

INSERT INTO Registrations (Registration_ID, Event_ID, Attendee_ID, Registration_Date, Registration_Amount)
VALUES (10, 1, 5, '2023-10-07', 100.00);

-- Retrieve Event Information

SELECT 
    Event_ID,
    Event_Name,
    Event_Date,
    Event_Location,
    Event_Description
FROM 
    Events;
    
    -- Generate Attendee List
    
    SELECT
    a.Attendee_ID,
    a.Attendee_Name,
    a.Attendee_Phone,
    a.Attendee_Email,
    a.Attendee_City
FROM
    Attendees a
INNER JOIN Registrations r
    ON a.Attendee_ID = r.Attendee_ID
WHERE
    r.Event_ID = 3;
    
    -- Event Attendance 
    
    SELECT
    e.Event_ID,
    e.Event_Name,
    COUNT(r.Registration_ID) AS Number_Of_Attendees
FROM
    Events e
LEFT JOIN Registrations r
    ON e.Event_ID = r.Event_ID
GROUP BY
    e.Event_ID, e.Event_Name
ORDER BY
    Number_Of_Attendees DESC;