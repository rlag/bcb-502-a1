Visit: https://www.openprocessing.org/sketch/802530#

Ross Lagoy
A1, BCB 502
02.05.15
github.com/rlag
openprocessing.org/user/46418

If you are using outside code for the core of your project: 
Identify the source(s) of the code.
I referenced https://processing.org/examples/gameoflife.html for the basic idea of the Game of Life.

Tell me how you modified it to make it your own work.  
By referencing the above code, I was able to further understand the rules behind the Game of Life simulation. I took the code a few steps further, by integrating an infectious biological model, which can be introduced when the simulation is paused (ideal) or in real-time (working, but buggy), and two types of data visualization. The first is a real time plot of the number of cells live, dead, and infected over time, which is interesting to observe at time points where an infection is introduced as different patterns and numbers. The second is a real time horizontal bar plot to visually quantify the status of cells present in the array. For each plot, the cell types are color coded by their representation in the array for easier interpretation and visual appeal. There are also a number of user controls, described below in the rules.

Include descriptions of rules that you applied.  
I applied the following four rules that are the basis of the game of life, as well as a few other commands:

(1)	Any live cell with fewer than two live neighbors dies
(2)	Any live cell with two or three live neighbors lives
(3)	Any live cell with more than three live neighbors dies
(4)	Any dead cell with exactly three live neighbors becomes a live cell
(5)	If any neighbor is infected, it will take over the contacted population of live cells
(6)	The infected cells have the same properties and rules as live cells (1-4)
(7)	There is a following list of commands:
a.	SPACE: pause
b.	MOUSE CLICK: Add an infection ‘or’ during real time
c.	‘A’: decrease frame rate by 1
d.	‘D’: increase frame rate by 1
e.	‘R’: restart
f.	‘C’: clear
(8)	Cure the disease: for the user to investigate! 

Indicate how you generate the first generation, e.g. randomly, via some explicit patterns, or read in from a file.  
The first generation of cells is set as alive or dead by a 50% proportion, with no infection present. Unless the program is restarted, the user can add in an infection from the beginning of the simulation. The user can try adding in just one, two or many infectious cells and observe the trends!

For the free-form (beyond the requirements) component: 
Describe the biological significance of the additions you make.  
The biological significance I attempted to make was a model of an infectious disease based on contact inhibition. This is a simple biological example of a viral infection that kills cells and co-exists in the system based on set rules.

Describe the technical significance of the additions you make.  
I would consider my data visualization techniques technically significant. It was challenging to make a line plot, but I figured it was similar to the idea of the cell array, where it initializes an array of values and then fills the array based on new cell counts. The sliders were a little bit simpler to add. I also designed the canvas to effectively use white space, be appropriate complementary colors, and be a stand-alone interactive application.

(Note: depending on what you come up with, there may be some  overlap, e.g. both biological and technical significance within the same feature. This is fine, just be sure to talk the feature from both perspectives.)  
Provide explicit instructions on running your program.  
If Processing is downloaded, this file may be simply opened and executed by clicking on the ‘run’ button. All rules are explained on-screen and should function as a stand-alone program.

Identified bug and fixes

When the user drags the ‘infection’, half of the array pauses.
•	A potential fix would be to add a mouseDragged() feature that controls this occurrence
