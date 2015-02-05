// www.openprocessing.org/user/46418
// Ross Lagoy
// A1, BCB 502
// 02/05/15

PFont f; // For font
float[] aliveVals; // Initiate live cell array for the time plot
float[] deadVals; // Initiate dead cell array for the time plot
float[] infectedVals; // Initiate infected cell array for the time plot

// Size of cells
int cellSize = 10;
int cellWidth = 600;
int cellHeight = 300;
int rate = 30;

// How likely for a cell to be alive at start (in percentage)
float startProbability = 50;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Colors for active/inactive cells
color alive = color(99, 184, 255);
color dead = color(230);
color infection = color(255, 165, 0);

// Array of cells
int[][] cells; 
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 

// Pause
boolean pause = false;

void setup() {
  size (600, 800); // Size of canvas
  f = createFont("Arial", 14, true); // Arial, 16 point, anti-aliasing on 

  // Instantiate cell vs. time array for 'real-time cell viability' plot
  aliveVals = new float[300];
  for (int i = 0; i < aliveVals.length; i++) {
    aliveVals[i] = 1;
  }
  deadVals = new float[300];
  for (int i = 0; i < deadVals.length; i++) {
    deadVals[i] = 1;
  }
  infectedVals = new float[300];
  for (int i = 0; i < infectedVals.length; i++) {
    infectedVals[i] = 1;
  }

  // Instantiate arrays for cells to migrate 
  cells = new int[cellWidth/cellSize][cellHeight/cellSize];
  cellsBuffer = new int[cellWidth/cellSize][cellHeight/cellSize];

  // This will draw the background grid
  stroke(255);
  noSmooth();

  // Initialization of cells in the grid
  for (int x=0; x<cellWidth/cellSize; x++) {
    for (int y=0; y<cellHeight/cellSize; y++) {
      float state = random (100);
      if (state > startProbability) { 
        state = 0;
      } else {
        state = 1;
      } 
      cells[x][y] = int(state); // Save state of each cell
    }
  }
}

void draw() {
  background(255); // Set background to white
  frameRate(rate); // Change the frame rate based on user input
  noStroke();

  // Draw slider backgrounds
  fill(100);
  rect(320, 330, 260, 30);
  rect(320, 430, 260, 30);
  rect(320, 530, 260, 30);

  // Begin number of cell type count
  int aliveCount = 0;
  int deadCount = 0;
  int infectedCount = 0;

  // Plot cell viability bar graphs
  for (int x=0; x<cellHeight/cellSize; x++) {
    for (int y=0; y<cellHeight/cellSize; y++) {
      if (cells[x][y] == 1) {
        fill(alive);
        float numberAlive = aliveCount++;
        rect(320, 330, numberAlive/120 * 35, 30);
        aliveVals[aliveVals.length-1] = numberAlive/5;
      }
      if (cells[x][y] == 0) {
        fill(dead);
        float numberDead = deadCount++;
        rect(320, 430, numberDead/120 * 35, 30);
        deadVals[deadVals.length-1] = numberDead/5;
      }
      if (cells[x][y] == 2) {
        fill(infection);
        float numberInfected = infectedCount++;
        rect(320, 530, numberInfected/120 * 35, 30);
        infectedVals[infectedVals.length-1] = numberInfected/5;
      }
    }
  }

  // Plot cell viability line graphs
  for (int i = 0; i < deadVals.length-1; i++) {
    stroke(dead);
    strokeWeight(3);
    line(i, 550-deadVals[i], i+1, 550-deadVals[i+1]);
  }
  for (int i = 0; i < aliveVals.length-1; i++) {
    stroke(alive);
    strokeWeight(3);
    line(i, 550-aliveVals[i], i+1, 550-aliveVals[i+1]);
  }
  for (int i = 0; i < infectedVals.length-1; i++) {
    stroke(infection);
    strokeWeight(3);
    line(i, 550-infectedVals[i], i+1, 550-infectedVals[i+1]);
  }

  // Slide everything down in the array for the line graphs
  for (int i = 0; i < deadVals.length-1; i++) {
    deadVals[i] = deadVals[i+1];
  }
  for (int i = 0; i < aliveVals.length-1; i++) {
    aliveVals[i] = aliveVals[i+1];
  }
  for (int i = 0; i < infectedVals.length-1; i++) {
    infectedVals[i] = infectedVals[i+1];
  }

  // Draw the line graph grid
  strokeWeight(1);
  stroke(0);
  line(0, 550, 300, 550);
  line(0, 370, 300, 370);
  line(0, 460, 300, 460);

  // Draw canvas labels
  smooth();
  textFont(f, 14);
  fill(0);
  text("Real-time cell viability", 10, 320);
  text("100%", 10, 360);
  text("50%", 10, 450);
  text("0%", 10, 540);

  text("Percentage of live cells", 320, 320);
  text("Percentage of dead cells", 320, 420);
  text("Percentage of infected cells", 320, 520);

  text("The Game of Life 'with and infection' Rules:", 10, 590);
  text("1. Alive cells will remain live if it only has >two or <three healthy cell neighbors.", 50, 620);
  text("2. You can pause 'space', click, and drag, to create an infection.", 50, 650);
  text("3. Infectious cells behave the same as live cells, except when in contact with", 50, 680);
  text("live cells, live cells become infected.", 50, 695);
  text("4. You can pause 'space', press 'r' to restart, and 'c' to clear.", 50, 725);
  text("5. Press 'a' or 'd' to decrease and increase your framerate, respecitvely.", 50, 755);
  text("6. Investigate! Try to figure out how to cure infected cells; good luck!", 50, 785);

  noSmooth();
  strokeWeight(0);
  stroke(255);

  //Draw grid for the cells
  for (int x=0; x<cellWidth/cellSize; x++) {
    for (int y=0; y<cellHeight/cellSize; y++) {
      if (cells[x][y]==1) {
        fill(alive); // If alive
      } else if (cells[x][y]==2) {
        fill(infection); //If infected
      } else {
        fill(dead); // If dead
      }
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }

  // Iterate if timer ticks
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      iteration();
      lastRecordedTime = millis();
    }
  }

  // Create  new cells manually on pause
  if (mousePressed) {

    // Map and avoid out of bound errors
    int xCellOver = int(map(mouseX, 0, cellWidth, 0, cellWidth/cellSize));
    xCellOver = constrain(xCellOver, 0, cellWidth/cellSize-1);
    int yCellOver = int(map(mouseY, 0, cellHeight, 0, cellHeight/cellSize));
    yCellOver = constrain(yCellOver, 0, cellHeight/cellSize-1);

    // Check against cells in buffer
    if (cellsBuffer[xCellOver][yCellOver]==0) { // Cell is alive
      cells[xCellOver][yCellOver]=2; // Infect
      fill(infection); // Fill with infection color
    } else { // Cell is dead
      cells[xCellOver][yCellOver]=1; // Make dead
      fill(dead); // Fill with dead color
    }
  } else if (!mousePressed ) { // And then save to buffer once mouse goes up
    // Save cells to buffer (so we opeate with one array keeping the other intact)
    for (int x=0; x<cellWidth/cellSize; x++) {
      for (int y=0; y<cellHeight/cellSize; y++) {
        cellsBuffer[x][y] = cells[x][y];
      }
    }
  }
}

