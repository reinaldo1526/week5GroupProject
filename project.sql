CREATE TABLE service_ticket(
	Ticket_Num SERIAL PRIMARY KEY,
	Service VARCHAR(500),
	service_Cost Numeric(8,2)
);
CREATE TABLE invoice(
	Invoice_ID SERIAL PRIMARY KEY,
	Total_Cost Numeric(8,2)
);
CREATE TABLE mechanics(
	Mech_ID SERIAL PRIMARY KEY,
	First_NAME VARCHAR(25),
	Last_NAME VARCHAR(25),
	ticket_num INTEGER NOT NULL,
	FOREIGN KEY(ticket_num) REFERENCES service_ticket(Ticket_Num)
);
CREATE TABLE parts(
	Part_Num SERIAL PRIMARY KEY,
	Part_Name VARCHAR(100),
	Part_Price Numeric(8,2),
	ticket_num INTEGER NOT NULL,
	FOREIGN KEY(ticket_num) REFERENCES service_ticket(Ticket_Num)
);
CREATE TABLE sales_person(
	Emp_ID SERIAL PRIMARY KEY,
	First_Name VARCHAR(25),
	Last_Name VARCHAR(25),
	invoice_ID INTEGER NOT NULL,
	FOREIGN KEY(invoice_ID) REFERENCES invoice(Invoice_ID)
);
CREATE TABLE customer(
	Cust_ID SERIAL PRIMARY KEY,
	First_Name VARCHAR(25),
	Last_Name VARCHAR(25),
	invoice_ID INTEGER NOT NULL,
	ticket_num INTEGER NOT NULL,
	FOREIGN KEY(invoice_ID) REFERENCES invoice(Invoice_ID),
	FOREIGN KEY(ticket_num) REFERENCES service_ticket(Ticket_Num)
);
CREATE TABLE cars(
	Serial_Number SERIAL PRIMARY KEY,
	Color VARCHAR(25),
	Make VARCHAR(25),
	Model VARCHAR(25),
	Car_Price Numeric(8,2),
	invoice_ID INTEGER NOT NULL,
	ticket_num INTEGER NOT NULL,
	FOREIGN KEY(invoice_ID) REFERENCES invoice(Invoice_ID),
	FOREIGN KEY(ticket_num) REFERENCES service_ticket(Ticket_Num)
);
--ALTERING TABLES
ALTER TABLE service_ticket
	ADD cust_ID INTEGER NOT NULL,
	ADD mech_ID INTEGER NOT NULL,
	ADD serial_number INTEGER NOT NULL,
	ADD part_num INTEGER NOT NULL,
	ADD FOREIGN KEY(cust_ID) REFERENCES customer(Cust_ID),
	ADD FOREIGN KEY(mech_ID) REFERENCES mechanics(Mech_ID),
	ADD FOREIGN KEY(serial_number) REFERENCES cars(Serial_Number),
	ADD FOREIGN KEY(part_num) REFERENCES parts(Part_Num);
ALTER TABLE invoice
	ADD emp_ID INTEGER NOT NULL,
	ADD serial_number INTEGER NOT NULL,
	ADD cust_ID INTEGER NOT NULL,
	ADD FOREIGN KEY(emp_ID) REFERENCES sales_person(Emp_ID),
	ADD FOREIGN KEY(serial_number) REFERENCES cars(Serial_Number),
	ADD FOREIGN KEY(cust_ID) REFERENCES customer(Cust_ID);