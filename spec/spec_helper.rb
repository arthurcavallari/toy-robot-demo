require_relative '../lib/table'
require_relative '../lib/toy_robot'
require_relative '../lib/toy_robot_demo'
require_relative '../lib/helper_methods'
require 'stringio'

def capture_stdout(&blk)
    old = $stdout
    $stdout = fake = StringIO.new
    blk.call
    fake.string
ensure
    $stdout = old
end


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