# SpringBoot RESTful API Project

This is a Spring Boot REST API project that connects to a **PostgreSQL** database and return two endpoints in json listing all subjects associated with Software Engineering 
programme and list of students studying the programme respectively. Follow the instructions below to set up and run the project on your local machine.

---

## 🚀 Prerequisites

Before you start, ensure you have the following installed:

1. **Java 17** or later  
   - Download from [Oracle](https://www.oracle.com/java/technologies/javase-downloads.html).
   - Verify installation:
     
     ```sh
     java -version
     ```
   
2. **Maven 3.8+** (for building the project)  
   - Download from [Maven](https://maven.apache.org/download.cgi).
   - Verify installation:
     
     ```sh
     mvn -version
     ```

3. **PostgreSQL 14+** (or use a cloud-hosted PostgreSQL instance)  
   - Install from [PostgreSQL Official Site](https://www.postgresql.org/download/).
   - Ensure the database is running and accessible.

4. **Git** (to clone the repository)  
   - Download from [Git](https://git-scm.com/downloads).
   - Verify installation:
     
     ```sh
     git --version
     ```

---

## 👥 Cloning the Repository

To get a copy of this project, run:

```sh
git clone https://github.com/Ymwemanoor/springboot-api.git
cd springboot-api
```

---

## ⚙️ Configuration

### **1. Database Setup**
Ensure you have a PostgreSQL database created before running the application.  

Run the following SQL to create a database:

```sql
CREATE DATABASE rest-api;
```

If you created a specific user for this database, make sure it has full privileges: Or else just use the postgres user created automatically when installing postgresql

```sql
CREATE USER myapp_user WITH ENCRYPTED PASSWORD 'myapp_password';
GRANT ALL PRIVILEGES ON DATABASE rest-api TO myapp_user;
```
**Replace myapp_user and myapp_password with the user and password you are using in postgresql throught out this documentation**

### **2. Update `application.properties`**
Modify the database credentials in `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/rest-api
spring.datasource.username=myapp_user
spring.datasource.password=myapp_password
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true
```

If using **Docker** for PostgreSQL, update the `spring.datasource.url` to:

```properties
spring.datasource.url=jdbc:postgresql://host.docker.internal:5432/rest-api
```

---

## 🛠️ Running the Project
```sh
mvn spring-boot:run
```

or use:

### **1. Build the Project**
Run the following command to compile and package the application:

```sh
mvn clean package
```

### **2. Run the Application**
Run the JAR file after a successful build:

```sh
java -jar target/rest-api-0.0.1-SNAPSHOT.jar
```
---

## 🛠️ Running the Project with Docker (Optional)

If you prefer using **Docker**, you can run PostgreSQL with:

```sh
docker run --name postgres-db -e POSTGRES_DB=rest-api -e POSTGRES_USER=myapp_user -e POSTGRES_PASSWORD=myapp_password -p 5432:5432 -d postgres
```

Check if the container is running:

```sh
docker ps
```

---

## 💌 API Endpoints

| Method | Endpoint          | Description |
|--------|------------------|-------------|
| GET    | `/students`      | Get all students |
| GET    | `/subjects`      | Get all subjects |
---

## ✅ Testing the API

You can test the API using **Postman** or **Web Browser**:

```sh
http://localhost:8080/students
http://localhost:8080/subjects
```

---

## 🛡️ Stopping the Application

If running in the foreground, press `CTRL + C` to stop it.

If running in the background (JAR mode), find the process ID and kill it:

```sh
ps aux | grep java
kill -9 <PID>
```

---

## 🎯 Troubleshooting

### **1. Port 5432 (PostgreSQL) Already in Use**
If PostgreSQL fails to start because the port is occupied, find and kill the process:

```sh
sudo lsof -i :5432
sudo kill -9 <PID>
```

### **2. Database Connection Issues**
Ensure PostgreSQL is running and accepting connections:

```sh
sudo systemctl start postgresql
```

Check logs if there are errors:

```sh
sudo journalctl -u postgresql --no-pager | tail -n 20
```

---

## 🤝 Contributing

If you’d like to contribute:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit (`git commit -m "Your Message"`).
4. Push to your fork (`git push origin feature-branch`).
5. Open a pull request.

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 🌟 Acknowledgments

Thanks to all contributors! If you find this project useful, **Give it a star ⭐ on GitHub!**

