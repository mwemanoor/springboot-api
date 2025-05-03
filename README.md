# Spring Boot RESTful API Project

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

To create a new user and give access to the database `rest-api` (Optional). Use the following sql commands

```sql
CREATE USER myapp_user WITH ENCRYPTED PASSWORD 'myapp_password';
GRANT ALL PRIVILEGES ON DATABASE rest-api TO myapp_user;
```
**Replace myapp_user and myapp_password with the user and password you are using in postgresql**

### **2. Environment Configuration**
To set up the environment variables for the project:

##### i. Copy the Example Environment File

Run the following command to copy `.env.example` to `.env`:

```sh
cp .env.example .env
```
##### ii. Edit the `.env` File

Open the newly created `.env` file and update the values to match your project configuration.

```env
POSTGRES_DB=your_database
POSTGRES_USER=your_username
POSTGRES_PASSWORD=your_secure_password
SPRING_DATASOURCE_URL=jdbc:postgresql://db:5432/your_database
SPRING_DATASOURCE_USERNAME=your_username
SPRING_DATASOURCE_PASSWORD=your_secure_password

```

> **Note**: Replace the placeholder values (`your_database`, `your_username`, `your_secure_password`) with your actual database configuration.

Once configured, your application will be able to connect to the database using the specified environment variables.

---

## 🛠️ Running the Project Locally
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

## ☁️ Deploying on AWS
This project is also deployed on a free-tier AWS Ubuntu server instance with Nginx and API endpoints are publicly accessible through


```sh
http:/16.16.224.53/students
http:/16.16.224.53/subjects
```

---

# Backup Schemes Overview

## 1. Full Backup
**How it works**: Copies **all data** every time.  
✅ **Pros**: Fast restore, simple recovery.  
❌ **Cons**: High storage, slow backups.

## 2. Incremental Backup
**How it works**: Backs up **only changes since last backup** (full or incremental).  
✅ **Pros**: Minimal storage, fast backups.  
❌ **Cons**: Slow restore (depends on backup chain), fragile.

## 3. Differential Backup
**How it works**: Backs up **all changes since last full backup**.  
✅ **Pros**: Faster restore than incremental, moderate storage.  
❌ **Cons**: Slower backups over time.

### Quick Comparison
| Type          | Storage | Backup Speed | Restore Speed | Risk  |  
|---------------|---------|--------------|---------------|-------|  
| **Full**      | High    | Slow         | Fast          | Low   |  
| **Incremental**| Low    | Fast         | Slow          | High  |  
| **Differential**| Medium | Moderate    | Moderate      | Medium|  

**Best Use Cases**:
- **Full**: Critical systems (e.g., databases).
- **Incremental**: Frequent backups (e.g., daily files).
- **Differential**: Balanced approach (e.g., weekly full + daily differential).

**Tip**: Hybrid strategies (e.g., weekly full + daily incremental) optimize efficiency.  

## Server Management Scripts

## 📜 Scripts

| Script            | Purpose                          | Frequency       |
|-------------------|----------------------------------|-----------------|
| `health_check.sh` | Monitor CPU/Memory/Disk + API health | Every 6 hours  |
| `backup_api.sh`   | Backup JAR + PostgreSQL DB       | Daily at 2 AM   |
| `update_server.sh`| Update OS + App + Restart Service| Every 3 days at 3 AM |

## 🛠️ Setup

```bash
# 1. Install dependencies (if not installed in the created server instance)
sudo apt install -y curl postgresql-client git maven

# 2. Make scripts executable 
chmod +x *.sh

# 3. Running the scripts (in the created server instance)
# Health Check (no sudo needed)
./health_check.sh

# Backup (requires sudo for DB access)
sudo ./backup_api.sh

# System Update (requires sudo)
sudo ./update_server.sh

# 4. Schedule (crontab -e)
0 */6 * * * /home/ubuntu/health_check.sh >> /var/log/server_health.log 2>&1
0 2 * * * /home/ubuntu/backup_api.sh >> /var/log/backup.log 2>&1
0 3 */3 * * /home/ubuntu/update_server.sh >> /var/log/update.log 2>&1
```

---
# Containerization

### Docker Setup
##### 1.Install Docker and Docker Compose
  - Local: Follow [Docker installation guide](https://docs.docker.com/get-docker/).


  - AWS EC2 Ubuntu Server instance:
      ```bash
      sudo apt update && sudo apt install -y docker.io
      sudo systemctl start docker && sudo systemctl enable docker
      sudo usermod -aG docker ubuntu
      sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      ```

##### 2.Build Docker Image
```bash
docker build -t rest-api:latest .
```
   
##### 3. Running the Spring Boot API with Docker Compose

```bash
docker-compose up --build
```

##### 4.Verify if containers are running

```bash
docker ps
```

##### 5.Test Endpoints
```bash
curl http://localhost:8080/students
curl http://localhost:8080/subjects
```

### Manage Containers with Docker Compose

###### 🔍 View Logs

Spring Boot API Logs
```bash
docker-compose logs api
```
Shows logs for the `rest-api-api-1` container (Spring Boot application).

PostgreSQL Database Logs
```bash
docker-compose logs db
```
Shows logs for the `rest-api-db-1` container (PostgreSQL database).
    
    
###### 🛑 Stop Containers
```bash
docker-compose stop
```

###### 🗑️ Remove Containers (Preserves `db-data` Volume)
```bash
docker-compose down
```

###### 🔄 Restart Containers
```bash
docker-compose up -d
```
### Troubleshooting Tips for Port Conflicts (Ports 8080 and 5432)

Port conflicts commonly occur when a required port (e.g., for Spring Boot or PostgreSQL) is already in use by another process. This guide helps troubleshoot and resolve conflicts on ports 8080 and 5432.

#### Common Errors

- `Error starting userland proxy: listen tcp4 0.0.0.0:8080: bind: address already in use`
- `bind: address already in use` for port 5432


#### Causes

- Port `8080` is typically used by Spring Boot.
- Port `5432` is the default for PostgreSQL.
- A conflict arises when another service is already using these ports.


#### 🛠️ Step-by-Step Solution

##### 1. Identify the Conflicting Process

Use either of the following commands:

For Port 8080:
```bash
sudo netstat -tulnp | grep 8080
# or
sudo lsof -i :8080
```

For Port 5432:
```bash
sudo netstat -tulnp | grep 5432
# or
sudo lsof -i :5432
```

These commands return the process ID (PID) of the program using the port.

##### 2. Stop the Conflicting Process

Once you have the PID from above:

```bash
sudo kill -9 <PID>
```

Replace `<PID>` with the actual process ID.

##### 3. Special Case: PostgreSQL Installed Locally

If PostgreSQL is running as a system service and you want to disable it (e.g., to let Docker use port 5432):

```bash
sudo systemctl stop postgresql
sudo systemctl disable postgresql
```

##### 4. Retry Docker

Once the port is free:

```bash
docker-compose up --build
```

#####  Alternative Solution: Change the Ports

If stopping the conflicting service isn’t possible:

1. Edit `docker-compose.yml`
2. Modify the port mappings:

```yaml
services:
  app:
    ports:
      - "8081:8080"  # Host:Container
  db:
    ports:
      - "5433:5432"
```

3. Update your app configuration and tests to use the new ports (`8081` and `5433`).


##### ✅ Tips

- Use unique ports when running multiple services locally.
- Add port checks to startup scripts.
- Consider using `.env` files for configurable port management


### Docker Hub
Docker hub repository containing the docker image used in this application : https://hub.docker.com/r/mwemanoor/rest-api-api

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

---
