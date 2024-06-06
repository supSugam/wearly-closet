# Wearly Closet 🛍️

Wearly Closet is an e-commerce clothing platform where users can browse and order a wide range of clothing items. This project was developed as part of my university assessment, showcasing various features and technologies used to create a comprehensive online shopping experience.

### Screenshots & More Details at: [MyPortfolioWebsite/Projects/WearlyCloset](https://sugamsubedi.com.np/projects/wearly-closet) 🚧

## Features ✨

- **Authentication**: Secure user login and registration system.
- **Session Management**: Manage user sessions to ensure a smooth shopping experience.
- **CRUD Operations**: Create, Read, Update, and Delete products, orders, and cart items.
- **Order Management**: Complex order page to handle various aspects of order processing.
- **Visually Appealing UI/UX**: A user-friendly interface that is visually appealing and easy to navigate.
- **Search Filters**: Advanced search filters to help users find exactly what they are looking for.
- **Role-Based System**: Admin and user roles with different permissions and access levels.
- **Validation**: Proper validation to ensure data integrity and security.

## Technologies Used 🛠️

### Frontend

- **HTML**
- **CSS**
- **JavaScript**
- **JSP (JavaServer Pages)**

### Backend

- **Java**
- **Servlets**
- **DAO (Data Access Object)**
- **JDBC (Java Database Connectivity)**
- **MySQL**

### Architecture

- **MVC (Model-View-Controller)**

## How to Run the Project 🚀

### Prerequisites

- **Java Development Kit (JDK)**
- **Apache Tomcat Server**
- **MySQL Database**

### Steps to Run

1. **Clone the Repository**:

   ```sh
   git clone https://github.com/supSugam/wearly-closet.git
   ```

2. **Import the Project**: Open your preferred IDE (e.g., Eclipse, IntelliJ IDEA) and import the project as a Maven project.

3. **Configure Database**:

   - Create a MySQL database named `wearly_closet`.
   - Run the SQL scripts provided in the `db` folder to create the necessary tables and insert sample data.

4. **Update Database Configuration**:

   - Open the `db.properties` file located in the `src/main/resources` directory.
   - Update the database URL, username, and password according to your MySQL configuration.

5. **Deploy on Tomcat**:

   - Right-click the project and choose `Run As > Run on Server`.
   - Select your Apache Tomcat server and click `Finish`.

6. **Access the Application**: Open your web browser and go to `http://localhost:8080/wearly-closet`.