void iteration() { // When the clock ticks

  noStroke();
  // Save cells to buffer (so we opeate with one array keeping the other intact)
  for (int x=0; x<cellHeight/cellSize; x++) {
    for (int y=0; y<cellHeight/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];
      if (cells[x][y] == 1) {
        fill(alive);
      }
      if (cells[x][y] == 0) {
        fill(dead);
      }
      if (cells[x][y] == 2) {
        fill(infection);
      }
    }
  }

  // Visit each cell
  for (int x=0; x<cellWidth/cellSize; x++) {
    for (int y=0; y<cellHeight/cellSize; y++) {
      
      // And visit all the neighbors of each cell
      int healthyNeighbours = 0; // Start to count the healthy neighbors
      int infectedNeighbours = 0; // Start to count the infected neighbors
      int deadNeighbours = 0; // Start to count the dead neighbors
      for (int xx=x-1; xx<=x+1; xx++) {
        for (int yy=y-1; yy<=y+1; yy++) {  
          if (((xx>=0)&&(xx<cellWidth/cellSize))&&((yy>=0)&&(yy<cellHeight/cellSize))) { // Make sure you are not out of bounds
            if (!((xx==x)&&(yy==y))) { // Make sure to to check against self
              if (cellsBuffer[xx][yy]==1) {
                healthyNeighbours ++; // Check healthy alive neighbors and count them
              }
              if (cellsBuffer[xx][yy]==2) {
                infectedNeighbours ++; // Check infected alive neighbors and count them
              }
              if (cellsBuffer[xx][yy]==0) {
                deadNeighbours ++; // Check dead neighbors and count them
              }
            } // End of if
          } // End of if
        } // End of yy loop
      } //End of xx loop

      // Apply rules
      if (cellsBuffer[x][y]==1) { // The cell is alive, kill it if necessary
        if (healthyNeighbours < 2 || healthyNeighbours > 3) {
          cells[x][y] = 0; // Die unless it has 2 or 3 neighbors
        }
        if (infectedNeighbours >= 1) { // A neighbor is infected, take over healthy population
          cells[x][y] = 2;
        }
      } else { // The cell is dead, make it live if necessary      
        if (healthyNeighbours == 3) {
          cells[x][y] = 1; // Only if it has 3 neighbours
        }
      }
      if (cellsBuffer[x][y]==2) {
        if (infectedNeighbours < 2 || infectedNeighbours > 3) {
          cells[x][y] = 0; // Die unless it has 2 or 3 neighbors
        }
      } else { // The cell is dead, make it infected if necessary      
        if (infectedNeighbours == 3) {
          cells[x][y] = 2; // Only if it has 3 neighbors
        }
      }
    } // End of y loop
  } // End of x loop
} // End of function

// Apply user interaction by key press commands
void keyPressed() {
  if (key=='r' || key == 'R') {
    // Restart reinitialization of cells
    for (int x=0; x<cellWidth/cellSize; x++) {
      for (int y=0; y<cellHeight/cellSize; y++) {
        float state = random (100);
        if (state > startProbability) {
          state = 0;
        } else {
          state = 1;
        }
        cells[x][y] = int(state); // Save state of each cell
      }
    }
  }
  if (key==' ') { // On/off of pause
    pause = !pause;
  }
  if (key=='d') { // Increase framerate
    rate++;
    println(rate);
  }
  if (key=='a') { // Decrease framerate
    rate--;
    println(rate);
  }
  if (key=='c' || key == 'C') { // Clear all
    for (int x=0; x<cellWidth/cellSize; x++) {
      for (int y=0; y<cellHeight/cellSize; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
} // END

