--stack.ads
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--description: uses a depth-first search to search through a maze. implements a stack.
package stack is
       procedure push(x : in integer; y : in integer);
       procedure pop( x : out integer; y : out integer );
       function stack_is_empty return Boolean;
       procedure reset_stack;
       function stack_size return integer;
	   function print_stack return Boolean;
end stack;