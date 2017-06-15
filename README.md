# Battleship

Player who attacks can choose to play either against another human player or against computer. If human player is chosen as opponent, s/he places a defined number of ships of various lengths on a grid made from 10 x 10 cells. If computer is chosen as opponent, it places the ships randomly on the grid. The ships are automatically placed in any horizontal (left to right) or vertical (top to bottom) position depending on the starting position given by the player or by the computer. Ships must stay inside the grid or the position given as input is invalid. The aim of the second player is to sink all of the ships.

Once the ships are placed, the other player selects the cells on the grid to attack. If the attacked cell is empty, the cell is marked as M (Missed). If the attacked cell has a ship placed on it, the hit is successful (H). If all the cells of a ship are hit, the ship is sunk (S). Once all the ships are sunk, the game is over and the player who attacked is the winner!

## Types and amounts of ships

* Submarine: size 1 cell, x 2.
* Destroyer: size 2 cells, x 2.
* Cruiser: size 3 cells, x 1.
* Aircraft-carrier: size 4, x 1.

### How to run the tests from terminal:

From main directory: `rspec spec` to run all tests inside `spec` directory

From `spec` directory: `rspec <file_name_spec.rb>`

### How to include color when running the tests:

To add color from the command line: `rspec spec --color`

### How to run the game from terminal

From `lib` directory: `ruby execute.rb`
