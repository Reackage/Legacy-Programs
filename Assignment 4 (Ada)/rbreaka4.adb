--main.adb
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--reads from a file and computes the Flesch readability index

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

with fileIO; use fileIO;
with readability; use readability;
procedure rbreaka4 is 
ans : boolean:=true;
str : unbounded_string;
size: integer;
index: float:=0.0;
begin
	--Atempts to read the file
	getFileContents(str, size, ans);
	--if the file was read correctly
	if (ans=true) then
		--calculate the index value
		calcRead( str, size, index);
		put("Index value:");
		put(integer(index));
	else
		put_line("Error reading file: File name is incorrect");
	end if;
	
end rbreaka4;