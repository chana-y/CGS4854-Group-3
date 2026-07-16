Prerequisites
Before starting, please ensure you have the following installed:

Java Development Kit (JDK) 17 or higher

Apache Tomcat (Version 10+)

MySQL Server & MySQL Workbench

Step 1: Database Setup
Open MySQL Workbench and log in to your local database instance.

Open the file named schema.sql (included in this project folder).

Run the entire script to automatically create the database and the required tables (users, products, and orders).

Step 2: Configure Database Credentials
To allow the application to connect to your local MySQL database:

Navigate to src/main/java/com/cart/utils/DatabaseUtil.java.

Locate the PASS variable at the bottom of the file.

Replace "chanelyoung123" with the password for your local MySQL "root" user.

Step 3: Run the Application
Build the Project: Use your terminal or IDE to build the project into a .war file (e.g., using mvn clean package).

Deploy: Place the resulting .war file into your Tomcat webapps folder.

Start: Launch your Tomcat server.

Access: Once the server is running, open your web browser and navigate to http://localhost:8080/home to view the store.

Notes for the Grader
Security: For demonstration purposes, I have hardcoded the necessary API keys into the source code to ensure the application is ready to run immediately. In a production environment, these should be handled via system environment variables.

Email Functionality: The application is integrated with the Brevo API. Confirmation emails will be sent automatically upon checkout.

Encryption: Credit card data is stored in the database using AES-256 encryption for security.