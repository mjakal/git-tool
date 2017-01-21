# Check if user input is numeric
class String
  def is_numeric?
    self.to_i.to_s == self
  end
end

# Main menu block
menu = %q{
╔══════════════════════════════════════╦══════════════════════════════════════╗
║  c - view all commands               ║  x - exit program                    ║
╚══════════════════════════════════════╩══════════════════════════════════════╝
}

# Block contains a list of available git commands
commands = %q{
╔══════════════════════════════════════╦══════════════════════════════════════╗
║  Local commands                      ║  Remote commands                     ║
╠══════════════════════════════════════╬══════════════════════════════════════╣
║  0 - Initialize git repo             ║  10 - Push repo to GitHub            ║
║  1 - Check git status                ║  11 - Compare local and remote repo  ║
║  2 - Commit changes                  ║  12 - Get your public ssh key        ║
║  3 - Revert changes                  ║  13 - Configure remote repo          ║
║  4 - Your branches                   ║  14 - Check your remote settings     ║
║  5 - Move to another branch          ║                                      ║
║  6 - Create new branch               ║                                      ║
║  7 - Merge to master branch          ║                                      ║
║  8 - Delete branch                   ║                                      ║
║  9 - Check your git log              ║                                      ║
╚══════════════════════════════════════╩══════════════════════════════════════╝
}

# This function executes all git commands
def execute_git(cmd)
  case cmd
  when 0
    puts system('git init')
  when 1
    puts system('git status')
  when 2
    puts system('git status')
    print "Are you sure you want to commit this changes (y/n)? "
    message = gets.chomp
    if message == "y"
      puts system('git add -A')
      print "Enter your commit description: "
      message = gets.chomp
      puts system("git commit -m \"#{message}\"")
    end
  when 3
    print "reject latest changes (y/n)? "
    message = gets.chomp
    if message == "y"
      puts system('git checkout -f')
    end
  when 4
    puts system('git branch')
  when 5
    print "enter branch mane: "
    message = gets.chomp
    puts system("git checkout \"#{message}\"")
  when 6
    print "enter branch name: "
    message = gets.chomp
    puts system("git checkout -b \"#{message}\"")
  when 7
    print "Are you sure you want to merge with master branch (y/n)? "
    message = gets.chomp
    if message == "y"
      puts system("git checkout master")
      print "Enter branch name to merge: "
      message = gets.chomp
      puts system("git merge #{message}")
    end
  when 8
    print "Are you sure you want to delete a branch (y/n)? "
    message = gets.chomp
    if message == "y"
      print "Enter the branch name: "
      message = gets.chomp
      puts system("git branch -d #{message}")
    end
  when 9
    puts system('git log --pretty=format:"%h - %s : %ar"')
  when 10
    puts system("git push")
  when 11
    puts system('git diff master origin/master')
  when 12
    puts system('cat ~/.ssh/id_rsa.pub')
  when 13
    print "Enter your repo address: "
    message = gets.chomp
    puts system("git remote add origin #{message}")
    puts system('git push -u origin master')
  when 14
    puts system('git remote -v')
  else
    puts "Oops something went wrong :("
  end
end

# Infinite loop that runs the script 
loop do
  puts menu
  
  print "Enter command: "
  option = gets.chomp
  puts ""

  if option == "c"
    puts commands
  elsif option == 'x'
    break
  elsif option.is_numeric? && (option.to_i >= 0 && option.to_i < 20)
    execute_git(option.to_i)
  else
    puts "command not found"
  end
end