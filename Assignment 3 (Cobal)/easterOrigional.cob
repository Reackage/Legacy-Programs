identification division.
program-id. date of easter.
AUTHOR. D E KNUTH.
DATE-WRITTEN. JANUARY 22, 1962.
DATE-COMPILED. JANUARY 23, 1962.
ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
SOURCE-COMPUTER. COBOLIAC.
OBJECT-COMPUTER. COBOLIAC-2, PRINTER.
SPECIAL-NAMES.
    printer-overflow is skip-to-next-page.
input-output section.
FILE-CONTROL.
    select answer-table, assign to printer.
data division.
file section.
FD ANSWER-TABLE; LABEL RECORDS ARE STANDARD; DATA
       RECORD IS EASTER-DATES.
   01  EASTER-DATES.
       02  easter-day; occurs 6 times.
           03 MONTH; SIZE IS 5 ALPHABETIC DISPLAY CHARACTERS.
           03 filler; size is 1 characters.
           03 days; picture is z9,.
           03 YEARS; PICTURE IS ZZ999.
           03 FILLER; SIZE IS 6 CHARACTERS.
working-storage section.
77  TEMP; SIZE 6 NUMERIC COMPUTATIONAL.
77  temp-1; size 6 numeric computational.
77  base-year; size 4 numeric computational.
77  line; size 2 numeric computational.
77  column; size 1 numeric computational.
77  column-year; size 4 numeric computational.
77  year; size 4 numeric computational.
77  golden-number; size 2 numeric computational.
77  century; size 2 numeric computational.
77  gregorian-correction; size 2 numeric computational.
77  clavian-correction; size 2 numeric computational.
77  extra-days; size 4 numeric computational.
77  epact; size 2 numeric computational.
77  day; size 2 numeric computational.
procedure division.
control section.
outer-loop.
    open output answer-table.
    perform middle-loop varying base-year from 500 by 300
    until base-year equals 5000.
    stop run.
middle-loop.
    perform inner-loop varying line from 0 by 1
    until line equals 50.
inner-loop.
    perform computation varying column from 1 by 1 until column exceeds 6.
    if line is not equal to 49, write easter-dates;
    otherwise write easter-dates before skip-to-next-page.
computation section.
find-year.
    multiply column by 50 giving column-year;
    add column-year, base-year, line, and -50 giving year.
find-golden-number.
    divide 19 into year giving temp; 
    multiply 19 by temp;
    subtract temp from year giving golden-number then
    add 1 to golden-number.
    if year is less than 1583 go to julian.
gregorian.
    divide 100 into year giving century; add 1 to century.
    multiply century by 3 giving temp; divide 4 into temp;
    subtract 12 from temp giving gregorian-correction.
    subtract 18 from century giving temp; divide 25 into temp;
    subtract temp and 16 from century giving temp;
    divide 3 into temp gicing clavian-correction.
    multiply year by 5 giving temp; divide 4 into temp;
    subtract 10 and gregorian-correction from temp giving extra-days.
fudge-epact.
    multiply golden-number by 11 giving temp;
    subtract gregorian-correction from temp;
    add 19, clavian-correction, temp;
    divide 30 into temp giving temp-1;
    multiply 30 by temp-1;
    subtract temp-1 from temp; 
    add temp, 1 giving epact.
    if epact equals 24 or (25 and golden-number is greater than 11)
        add 1 to epact.
    go to ending-routine.
julian.
    multiply year by 5 giving temp;
    divide 4 into temp giving extra-days.
    multiply golden-number by 11 giving temp;
    subtract 4 from temp;
    divide 30 into temp giving temp-1;
    multiply 30 by temp-1;
    subtract temp-1 from temp;
    add temp and 1 giving epact.
ending-routine.
    subtract epact from 44 giving day;
    if day is less than 21 add 30 to day.
make-day-sunday.
    add day, extra-days giving temp;
    divide 7 into temp giving temp-1.
    multiply 7 by temp-1;
    subtract temp-1 from temp;
    subtract temp from 7 giving temp;
    add temp to day.
transfer-answer.
    if day exceeds 31 then subtract 31 from day;
        move "april" to month(column);
    otherwise move "march" to month(column).
    move day to days(column);
    move year to years(column).

