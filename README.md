# Run tests
`guard`

# Install dependencies
`bundle install`

# Setting up executable
[Cli Application Reading](https://learn.co/lessons/ruby-cli-applications-readme)

1. Place any starting executable files in /bin folder
2. Place `#!/usr/bin/env ruby` at the top of the files
3. Run your file in command line, example `ruby bin/game_start.rb`

But in order for your shell to execute a file via a command like `./bin/<file name>`, you have to grant it execute permissions. We do this using the chmod command. You can grant a file execute permissions with:
`chmod +x <file_name>`

So to grant a file bin/tictactoe permissions to execute, you would run: chmod +x bin/tictactoe. Depending on your shell environment and user, you might need to run chmod with sudo (sudo chmod +x bin/tictactoe).

# Folder Directory
`bin` -> Executable Files
`lib` -> Source files
`spec` -> Test Files
