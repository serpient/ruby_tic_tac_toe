# Run tests
`rspec`
`guard`

# Install dependencies
`bundle install`

# Running the executable
`bin/tic_tac_toe.rb`

[More CLI executable Reading](https://learn.co/lessons/ruby-cli-applications-readme)

# Folder Directory
`bin` -> Executable Files
`lib` -> Source files
`spec` -> Test Files

# Setting up Local PostgreSQL Database 
1. Install PostgreSQL if you dont have it. For mac users, try `brew install postgresql`
2. Start your postgres instance -- `brew services start postgresql`
3. Set up user. 
Username = postgres
Password = postgres
4. Create a new tic_tac_toe database