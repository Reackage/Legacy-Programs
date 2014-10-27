*Easter Calculator!
*Origional Author. D E Knuth.
*Date-Written. January 22, 1962.
*Date-Compiled. January 23, 1962
*-------------------------------
*Updated!
*Update Author: Ricky Break
*ID:
*Date: March 20, 2012
* What this does:
* This calculates the dates of easter from the year 500 to 4999.
* The results are writen to results.dat
* Remember to compile using: cobc -x -free -Wall easter.cob

identification division.
program-id. easter.
environment division.
configuration section.
input-output section.
file-control.
select answer-table, assign to "results.dat"
	organization is line sequential.

data division.
file section.
fd answer-table.
   	01  easter-dates.
		02  easter-day occurs 6 times.
        	03 month pic x(5).
           	03 filler pic x.
           	03 days pic is z9,.
           	03 years pic is zz999.
          	03 filler2 pic x(6).
           
           
working-storage section.
77  temp pic 9(6).
77  temp-1 pic 9(6).
77  base-year pic 9(4).
77  line-count pic 9(2).
77  column-number pic 9.
77  column-year pic 9(4).
77  year pic 9(4).
77  golden-number pic 9(2).
77  century pic 9(2).
77  gregorian-correction pic 9(2).
77  clavian-correction pic 9(2).
77  extra-days pic 9(4).
77  epact pic 9(2).
77  day-holder pic 9(2).
01 easter-copy.
	02 day-data occurs 6 times.
		05 month-data pic x(5).
        05 filler-data pic x.
        05 days-data pic is z9,.
        05 years-data pic is zz999.
        05 filler2-data pic x(6).


procedure division.
*This Paragraph opens the file and increases the base year by 300
*The loop was not changed because it would have changed how the nested loops functioned
outer-loop.
    open output answer-table.
    perform middle-loop 
    	varying base-year from 500 by 300,
    	until base-year equal 5000.
    end-preform.
    close answer-table.
    stop run.
    
*This paragraph's loop exists for keeping track of what line the program is on to be able to
*section off the file's chart in a more reasonable format,     
middle-loop.
    perform inner-loop 
    	varying line-count from 0 by 1,
    	until line-count equal 50.
    end-preform.
    
*This paragraph writes the contents of easter-dates to the file. 
*NOTE:if the if-else statement's contents are not within the preform block
* it will not run. It must assume it is a new paragraph?
inner-loop.
    perform compute-date 
    	varying column-number from 1 by 1,
    	until column-number is greater than 6.
    	
    	if line-count is equal 0
    		if base-year not equal 500
    			write easter-dates from easter-copy before advancing 4 line
    		else
    			write easter-dates from easter-copy before advancing 1 line
    		end-if
    	else
    		write easter-dates from easter-copy before advancing 1 line
    	end-if.
    end-preform.  
    



*Everything below this comment is involved with calculating the date of easter
*of a particular year.   	
compute-date.
*	find-year.
	multiply column-number by 50 giving column-year.
    add column-year, base-year, line-count giving year.
    subtract 50 from year.
*	find-golden-number.

    divide 19 into year giving temp. 
    multiply 19 by temp.
    subtract temp from year giving golden-number.
    add 1 to golden-number.
*if year N 1582 then go to Julian; else go to gregorian
    if year is less than 1583 
    	perform julian
    else
    	perform gregorian
    end-if.
*End of compute-date
 	
gregorian.
*gregorian correction = year/100 +1
*clavain correction = (century-16-(century - 18)/25)
*extra days = (5 X year) + 4 - Gregorian correction - 10
*epaet = rood Ill X golden number 4- 20 4- Clavian correction - Gregorian correction, 30);

    divide 100 into year giving century.
    add 1 to century.
    multiply century by 3 giving temp.
    divide 4 into temp.
    subtract 12 from temp giving gregorian-correction.
    subtract 18 from century giving temp.
    divide 25 into temp.
    subtract temp, 16 from century giving temp.
    divide 3 into temp giving clavian-correction.
    multiply year by 5 giving temp.
    divide 4 into temp.
    subtract 10 , gregorian-correction from temp giving extra-days. 
       	
*	fudge-epact.    	
    multiply 11 by golden-number, giving temp.
   	subtract gregorian-correction from temp.    	
    add 19, clavian-correction to temp.    	
    divide 30 into temp giving temp-1.
    multiply 30 by temp-1.
    subtract temp-1 from temp. 
    add temp, 1 giving epact.
    if epact equal 24 or (epact equal 25 and golden-number is greater than 11)
        add 1 to epact
    end-if.
    perform ending-routine.
*end of gregorian
	
julian.
*extra days = (5 X year) + 4; epaet := rood (11 X golden number -4, 30) + 1;
    multiply year by 5 giving temp.
   	divide 4 into temp giving extra-days.
    multiply golden-number by 11 giving temp.
    subtract 4 from temp.
    divide 30 into temp giving temp-1.
    multiply 30 by temp-1.
    subtract temp-1 from temp.
    add temp, 1 giving epact.
    perform ending-routine.
    	
ending-routine.
*day := 44 - epaet; 
*if d~Ly < 21 then day = day + 30;
*day = day -4- 7 - rood (extra clays q- day, 7);
*if day > 31 then 
*	begin month = 4; day := day - 31 end
*else month = 3


   	subtract epact from 44 giving day-holder.
  	if day-holder is less than 21
   		add 30 to day-holder
   	end-if.
    	
*	make-day-sunday.
    add day-holder, extra-days giving temp.
    divide 7 into temp giving temp-1.
   	multiply 7 by temp-1;
   	subtract temp-1 from temp;
   	subtract temp from 7 giving temp;
   	add temp to day-holder.
*	transfer-answer.

   	if day-holder is greater than 31 
   		subtract 31 from day-holder
   	    move "april" to month-data(column-number)
   	else 
   		move "march" to month-data(column-number)
   	end-if.
   	move day-holder to days-data(column-number).
   	move year to years-data(column-number).
   	

