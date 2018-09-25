def interactive_menu
    students = []
    loop do
        # 1. print the menu and ask the user what to do
        puts "1. Input the students"
        puts "2. Show the students"
        puts "9. Exit" # 9 because we'll be adding more items
        # 2. read the input and save it into a variable
        selection = gets.chomp
        # 3. do what the user has asked
        case selection
        when '1'
            students = input_students
        when '2'
            print_header
            print(students)
            print_footer(students)
        when '9'
            exit # this will cause the program to terminate
        else
            puts "I don't know what you meant, try again"
        end
    end
end


def input_students
    calendar = {
        :january   => 1,
        :february  => 2,
        :march     => 3,
        :april     => 4,
        :may       => 5,
        :june      => 6,
        :july      => 7,
        :august    => 8,
        :september => 9,
        :october   => 10,
        :november  => 11,
        :december  => 12
    }
    puts "Please enter the names of the students, followed by their cohort"
    puts "To finish, just hit return twice"
    students = []
    name = gets.chomp
    while !name.empty? do
        puts "Now enter their cohort"
        cohort = gets.chomp
        students << {name: name, cohort: cohort.to_sym}
        calendar.each do |month, num|
            if month == cohort.to_sym
                students.sort_by! {num}
            end
        end
        puts "Now we have #{students.count} students"
        puts "Enter another student?"
        name = gets.chomp
    end
    students
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
end


interactive_menu