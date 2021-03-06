require "csv"
@students = []

def interactive_menu
    @students = []
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

def print_menu
    puts "1. Input students"
    puts "2. Display students"
    puts "3. Save list to students.csv"
    puts "4. Load list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
    load_students
    case selection
        when '1'
            input_students
        when '2'
            show_students
        when '3'
            save_students
        when '4'
            load_students
        when '9'
            puts "Goodbye!"
            exit
        else
            puts "I don't know what you meant, try again"
    end
end

def input_students
    puts "Please enter the names of the students, followed by their cohort"
    puts "To finish, just hit return twice"
    @students = []
    name = STDIN.gets.chomp
    while !name.empty? do
        puts "Now enter their cohort"
        cohort = STDIN.gets.chomp
        push_to_students(name, cohort)
        puts "Now we have #{@students.count} students"
        puts "Enter another student? Press return to go back to menu"
        name = STDIN.gets.chomp
    end
end

def push_to_students(name, cohort)
    @students << {name: name, cohort: cohort.to_sym}
end

def print_header
    line_width = 60
    puts("The students of Villains Academy".center(line_width))
    puts(                "----------------".center(line_width))
end

def print(students)
    line_width = 30
    accumulator = 0
    students.map.with_index do |student, index|
        until accumulator do
        puts "#{index+1}. #{student[:name]}".ljust(line_width) + "#{student[:cohort]} cohort".rjust(line_width)
        accumulator += 1
        end
    end
end

def print_footer(students)
    if students.count == 1
        puts "Overall we have 1 great student"
    elsif students.count == 0
        puts "We currently have no students "
    else
        puts "Overall we have #{students.count} great students"
    end
    puts
end


def show_students
    print_header
    print(@students)
    group_by_cohort
    print_footer(@students)    
end

def group_by_cohort
  group_by_cohort = {}

  @students.each do |student|
    cohort = student[:cohort]
    name  = student[:name]

    if group_by_cohort[cohort] == nil
      group_by_cohort[cohort] = [name]
    else
      group_by_cohort[cohort].push(name)
    end
  end

  group_by_cohort.each do |cohort, students|
    puts
    puts "#{cohort} cohort:".center(60)
    students.each.with_index(1) do |name, index|
      puts  "#{index}. #{name}".center(60)
    end
  end
  puts
end

def save_students
    file = CSV.open("students.csv" , "wb") do |csv|
        @students.each do |student|
            csv << [student[:name], student[:cohort]]
        end
    end
    puts "Saved!"
end

def load_students(filename = "students.csv")
    CSV.foreach("students.csv") do |row|
        file = File.open("students.csv", "r")
        file.readlines.each do |line|
            name, cohort = line.chomp.split(',')
            push_to_students(name, cohort)
        end
    end
    puts "Loaded!"
end

def try_load_students
    filename = ARGV.first
    return if filename.nil?
    if File.exists?(filename)
        load_students(filename)
        puts "Loaded #{students.count} from #{filename}"
    else
        puts "Sorry, #{filename} doesn't exist"
        exit
    end
end

try_load_students
interactive_menu