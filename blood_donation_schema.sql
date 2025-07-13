use blood_don_db;

-- Create Donor Table
CREATE TABLE donor (
    donor_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    age INT CHECK (age >= 18) NOT NULL,  -- Only allow donors aged 18 or more
    gender VARCHAR(10) NOT NULL,
    phone_no BIGINT UNIQUE,  -- Ensure phone number is unique
    blood_type VARCHAR(5) NOT NULL,
    PRIMARY KEY (donor_id)
);

-- Create BloodBank Table
CREATE TABLE blood_bank (
    bank_id INT AUTO_INCREMENT,
    bank_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (bank_id)
);

-- Create Donation Table with Foreign Key Constraints
CREATE TABLE donation (
    donation_id INT AUTO_INCREMENT,
    d_donor_id INT,
    d_bank_id INT,
    date DATE,
    time TIME,
    volume INT,
    PRIMARY KEY (donation_id),
    FOREIGN KEY (d_donor_id) REFERENCES donor(donor_id) ON DELETE CASCADE,  -- Cascade delete donations if donor is deleted
    FOREIGN KEY (d_bank_id) REFERENCES blood_bank(bank_id) ON DELETE SET NULL  -- Set d_bank_id to NULL if blood bank is deleted
);

CREATE TABLE bb_location (
    location VARCHAR(100),
    bb_bank_id INT,
    FOREIGN KEY (bb_bank_id) REFERENCES blood_bank(bank_id) ON DELETE SET NULL
);

-- Create BloodUnit Table with Foreign Key Constraints
CREATE TABLE blood_unit (
    unit_id INT AUTO_INCREMENT,
    expiry_date DATE,
    quantity INT,
    status VARCHAR(20),
    blood_type VARCHAR(5),
    bu_donation_id INT,
    PRIMARY KEY (unit_id)
);

-- Create Patient Table
CREATE TABLE patient (
    pid INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    age INT,
    phone_number BIGINT UNIQUE,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    hospital_name VARCHAR(100),
    PRIMARY KEY (pid)  -- Ensure phone number is unique for each patient
);

-- Create BloodRequest Table with Foreign Key Constraints
CREATE TABLE bloodrequest (
    request_id INT AUTO_INCREMENT,
    br_patient_id INT,
    br_unit_id INT,
    blood_type VARCHAR(5),
    date DATE,
    quantity INT,
    status VARCHAR(20),
    PRIMARY KEY (request_id),
    FOREIGN KEY (br_patient_id) REFERENCES patient(pid) ON DELETE CASCADE,
    FOREIGN KEY (br_unit_id) REFERENCES blood_unit(unit_id) ON DELETE SET NULL
);

-- Modify blood_bank table to add bb_unit_id
ALTER TABLE blood_bank
    ADD COLUMN bb_unit_id INT;

-- Then you can create the foreign key constraint
ALTER TABLE blood_bank
    ADD CONSTRAINT fk_blood_unit FOREIGN KEY (bb_unit_id) REFERENCES blood_unit(unit_id) ON DELETE SET NULL;

alter table blood_unit
add column bu_donation_id INT;

alter table blood_unit
add constraint fk_donation foreign key(bu_donation_id) references donation(donation_id) on delete cascade;

show tables;

--DESCRIPTION QUERIES
desc donor;
desc patient;
desc blood_bank;
desc bloodrequest;
desc blood_unit;
desc bb_location;
desc donation;

show create table donation;
show create table blood_bank;
show create table bloodrequest;
show create table blood_unit;
show create table patient;
show create table bb_location;
show create table donor;

--INSERT QUERIES
INSERT INTO donor (donor_id,first_name, last_name, age, gender, phone_no, blood_type) VALUES
(101,'Aarav', 'Sharma', 25, 'Male', 9123456701, 'A+'),
(102,'Priya', 'Verma', 28, 'Female', 3423456702, 'B+'),
(103,'Rahul', 'Mehta', 32, 'Male', 9933456703, 'O-'),
(104,'Sneha', 'Patil', 24, 'Female', 9122346704, 'AB+'),
(105,'Karan', 'Iyer', 29, 'Male', 9100256705, 'O+'),
(106,'Ananya', 'Reddy', 26, 'Female', 3413456706, 'B-');

INSERT INTO donation (d_donor_id, d_bank_id, date, time, volume) VALUES
(101, 1, '2025-04-10', '10:30:00', 450),
(102, 2, '2025-04-12', '11:15:00', 500),
(103, 3, '2025-04-14', '09:45:00', 450),
(104, 4, '2025-04-15', '13:00:00', 480),
(105, 5, '2025-04-16', '14:20:00', 500),
(106, 6, '2025-04-18', '10:00:00', 460);

