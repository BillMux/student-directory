@students = []
def interactive_menu
    @students = []
    loop do
        print_menu
    # 2. read the input and save it into a variable
        process(gets.chomp)
        # 3. do what the user has asked

    end
end

def process(selection)
    case selection
        when '1'
            input_students
        when '2'
            show_students
        when '9'
            exit # this will cause the program to terminate
        else
            puts "I don't know what you meant, try again"
    end
end

def input_students
    puts "Please enter the names of the students, followed by their cohort"
    puts "To finish, just hit return twice"
    @students = []
    name = gets.chomp
    while !name.empty? do
        puts "Now enter their cohort"
        cohort = gets.chomp
        @students << {name: name, cohort: cohort.to_sym}
        puts "Now we have #{@students.count} students"
        puts "Enter another student?"
        name = gets.chomp
    end
end

def print_header
    line_width = 60
    puts("The students of Villains Academy".center(line_width))
    puts(                "----------------".center(line_width))
end

def print(students)
    line_width = 30
    students.each_with_index do |student, number|
        puts "#{number+1}. #{student[:name]}".ljust(line_width) + "#{student[:cohort]} cohort".rjust(line_width)
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

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
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
    puts "#{cohort} cohort: ".center(60)
    students.each.with_index(1) do |name, index|
      puts  "#{index}. #{name}".center(60)
    end
  end
  puts
end

interactive_menu