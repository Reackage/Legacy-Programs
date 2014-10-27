--fileIO.ads
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--reads from a file
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
package fileIO is
		function readFile return boolean;
		procedure getFileContents(str: out unbounded_string; size : out integer; success : out boolean);
end fileIO;