INSERT INTO blood_unit (expiry_date, quantity, status, blood_type, bu_donation_id) VALUES
('2025-06-10', 450, 'Available', 'A+', 1001),
('2025-06-12', 500, 'Available', 'B+', 1002),
('2025-06-14', 450, 'Used', 'O-', 1003),
('2025-06-15', 480, 'Available', 'AB+', 1004),
('2025-06-16', 500, 'Available', 'O+', 1005),
('2025-06-18', 460, 'Used', 'B-', 1006);

INSERT INTO blood_bank (bank_name) VALUES
('Indian Red Cross Society, Bengaluru'),
('Rotary Blood Bank, Delhi'),
('Tata Memorial Blood Bank, Mumbai'),
('Apollo Blood Centre, Hyderabad'),
('AIIMS Blood Bank, Delhi'),
('Fortis Blood Bank, Chennai');

INSERT INTO bb_location (location, bb_bank_id) VALUES
('Bengaluru', 1),
('Delhi', 2),
('Mumbai', 3),
('Hyderabad', 4),
('Delhi', 5),
('Chennai', 6);

INSERT INTO patient (first_name, last_name, age, phone_number, gender, blood_type, hospital_name) VALUES
('Ravi', 'Kumar', 45, 9876543201, 'Male', 'A+', 'Narayana Health, Bengaluru'),
('Meena', 'Joshi', 34, 9876543202, 'Female', 'B+', 'AIIMS, Delhi'),
('Vikram', 'Nair', 29, 9876543203, 'Male', 'O-', 'KEM Hospital, Mumbai'),
('Pooja', 'Rao', 38, 9876543204, 'Female', 'AB+', 'Apollo Hospital, Hyderabad'),
('Arjun', 'Das', 41, 9876543205, 'Male', 'O+', 'Fortis Hospital, Chennai'),
('Neha', 'Mishra', 27, 9876543206, 'Female', 'B-', 'Max Hospital, Delhi');

INSERT INTO bloodrequest (br_patient_id, br_unit_id, blood_type, date, quantity, status) VALUES
(1, 101, 'A+', '2025-05-01', 450, 'Fulfilled'),
(2, 102, 'B+', '2025-05-03', 500, 'Fulfilled'),
(3, 103, 'O-', '2025-05-04', 450, 'Pending'),
(4, 104, 'AB+', '2025-05-06', 480, 'Fulfilled'),
(5, 105, 'O+', '2025-05-08', 500, 'Pending'),
(6, 6, 'B-', '2025-05-10', 460, 'Fulfilled');

--SELECT QUERIES
select * from donor;
select * from bloodrequest;
select * from blood_unit;
select * from patient;
select * from bb_location;
select * from blood_bank;
select * from donation;

--INNER JOIN ON CONDITION
SELECT 
p.first_name AS patient_name, d.first_name AS donor_name, p.age AS patient_age, d.age AS donor_age
FROM 
patient p
INNER JOIN 
donor d 
ON 
p.age > d.age;

--INNER JOIN(EQUIJOIN)
SELECT donor.first_name, donor.last_name, donation.date, donation.volume
FROM donor
INNER JOIN donation ON donor.donor_id = donation.d_donor_id;

--INNER JOIN (NATURAL JOIN), no common columns results in CROSS JOIN
SELECT *
FROM donor
NATURAL JOIN donation;

--LEFT OUTER JOIN
SELECT donor.donor_id, donor.first_name, donation.donation_id, donation.date
FROM donor
LEFT JOIN donation ON donor.donor_id = donation.d_donor_id;

--RIGHT OUTER JOIN
SELECT donation.donation_id, donor.first_name, donation.date
FROM donor
RIGHT JOIN donation ON donor.donor_id = donation.d_donor_id;

--FULL OUTER JOIN
-- LEFT part
SELECT donor.donor_id, donor.first_name, donation.donation_id, donation.date
FROM donor
LEFT JOIN donation ON donor.donor_id = donation.d_donor_id

UNION

-- RIGHT part
SELECT donor.donor_id, donor.first_name, donation.donation_id, donation.date
FROM donor
RIGHT JOIN donation ON donor.donor_id = donation.d_donor_id;

--TOTAL DONORS
SELECT COUNT(*) AS total_donors FROM donor;

--TOTAL VOLUME DONATED
SELECT SUM(volume) AS total_volume_donated FROM donation;

--AVERAGE AGE OF PATIENTS
SELECT AVG(age) AS average_patient_age FROM patient;

--MAX AND MIN QUANTITY OF BLOOD UNIT
SELECT MAX(quantity) AS max_quantity, MIN(quantity) AS min_quantity
FROM blood_unit;

--NUMBER OF DONORS BY BLOOD TYPE
SELECT blood_type, COUNT(*) AS donor_count
FROM donor
GROUP BY blood_type;

--TOTAL VOLUME DONATED PER BLOOD BANK
SELECT blood_bank.bank_name, SUM(donation.volume) AS total_volume
FROM donation
JOIN blood_bank ON donation.d_bank_id = blood_bank.bank_id
GROUP BY blood_bank.bank_name;
