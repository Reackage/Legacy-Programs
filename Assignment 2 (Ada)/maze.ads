--maze.ads
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--description: uses a depth-first search to search through a maze. implements a stack.
--max size of maze:99x99
package maze is
		function wallCheck(x: integer; y: integer) return boolean;
		function findExit return integer;
		function readFile return boolean;
		function main return boolean;
end maze;