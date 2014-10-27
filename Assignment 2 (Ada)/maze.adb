--maze.adb
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--description: uses a depth-first search to search through a maze. implements a stack.
--max size of maze:99x99
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with stack; use stack;
package body maze is
	-- char and stringList are used to store the mapping of the maze.(2d array)
		type char is array(1..100) of character;
		type StringList is array(1..100) of char;
		origional : StringList;
		copy : StringList;
		
		--location of the entrance
		startx: integer:=-1;
		starty: integer:=-1;
	   --location of the exit
		exitx: integer:=-1;
		exity: integer:=-1;
	   -- used for when we are navigating the maze
		currentx: integer;
		currenty: integer;
	   
	   -- flag for checking if exit is found
		flag:boolean:=false;
       
		-- Steps taken to complete the maze
		steps: integer:=0;
		
	   --reading in a file variables
		charpos : integer:= 1;
		strpos : integer:= 1;		
		infp : file_type;
		fileName :string(1..1000);
		size:natural;
		ch : character;
		
		--Wallcheck checks if move is valid(aka not a wall)
		function wallCheck(x: integer; y: integer) return boolean is
		begin
			if x<=0 or y<=0 then
                put("negative value for x or y is not acceptable");
                return false;
            end if;
			-- if there is a wall, return false otherwise return true
            if origional(x)(y)='*' then 
                return false;
            else
                return true;
            end if;
       end wallcheck;
       
	   --Finds the path from enterance to exit, if it exists
       function findExit return integer is
       begin
            push(startx,starty);--Puts the starting place in the stack
			--loops until all options are exausted or exit is found
            while flag=false loop
				--pops current position, finds next move(if any) exists
			    pop(currentx, currenty);
                if(origional(currentx)(currenty)='e') then
                    flag:=true;
							                     
				else
                    --This sets the current location to a wall to prevent constant overlap.
					origional(currentx)(currenty):='*';
                    --looks for next move, going from north, east, west then south.
					--pushes the current location and the next location onto the stack
					if wallcheck(currentx-1, currenty)= true then
						push(currentx, currenty);
						push(currentx-1, currenty);
                     						
					elsif wallcheck(currentx, currenty+1)= true then
						push(currentx, currenty);
						push(currentx, currenty+1);
						
					elsif wallcheck(currentx, currenty-1)= true then
						push(currentx, currenty);
						push(currentx, currenty-1);
                     
					elsif wallcheck(currentx+1, currenty)= true then
						push(currentx, currenty);
						push(currentx+1, currenty);
								
                     
					else
						if(currentx=startx and currenty=starty) then 
                            flag:=true;
						end if;
					end if;
				end if;
            end loop;
            return stack_size;
       end findExit;
       
	   -- reads a file!
       function readFile return boolean is
       begin
            put_line("enter a file name:");
            get_line(fileName,size);
            open (infp, in_file, fileName(1..size));
			--while not at the end of the file
            while end_of_file(infp)=false loop
				--if the end of the line is met(ada is terrible with end lines)
                if  end_of_line(infp) then 
                    charpos:=1;
                    strpos:=strpos+1;
                end if;
					
				--read in character, store
                get(infp,ch);
                origional(strpos)(charpos):=ch;
                copy(strpos)(charpos):=ch;
                charpos:=charpos+1;                   
            end loop;
     
			--finds the start and end locations
            for row in 1..strpos loop
                for col in 1..charpos loop
                    if origional(row)(col)='o' then
                        startx:=row;
                        starty:=col;
                    end if;
                    if origional(row)(col)='e'then
                        exitx:=row;
                        exity:=col;
                    end if;
                    put(origional(row)(col));

                    end loop;
                    new_line;
            end loop;
            -- if either the start or end does not exist:
            if startx=-1 or starty=-1 or exitx=-1 or exity=-1 then
                return false;
            end if;
			close(infp);
            return true;
			--if there is a file error
            exception
                when name_error =>
                    return false;              
       end readFile;
       
       
-- main method, runs all the logic
	function main return boolean is
	begin
		--sets up array for input
		for a in 1..100 loop
			origional(a):= (1..100 =>'*');
            copy(a):=(1..100 =>'*');
		end loop;
       
	   --if the file is good
		if readFile = true then
		--attempts to solve the maze
            steps:=findExit;
			
			--outputs solution
            put_line("Number of steps from entrance to exit is:"&integer'image(steps));      
            put_line("Solution path is:");
            if print_stack=false then
                put_line("No solution");
				return false;
            end if;
			--this is for printing the answer. pops the path off the stack to update a copy of the origional maze
            while stack_is_empty=false loop
                pop(currentx, currenty);                    
                copy(currentx)(currenty):='X';
            end loop;
              
              
            --prints out the maze path
            copy(startx)(starty):='o';
            for row in 1..strpos loop
                for col in 1..charpos-1 loop
                    put(copy(row)(col));
                end loop;
                new_line;
            end loop;
			
       else
            put_line("Error: file did not open correctly or file is in improper formating. Exiting");
            return false;
		end if;  
		return true;
	end main;
end maze;


