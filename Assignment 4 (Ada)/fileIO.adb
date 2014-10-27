--fileIO.adb
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--Reads from a file and stores the contents in one string.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

with readability; use readability;
package body fileIO is
	infp : file_type;
	fileText : unbounded_string;
	textLength : integer := 0;
	line : unbounded_string;
	lineLength: integer;
	fileName :string(1..1000);
		--Reads in a file from a user name
	  function readFile return boolean is
       begin
            put_line("Enter a file name:");
            get_line(fileName,textLength);
            open (infp, in_file, fileName(1..textLength));
			
			--while not at the end of the file, put every line into a single string
			textLength:=0;			
            while end_of_file(infp)=false loop
				get_line(infp, line);
				lineLength :=  length(line);
				fileText:= fileText & line;
				textLength:= textLength+ lineLength;
            end loop;
     
			--put_line(fileText);
			--put(textLength);
			return true;
			--if there is a file error
            exception
                when name_error =>
                    return false;              
       end readFile;
	   --This returns the file contents to an external source from this package.
	   procedure getFileContents(str: out unbounded_string; size : out integer; success : out boolean) is
	   begin
			success:= readFile;
			str:= fileText;
			size:= textLength;	   	   
	   
		end getFileContents;
	
end fileIO;
