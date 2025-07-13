# 🩸 Blood Donation Database (MySQL)

This project provides a complete MySQL schema for managing a blood donation system. It includes tables for donors, blood banks, donations, blood units, patients, and blood requests, along with realistic sample data and useful SQL queries.

## 📂 Database: `blood_don_db`

### 🏗️ Tables Included

- `donor` – Stores donor details (name, age, gender, blood type, phone).
- `blood_bank` – Information about blood banks.
- `bb_location` – Locations of each blood bank.
- `donation` – Records of blood donations.
- `blood_unit` – Details about collected blood units.
- `patient` – Patient records including hospital and blood type.
- `bloodrequest` – Requests made for blood units by patients.

## 🔗 Relationships

- `donation.d_donor_id` → `donor.donor_id`
- `donation.d_bank_id` → `blood_bank.bank_id`
- `blood_unit.bu_donation_id` → `donation.donation_id`
- `bloodrequest.br_patient_id` → `patient.pid`
- `bloodrequest.br_unit_id` → `blood_unit.unit_id`
- `bb_location.bb_bank_id` → `blood_bank.bank_id`
- `blood_bank.bb_unit_id` → `blood_unit.unit_id`

## 🧪 Sample Data

The schema includes `INSERT` statements to populate:
- 6 donors
- 6 patients
- 6 blood banks and their locations
- 6 donations
- 6 blood units
- 6 blood requests

## 📊 Query Samples

- Count total donors
- Average age of patients
- Total volume of blood donated
- Donor-patient comparisons using JOINs (INNER, LEFT, RIGHT, FULL)
- Grouping donors by blood type
- Donation volume per blood bank

## ▶️ How to Use

1. Create the database:
   ```sql
   CREATE DATABASE blood_don_db;
   USE blood_don_db;

2. Run the SQL file:

   ```bash
   mysql -u your_user -p blood_don_db < blood_donation_schema.sql
   ```

3. Explore tables, relationships, and queries.
