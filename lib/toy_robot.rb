# Author:       Arthur Cavallari
# GitHub:       http://github.com/arthurcavallari
# LinkedIn:     http://linkedin.com/in/arthurcavallari

require_relative 'helper_methods'
class ToyRobot
    include HelperMethods

    attr_reader :x, :y, :direction, :table

    DIRECTIONS = [:north, :east, :south, :west]

    def initialize(x = nil, y = nil, direction = nil, table)
        raise TypeError, 'Table argument must be of type Table' unless table.class == Table

        @x = x
        @y = y
        @direction = direction
        @table = table
    end

    def update_coordinates(x,y,f)
        # Validate input and append error messages to 'err' variable
        validatePosX = numeric?(x) && x.to_i >= 0 && x.to_i <= @table.width  - 1
        validatePosY = numeric?(y) && y.to_i >= 0 && y.to_i <= @table.height - 1
        validateDiretion = DIRECTIONS.include?(f.to_sym)

        err = ""
        err << "Invalid X, must be a number between 0 - #{@table.width - 1}\n"  unless validatePosX
        err << "Invalid Y, must be a number between 0 - #{@table.height - 1}\n" unless validatePosY
        err << "Invalid F, must be either NORTH, SOUTH, EAST or WEST\n" unless validateDiretion
        
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
        return unless placed?

        if (@direction == :north and @y >= @table.height - 1) or 
           (@direction == :south and @y <= 0) or
           (@direction == :east and @x >= @table.width - 1) or 
           (@direction == :west and @x <= 0)
            puts "** BZZT! This demo robot is expensive, you break it, you buy it!"
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
                puts "** #{@direction} is not a valid direction!"
            end
        end # direction check
    end # move

    def left
        rotate -1
    end

    def right
        rotate 1
    end

    def report
        # Check if the toy robot has been placed on the table yet
        return unless placed?

        puts "** BZZT, I'm currently at #{@x}, #{@y}, #{@direction.to_s.upcase}"
    end

    private

    # Helpers
    def placed?
        # Check if the toy robot has been placed on the table yet
        return true unless @x.nil? or @y.nil? or @direction.nil? or @table.nil?

        puts "** BZZT, I've not been placed on the table yet!"
        false
    end

    # direction is either 1 or -1, signifying clockwise or anti-clockwise respectively.
    def rotate direction
        # Check if the toy robot has been placed on the table yet
        return unless placed?

        # Calculate new direction by finding out the next or previous item on the const array DIRECTIONS
        curr_index = DIRECTIONS.find_index(@direction)
        
        # If the result would be out of bounds, wrap around.. 


        if (direction == 1 and curr_index == 3)
            # if direction = right and the robot's direction is :west
            # we wrap around the array, so new direction = :north

            new_index = 0 
        elsif direction == -1 and curr_index == 0
            # if direction = left and the robot's direction is :north
            # we wrap around the array, so new direction = :west

            new_index = 3 
        else
            # Calculate new index based on index of the robot's position on the DIRECTIONS array 
            # and the direction the robot is turning
            new_index = curr_index + direction
        end

        @direction = DIRECTIONS[new_index]
    end
end