require 'spec_helper'

describe ToyRobot do
    before :all do
        @table = Table.new 5, 5
    end

    before :each  do        
        @robot = ToyRobot.new(nil, nil, nil, @table)
    end
    
    describe "#new" do
        it "returns a new ToyRobot object" do
            @robot.should be_an_instance_of ToyRobot 
        end

        it "throws a TypeError when the given table parameter is not of type Table" do
           lambda { ToyRobot.new(nil, nil, nil, nil) }.should raise_exception TypeError 
        end
    end

    describe "#update_coordinates" do
    # X
        it "prints an error message if the parameter X is greater than the table width" do
            output = capture_stdout do
                @robot.update_coordinates(5, 0, :north)
            end

            output.should eq "Invalid X, must be a number between 0 - #{@robot.table.width - 1}\n"
        end

        it "prints an error message if the parameter X is negative" do
            output = capture_stdout do
                @robot.update_coordinates(-1, 0, :north)
            end

            output.should eq "Invalid X, must be a number between 0 - #{@robot.table.width - 1}\n"
        end

        it "prints an error message if the parameter X is not numeric" do
            output = capture_stdout do
                @robot.update_coordinates("four", 0, :north)
            end

            output.should eq "Invalid X, must be a number between 0 - #{@robot.table.width - 1}\n"
        end
    # Y
        it "prints an error message if the parameter Y is greater than the table height" do
            output = capture_stdout do
                @robot.update_coordinates(0, 5, :north)
            end

            output.should eq "Invalid Y, must be a number between 0 - #{@robot.table.height - 1}\n"
        end

        it "prints an error message if the parameter Y is negative" do
            output = capture_stdout do
                @robot.update_coordinates(0, -1, :north)
            end

            output.should eq "Invalid Y, must be a number between 0 - #{@robot.table.height - 1}\n"
        end

        it "prints an error message if the parameter Y is not numeric" do
            output = capture_stdout do
                @robot.update_coordinates(0, "four", :north)
            end

            output.should eq "Invalid Y, must be a number between 0 - #{@robot.table.height - 1}\n"
        end
    # F
        it "prints an error message if the parameter F is not part of the list of valid DIRECTIONS #{ToyRobot::DIRECTIONS}" do
            output = capture_stdout do
                @robot.update_coordinates(0, 0, :down)
            end

            output.should eq "Invalid F, must be either NORTH, SOUTH, EAST or WEST\n"
        end

        it "changes the robot's position when given valid coordinates" do
            @robot.update_coordinates(0, 0, :north)
            @robot.x.should eql 0
            @robot.y.should eql 0
            @robot.direction.should eql :north
        end
    end

    describe "#report" do
        it "prints an error message if the robot has not been placed on the table" do
            output = capture_stdout do
                @robot.report
            end

            output.should eq "** BZZT, I've not been placed on the table yet!\n"
        end

        it "prints an message announcing the robot's coordinates" do
            output = capture_stdout do
                @robot.update_coordinates(0, 0, :north)
                @robot.report
            end

            output.should eq "** BZZT, I'm currently at 0, 0, NORTH\n"
        end
    end

    describe "#move" do
        it "prints an error message if the robot has not been placed on the table" do
            output = capture_stdout do
                @robot.move
            end

            output.should eq "** BZZT, I've not been placed on the table yet!\n"
        end

        it "prints an error message when attempting move outside the table dimensions" do
            output = capture_stdout do
                @robot.update_coordinates(4, 4, :north)
                @robot.move
            end

            output.should eq "** BZZT! This demo robot is expensive, you break it, you buy it!\n"
        end

        it "moves the robot 1 unit in the direction it is facing" do
            @robot.update_coordinates(0, 0, :north)
            @robot.move
            @robot.x.should eq 0
            @robot.y.should eq 1
            @robot.direction.should eq :north
        end
    end

    describe "#left" do
        it "prints an error message if the robot has not been placed on the table" do
            output = capture_stdout do
                @robot.left
            end

            output.should eq "** BZZT, I've not been placed on the table yet!\n"
        end

        it "rotates the robot 90 degrees anti-clockwise without changing the position of the robot" do
            @robot.update_coordinates(4, 4, :north)
            @robot.left

            @robot.x.should eq 4
            @robot.y.should eq 4
            @robot.direction.should eq :west

        end
    end

    describe "#right" do
        it "prints an error message if the robot has not been placed on the table" do
            output = capture_stdout do
                @robot.right
            end

            output.should eq "** BZZT, I've not been placed on the table yet!\n"
        end

        it "rotates the robot 90 degrees clockwise without changing the position of the robot" do
            @robot.update_coordinates(4, 4, :north)
            @robot.right
            
            @robot.x.should eq 4
            @robot.y.should eq 4
            @robot.direction.should eq :east
        end
    end
end