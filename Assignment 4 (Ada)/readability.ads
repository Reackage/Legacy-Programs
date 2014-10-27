--readability.adb
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--Computes the Flesch readability index

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
package readability is	
	procedure calcRead( inStr: in unbounded_string; inSize: in integer; index: out float);
end readability;