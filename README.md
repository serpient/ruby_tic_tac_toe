# Run tests
`rspec`
`guard`

# Folder Directory
`bin` -> Executable Files
`lib` -> Source files
`spec` -> Test Files

# Setting up the local development 
1. Install PostgreSQL if you dont have it. For mac users, try `brew install postgresql`
2. Start your postgres instance -- `brew services start postgresql`
3. Set up the postgres user -- `createuser postgres --interactive`
Username = postgres
Password = postgres
4. Enter postgres psql
`psql postgres`

5. Create a new tic_tac_toe database
Option 1 - PSQL 
Enter the following into psql
`CREATE DATABASE postgres`

Option 2 - pgAdmin
![create](https://www.guru99.com/images/1/092818_0513_PostgreSQLC6.png)
![settings](https://www.guru99.com/images/1/092818_0513_PostgreSQLC7.png)

6. Verify that the database was added 
Option 1 - PSQL
In PSQL, type `\l` to see a list of databases

Option 2 - pgAdmin
![result](https://www.guru99.com/images/1/092818_0513_PostgreSQLC8.png)

To connect to the database in psql, use `\c postgres`

8. Install dependencies for the project
`bundle install`

# Running the executable
`ruby bin/tic_tac_toe.rb`

[More CLI executable Reading](https://learn.co/lessons/ruby-cli-applications-readme)
