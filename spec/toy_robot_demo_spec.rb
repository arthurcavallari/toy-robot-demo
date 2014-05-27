require 'spec_helper'

describe ToyRobotDemo do
    before :each do
        $stdout = StringIO.new
        # $stdin = StringIO.new
    end

    after :each do
        $stdout = STDOUT
        # $stdin = STDIN
    end
    
    describe "#new" do
        it "returns a new ToyRobotDemo object" do
            @demo = ToyRobotDemo.new 5,5
            @demo.should be_an_instance_of ToyRobotDemo
        end

        it "creates a ToyRobot robot and a Table object" do
            @demo = ToyRobotDemo.new 5,5

            @demo.robot.should be_an_instance_of ToyRobot
            @demo.table.should be_an_instance_of Table
        end

        it "prompts the user for a width and height if none or invalid parameters were given" do
            InputFaker.with_fake_input(["5,5"]) do
                @demo = ToyRobotDemo.new
                @demo.table.width.should eq 5
                @demo.table.height.should eq 5
            end
        end

        it "continuously prompts the user for a width and height until a valid width and height is given" do
            InputFaker.with_fake_input(["sdfsdf", "42324,23,42,34,234", "-1,-1", "8,8"]) do
                @demo = ToyRobotDemo.new
                @demo.table.width.should eq 8
                @demo.table.height.should eq 8
            end
        end

        it "accepts the default width/height if the user sends an empty width/height" do
            InputFaker.with_fake_input([""]) do
                @demo = ToyRobotDemo.new
                @demo.table.width.should eq 5
                @demo.table.height.should eq 5
            end
        end

        it "loads commands from a file if given as a parameter" do
            lines = File.readlines('data/t1_data.txt').count
            @demo = ToyRobotDemo.new 5,5,"data/t1_data.txt"

            expect($stdout.string).to match(/Loaded #{lines} commands from file '.*'\./)
        end

        it "alerts the user if the command file given cannot be read" do
            @demo = ToyRobotDemo.new 5,5,"data/DOES NOT EXIST.txt"

            expect($stdout.string).to match(/ERROR: '.*' is not a valid file\./)
        end
    end

    describe "#start" do
        it "continuously prompts the user for commands until the command 'quit' is given" do
            InputFaker.with_fake_input(["PLACE 0,0,NORTH", "MOVE", "MOVE", "REPORT", "QUIT"]) do
                @demo = ToyRobotDemo.new 5,5
                @demo.start
            end
        end

        it "sends valid commands to the robot to be executed" do
            InputFaker.with_fake_input(["PLACE 0,0,NORTH", "MOVE", "MOVE", "REPORT", "QUIT"]) do
                @demo = ToyRobotDemo.new 5,5
                @demo.start
            end
        end

        it "ignores invalid commands" do
            InputFaker.with_fake_input(["HODOR", "HOOOODOR", "QUIT"]) do
                @demo = ToyRobotDemo.new 5,5
                @demo.start
            end
        end
    end
end