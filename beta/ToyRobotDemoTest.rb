# Author:         Arthur Cavallari
# GitHub:         http://github.com/arthurcavallari
# LinkedIn:     http://linkedin.com/in/arthurcavallari

# Usage: Just run the script through ruby and follow the prompts 

require './ToyRobotDemo.rb'

# Input Faker Source: https://gist.github.com/jasonm/194554
class InputFaker
    def initialize(strings)
        @strings = strings
    end
 
    def gets
        next_string = @strings.shift
        # Uncomment the following line if you'd like to see the faked $stdin#gets
        puts "#{next_string}"
        next_string
    end
 
    def self.with_fake_input(strings)
        $stdin = new(strings)
        yield
    ensure
        $stdin = STDIN
    end
end

class ToyRobotDemoTest
    T1_DATA = ["PLACE 0,0,NORTH", "MOVE", "MOVE", "REPORT", "QUIT"]
    T2_DATA = ["REPORT", "PLACE 0,0,SOUTH", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT", "QUIT"]
    T3_DATA = ["PLACE 0,0,NORTH", "LEFT", "REPORT", "QUIT"]
    T4_DATA = ["PLACE 1,2,EAST", "MOVE", "MOVE", "LEFT", "MOVE", "REPORT", "QUIT"]
    T5_DATA = ["PLACE 4,4,NORTH", "MOVE", "REPORT", "PLACE 1,1,NORTH", "REPORT", "QUIT"]
    T6_DATA = ["", "", "", "HELP", "Hodor!!@$$!!!!", "QUIT"]

    TEST_DATA = [T1_DATA, T2_DATA, T3_DATA, T4_DATA, T5_DATA, T6_DATA]
    
    def start
        puts "RUN 'ruby ToyRobotDemo.rb' for a standalone version ***********\n"

        TEST_DATA.each_with_index { |data, index| 
            puts "\nPress enter to continue tests.."; gets

            InputFaker.with_fake_input(data) do
                puts "*********** STARTING TEST #{index+1} ***********\n\n"

                demo = ToyRobotDemo.new
                demo.start

                puts "\n*********** TEST #{index+1} FINISHED ***********"
            end

            
        }
        puts "\n*********** ALL TESTS FINISHED ***********"
     end
end

tester = ToyRobotDemoTest.new
tester.start