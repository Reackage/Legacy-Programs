--stack.adb
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--description: uses a depth-first search to search through a maze. implements a stack.
with Ada.Text_IO; use Ada.Text_IO;
package body stack is
	   --point(1 is x, 2 is y)
       type point is array(1..2) of integer;
	   --list is going to be a stack of points
       type list is array(1..100000) of point;
	   
       type point_stack is        
       record
              item : list;
              top : natural := 0;
       end record;
       stackPoints : point_stack;
       max_size: integer:=100000;
       --pushes 2 numbers into the stack
       procedure push(x : in integer; y : in integer) is
       begin
              if stackPoints.top = max_size then
                     put_line("stack is full");
              else
                     stackPoints.top := stackPoints.top + 1;
                     stackPoints.item(stackPoints.top)(1) := x;
                     stackPoints.item(stackPoints.top)(2) := y;
              end if;
       end push;
       --pops 2 numbers off the stack
       procedure pop( x : out integer; y : out integer) is
       begin
              if stackPoints.top = 0 then
                     put_line("stack is empty");
              else
                     x := stackPoints.item(stackPoints.top)(1);
                     y := stackPoints.item(stackPoints.top)(2);
                     stackPoints.top := stackPoints.top - 1;
              end if;
       end pop;
       --checks if the stack is empty
       function stack_is_empty return Boolean is
              begin
                     return stackPoints.top = 0;
       end stack_is_empty;
       --resets stack(never used)
       procedure reset_stack is
       begin
              stackPoints.top := 0;
       end reset_stack;
       
	   --returns number of elements in the stack
       function stack_size return integer is
       begin
              return stackPoints.top;
       end stack_size;
	   --prints all elements on the stack from the bottom to the top
	   function print_stack return Boolean is
	   begin
			if stack_is_empty=false then
				for i in 1..stackPoints.top loop
					put_line(integer'image(stackPoints.item(i)(1))& "," &integer'image(stackPoints.item(i)(2)));
				end loop;
				return true;
			end if;
			return false;
		end print_stack;	   
	   
end stack;