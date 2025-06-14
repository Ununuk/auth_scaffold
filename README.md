# Auth Scaffold

Auth Scaffold is a Rails API application template that integrates authentication using Devise, Devise-JWT, and ActiveAdmin. It's configured for deployment on Heroku and is built with Ruby 3.4.4 and Rails 8.0.2.

## Features

- **User Authentication**: Secure user registration and login with Devise.
- **JWT Integration**: Token-based authentication using Devise-JWT for API endpoints.
- **Admin Interface**: Administrative dashboard powered by ActiveAdmin.
- **Heroku Ready**: Pre-configured for seamless deployment to Heroku.

## Prerequisites

- **Ruby**: Version 3.4.4
- **Rails**: Version 8.0.2
- **Docker**: For containerized development and deployment
- **PostgreSQL**: As the primary database

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Ununuk/auth_scaffold.git
cd auth_scaffold
```

### 2. Setup with Docker

Ensure you have Docker and Docker Compose installed. To start the application in a containerized environment:

```bash
docker-compose up -d
```

This command will build the Docker image and start the application along with the PostgreSQL database in detached mode.

### 3. Install Dependencies

If you're running the application outside of Docker, install the required gems:

```bash
bundle install
```

### 4. Configure the Database

Set up the database by running:

```bash
rails db:create
rails db:migrate
```

This will create and migrate the PostgreSQL database.

### 5. Start the Rails Server

Launch the application server:

```bash
rails s
```

By default, the server runs on `http://localhost:3000`.

### 6. Running Tests

The application uses RSpec for testing. To run the test suite:

```bash
rspec
```

This will execute all the tests and display the results.

## Deployment to Heroku

To deploy the application to Heroku:

1. **Login to Heroku**:

   ```bash
   heroku login
   ```

2. **Create a New Heroku Application**:

   ```bash
   heroku create your-app-name
   ```

3. **Deploy the Code**:

   ```bash
   git push heroku main
   ```

4. **Run Migrations on Heroku**:

   ```bash
   heroku run rails db:migrate
   ```

5. **Set Up Environment Variables**:

   Ensure all necessary environment variables (e.g., secret keys, database URLs) are set on Heroku.

## Contributing

Contributions are welcome! Please submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For more information, visit the [auth_scaffold GitHub repository](https://github.com/Ununuk/auth_scaffold).
