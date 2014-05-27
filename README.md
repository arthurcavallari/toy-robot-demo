Toy Robot Simulator
====
The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.

Requirements
----

toy-robot-simulator was developed using Ruby 1.9.3, but it has also been tested on Ruby 2.0.0.

Usage
----
**bin/toy_robot_simulator** _[options]_

#### Command line arguments

    -w, --width width                Table width
    -h, --height height              Table height
    -f, --file filename              File with instructions - 1 per line
    -g, --graphics                   Enable graphical robot navigation mode
        --help                       Displays Help
                                     
Available commands
----

### PLACE X,Y,F
PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST. 

### MOVE
MOVE will move the toy robot one unit forward in the direction it is currently facing.

### LEFT
LEFT will rotate the robot 90 degrees anti-clockwise without changing the position of the robot.

### RIGHT
RIGHT will rotate the robot 90 degrees  clockwise without changing the position of the robot.

### REPORT
REPORT will announce the X,Y and F of the robot.

### GFX ON/OFF
GFX ON/OFF will respectively enable or disable the graphical simulation mode.

### HELP
HELP will show the help menu - shortcut: h

### QUIT
QUIT will terminate the simulation - shortcut: q

Constraints
----
  1.  The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The simulation discards all commands in the sequence until a valid PLACE command has been executed.
  2. The origin (0,0) is considered to be the SOUTH WEST most corner.
  3. There are no other obstructions on the table surface.
  4. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction.

Tests
----
  * Rspec tests are available under rspec/
  * Test input files are available unde data/