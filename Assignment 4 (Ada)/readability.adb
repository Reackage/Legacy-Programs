--readability.adb
--Author: Ricky Break
--ID: 
--Course: CIS 3190
--Computes the Flesch readability index


with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Strings.bounded; use Ada.Strings.bounded;
package body readability is
	str: unbounded_string;
	size: integer;
	
	wordCount : float := 0.0;
	syllablesCount : float := 0.0;
	sentenceCount : float := 0.0;
	x: integer := 0;
	
	vowelCount:float := 0.0;
	diphCount: float := 0.0;
	
	--This detects if the current char is a end of sentence char
	function endSentence(ch : character) return boolean is
	begin
		if ch='-' or ch= '.' or ch='?' or ch='!' or ch =';' or ch =':' then
			
			return true;
		end if;
		return false;
	end endSentence;
	
		--This detects if the current char is a end of a word char
	function endWords(ch : character) return boolean is
	y: integer:=0;
	begin
		if ch =' ' or ch =',' or ch ='.' or ch ='-' or ch ='?' or ch ='!' or ch =':'or ch =';' then
			return true;
		end if;
		return false;
	end endWords;
	
		--This detects if the current char is vowel char
	function isVowel(ch : character) return boolean is
	y: integer:=0;
	begin
			if ch='a' or ch='e' or ch='i' or ch='o' or ch='u' then
				return true;
			end if;
			
			if ch='A' or ch='E' or ch='I' or ch='O' or ch='U' then
				return true;
			end if;			
		return false;
	end isVowel;
	
	--Calculates the index value
	procedure calcRead( inStr: in unbounded_string; inSize: in integer; index: out float) is
	syl:float:=0.0;
	sentFlag:boolean:=false;
	wordFlag:boolean:=false;
	begin
		str:=inStr;
		size:= inSize;
		x:=1;
	
		--while we are within the string length
		while x/=size+1 loop
			--while there is not a end of sentence char found
			while not(sentFlag) loop
			--while there is not a end of word char found
				while not(wordFlag ) loop
				
					-- if we are at the end of the string exit all the loops.
					if(x=size) then
						wordFlag:=true;
						sentFlag:=true;					
					end if;
					-- if a end of sentence char is found 
					if(endSentence(element(str,x))=true) then
						wordFlag:=true;
						sentFlag:=true;
					-- if a end of word char is found
					elsif (endWords(element(str,x))=true) then
						wordFlag:=true;
					-- if a vowel is found
					elsif (isVowel(element(str,x))) then
						vowelCount:=vowelCount+1.0;
						-- if x!=1 so we dont go out of bounds.. we check if there is 2 vowels in a row
							if(x/=1) then
								if isVowel(element(str, x-1)) then
									diphCount:=diphCount+1.0;									
								end if;
							end if;
						else
							--its a constant or something I dont care about. magic.
							 x:=x;
						end if;
						x:=x+1;
				end loop;
				
				--if the current position is 2 or higher..
				if x-2>=1 then
					-- this checks if it is a hyphenated word
					if(x/=size+1) then
						if element(str,x-1)='-' and not(endWords(element(str,x-2))) and not(endWords(element(str,x))) then
						--this is a hyphenated word.
						wordFlag:=false;
						sentFlag:=false;
						end if;
					end if;
					-- This prevents double word counts(ex. 2 spaces in a row..)
					if wordFlag=true and (endWords(element(str,x-2))/=true) then
						wordCount:= wordCount +1.0;
						syl:= ( vowelCount-diphCount);
						--put(element(str, x-2));
						-- if the word ends with an e removes a syl
						if( element(str,x-2) ='e') then
							syl:= syl-1.0;
						end if;
						-- if the word ends with a y then add a syl
						if( element(str,x-2) ='y') then
							syl:= syl+1.0;
						end if;
						-- no word is 0 syllabols
						if syl<=0.0 then
							syl:=1.0;
							--put("here");
						end if;
						syllablesCount:= syllablesCount+syl;
							syl:=0.0;
							vowelCount:=0.0;
							diphCount:=0.0;
					end if;
				
					wordFlag:=false;
				end if;
				--put(integer(syllablesCount));
				--new_line(1);
			end loop;
			if endSentence(element(str,x-2))/=true then
				sentenceCount:=sentenceCount+1.0;
			end if;
			
			sentflag:=false;
			
			
		end loop;
		put("Word Count : ");
		put (integer(wordCount));
		new_line(1);
		put("sentence Count :");
		put(integer(sentenceCount));
		new_line(1);
		put("Syllables Count :");
		put(integer(syllablesCount));
		new_line(1);
		index:=206.835-(1.015*(wordCount/sentenceCount)+84.6*(syllablesCount/wordCount));

			
		
		
		
	end calcRead;
end readability;