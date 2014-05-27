#!/usr/bin/env ruby

# Author:         Arthur Cavallari
# GitHub:         http://github.com/arthurcavallari
# LinkedIn:     http://linkedin.com/in/arthurcavallari

# Usage: Just run the script through ruby and follow the prompts 

class ::String
    # Open ::String class and add a nice little function..
    def numeric?
        true if Integer(self) rescue false
    end
end

class ToyRobotDemo
    DIRECTIONS = [:north, :east, :south, :west]
    INVALID_MOVE_MESSAGE = "** BZZT! This demo robot is expensive, you break it, you buy it!"
    
    def initialize
        @width = 5
        @height = 5
        @x = nil
        @y = nil
        @direction = nil


        puts "Welcome to Toy Robot Simulator, where fun begins."
        puts "It seems for today's demo we're using a table of dimensions #{@width}x#{@height}."
        puts "Please stay clear of out of bounds values for your robot's safety, as they have feelings too."
    end

    def place(x,y,f)
        # Validate input and append error messages to 'err' variable
        err = ""
        err << "Invalid X, must be a number between 0 - 4\n" unless x.numeric? and !(x.to_i < 0 or x.to_i > 4)
        err << "Invalid Y, must be a number between 0 - 4\n" unless y.numeric? and !(y.to_i < 0 or y.to_i > 4)
        err << "Invalid F, must be either NORTH, SOUTH, EAST or WEST\n" unless ['north', 'south', 'east', 'west'].include?(f)
        
        # If nothing was appended to the 'err' variable, we should be good to go!
        if err.empty?
            @x = x.to_i
            @y = y.to_i
            @direction = f.to_sym
        else
            print err
        end
    end

    def move
        # Check if the toy robot has been placed on the table yet

        if place?
            if (@direction == :north and @y == @height-1) or (@direction == :south and @y == 0)
                or (@direction == :east and @x == @width-1) or (@direction == :west and @x == 0)
                puts INVALID_MOVE_MESSAGE
            else
                if @direction == :north
                    @y += 1
                elsif @direction == :south
                    @y -= 1
                elsif @direction == :east
                    @x += 1
                elsif @direction == :west
                    @x -= 1
                else
                    puts "Invalid direction!"
                end
            end
        end
    end

    def left
        rotate -1
    end

    def right
        rotate 1
    end

    def rotate direction
        # Check if the toy robot has been placed on the table yet
        if placed?
            # Calculate new direction by finding out the next or previous item on the const array DIRECTIONS

            curr_index = DIRECTIONS.find_index(@direction)
            
            # If result would be out of bounds, wrap around.. 
            if (direction == 1 and curr_index == 3)
                new_index = 0 
            elsif direction == -1 and curr_index == 0
                new_index = 3
            else
                new_index = curr_index + direction
            end

            @direction = DIRECTIONS[new_index]
        end
    end

    def report
        # Check if the toy robot has been placed on the table yet
        if placed?
            puts "** BZZT, I'm currently at #{@x}, #{@y}, #{@direction.to_s.upcase}"
        end
    end

    def placed?
        if @x.nil? or @y.nil? or @direction.nil?
            puts "** BZZT, I've not been placed on the table yet!"
            false
        else
            true
        end
    end

    def menu
        puts "\nCommands available:"
        puts "\t- %-14s: %s" % [ "PLACE X,Y,F", "Places robot at position X,Y facing direction F"    ]
        puts "\t- %-14s: %s" % [ "MOVE",         "Moves robot 1 unit in the direction it's facing"    ]
        puts "\t- %-14s: %s" % [ "LEFT",         "Rotates the robot 90 degrees anti-clockwise"        ]
        puts "\t- %-14s: %s" % [ "RIGHT",         "Rotates the robot 90 degrees clockwise"            ]
        puts "\t- %-14s: %s" % [ "REPORT",         "Announces robot's position"                        ]
        puts "\t- %-14s: %s" % [ "HELP",         "Shows this menu - shortcut: h"                        ]
        puts "\t- %-14s: %s" % [ "QUIT",         "Terminates this toy robot demo - shortcut: q"        ]
    end

    def start
        # Display command list
        menu

        command = nil

        while command != 'q' and command != 'quit'
            print "Enter command >> "
            original_command = gets.strip
            command = original_command.downcase
            first_arg = command[/\w*/, 0]
            
            case first_arg
                when "place"
                    # Attempt to extract the arguments (x,y,f)
                    parser = command.match(/place\s*(.*)/)

                    # Split arguments by the comma and strip away whitespace
                    args = parser[1].split(',').map { |e| e.strip }
                    if args.length == 3
                        x = args[0]
                        y = args[1]
                        f = args[2]
                        
                        place(x,y,f)
                    else
                        puts "Wrong number of arguments! Format: PLACE X,Y,F where X,Y are numbers and F is the direction the robot is facing."
                    end
                when "report", "move", "left", "right"
                    if first_arg == command
                        send first_arg
                    else
                        puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
                    end
                when "help", "h"
                    menu
                when "quit", "q"
                    if first_arg == command
                        puts "Terminating toy robot demo!"
                    else
                        puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
                    end
                else
                    puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
            end unless command.empty?
        end
    end
end

if __FILE__==$0
    demo = ToyRobotDemo.new
    demo.start
end
