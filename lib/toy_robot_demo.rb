# Author:       Arthur Cavallari
# GitHub:       http://github.com/arthurcavallari
# LinkedIn:     http://linkedin.com/in/arthurcavallari

# Usage: 
#           Either you provide the width and height when running the script (e.g. ruby toy_robot_demo.rb -w 5 -h 5)
#           or leave the arguments empty and follow the prompts

require_relative 'table'
require_relative 'toy_robot'
require_relative 'helper_methods'

class ToyRobotDemo
    include HelperMethods

    attr_reader :robot, :table

    def initialize(width = nil, height = nil, file = nil, gfx = nil)
        @gfx = gfx
        width = to_numeric!(width)
        height = to_numeric!(height)

        @commands = []
        if !file.nil? and File.file?(file)
            @commands = File.readlines(file).map { |l| l.chomp } 
            puts "Loaded #{@commands.length} commands from file '#{file}'."
        elsif !file.nil? and !File.file?(file)
            puts "ERROR: '#{file}' is not a valid file."
        end
        
        puts "Welcome to Toy Robot Simulator, where fun begins."

        while(width.nil? or height.nil? or !numeric?(width) or !numeric?(height) or width < 1 or height < 1)
            print "Enter table width,height [default: 5,5] >> "
            dimensions = $stdin.gets.strip

            if dimensions.length == 0
                # Use default values
                width = 5
                height = 5
                break
            else
                # Attempt to parse given dimensions
                args = dimensions.split(',').map { |e| to_numeric!(e.strip) }
                if args.length == 2
                    width = args[0]
                    height = args[1]
                end
            end
        end

        @table = Table.new(width, height)
        @robot = ToyRobot.new(nil, nil, nil, @table)

        puts "It seems for today's demo we're using a table of dimensions #{@table.width}x#{@table.height}."
        puts "Please stay clear of out of bounds values for your robot's safety, as they have feelings too."

    end

    def menu
        puts "\nCommands available:"
        puts "\t- %-14s: %s" % [ "PLACE X,Y,F", "Places robot at position X,Y facing direction F"   ]
        puts "\t- %-14s: %s" % [ "MOVE",        "Moves robot 1 unit in the direction it's facing"   ]
        puts "\t- %-14s: %s" % [ "LEFT",        "Rotates the robot 90 degrees anti-clockwise"       ]
        puts "\t- %-14s: %s" % [ "RIGHT",       "Rotates the robot 90 degrees clockwise"            ]
        puts "\t- %-14s: %s" % [ "REPORT",      "Announces robot's position"                        ]
        puts "\t- %-14s: %s" % [ "GFX ON/OFF",  "Turns graphics on or off"                          ]
        puts "\t- %-14s: %s" % [ "HELP",        "Shows this menu - shortcut: h"                     ]
        puts "\t- %-14s: %s" % [ "QUIT",        "Terminates this toy robot demo - shortcut: q"      ]
    end

    def draw_game
        w = @table.width - 1
        h = @table.height - 1
        x = @robot.x
        y = @robot.y
        f = @robot.direction
        printf("%c", 14)

        print '┌'
        (w*2+3).times { print '─'  } #─
        puts '┐'

        h.downto(0) do |i|
            print "╎"
            0.upto(w) do |j|
                print " "
                if x == j and y == i
                    case f
                        when :north
                            print "▲"
                        when :south
                            print "▼"
                        when :east
                            print "▶"
                        when :west
                            print "◀"
                    end
                else
                    print " "
                end                
            end
            print " ╎"
            puts 
        end
        print '└'
        (w*2+3).times { print '─'  }
        puts '┘'
        printf("%c\n", 15)
    end

    def start
        # Display command list
        menu

        command = nil
        original_command = nil

        while command != 'q' and command != 'quit'
            draw_game if @gfx
            print "Enter command >> "
            if @commands.length > 0
                original_command = @commands.shift
                puts original_command
            else
                original_command = $stdin.gets.strip
            end
            
            command = original_command.downcase
            first_arg = command[/\w*/, 0]
            
            # Match the first word against our valid commands
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
                        
                        @robot.place(x,y,f)
                    else
                        puts "Wrong number of arguments! Format: PLACE X,Y,F where X,Y are numbers and F is the direction the robot is facing."
                    end
                when "report", "move", "left", "right"
                    # Ensure that the full command was just that single word
                    if first_arg == command
                        @robot.send first_arg
                    else
                        puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
                    end
                when "help", "h"
                    menu
                when "gfx"
                    case original_command
                        when "gfx on"
                            @gfx = true
                        when "gfx off"
                            @gfx = false
                        else
                            puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
                    end
                when "quit", "q"
                    # Ensure that the full command was just that single word, 
                    # otherwise commands like 'quit now' or 'quit 123!' would be valid
                    if first_arg == command
                        puts "Terminating toy robot demo!"
                    else
                        puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
                    end
                else
                    puts "Hmm.. '#{original_command}' doesn't look like a valid command!"
            end unless command.empty? # case first_arg
        end # while
    end # def start

end # class

if __FILE__ == $0
    require 'optparse'

    options = {:width => nil, :height => nil, :file => nil, :gfx => nil}

    parser = OptionParser.new do|opts|
        opts.banner = "Usage: ruby toy_robot_demo.rb [options]"
        opts.on('-w', '--width width', 'Table width') do |width|
            options[:width] = width;
        end

        opts.on('-h', '--height height', 'Table height') do |height|
            options[:height] = height;
        end


        opts.on('-f', '--file filename', 'File with instructions - 1 per line') do |file|
            options[:file] = file;
        end

        opts.on('-g', '--graphics', 'Enable graphical robot navigation mode') do |gfx|
            options[:gfx] = gfx;
        end

        opts.on('', '--help', 'Displays Help') do
            puts opts
            exit
        end
    end

    parser.parse!

    demo = ToyRobotDemo.new(options[:width], options[:height], options[:file], options[:gfx])
    demo.start
end
