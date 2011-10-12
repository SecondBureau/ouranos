
function day_title(day_name){
	document.write("<td align=center width=35>"+day_name+"</td>");
}
// fills the month table with numbers
function fill_table(month, month_length, year)
{ 
  day=1;
  today= new Date(month + " 1, " + year);
	start_day = today.getDay() + 1;
  // begin the new month table
  document.write("<table id='calendar_table' border=0 cellspacing=1>")
  document.write("<tr><td colspan=7 align=center style='background:#333;'><h3 style='display:inline-block;'>" + month + "   " + year + "</h3></td></tr>")
  // column headings
 	document.write("<tr>");
  day_title("Sun")
  day_title("Mon")
  day_title("Tue")
  day_title("Wed")
  day_title("Thu")
  day_title("Fri")
  day_title("Sat")
  // pad cells before first day of month
  document.write("</tr>"); 
  fill_month(start_day, day, month_length);
  document.write("</table>");
}

function fill_month(start_day, day, month_length){
	document.write("<tbody><tr>");
  for (var i=1;i<start_day;i++){
    document.write("<td>");
  }
  // fill the first week of days
  for (var i=start_day;i<8;i++){
    document.write("<td align=center>"+day+"</td>");
    day++;
  }
  document.write("<tr>")
  // fill the remaining weeks
  while (day <= month_length) {
     for (var i=1;i<=7 && day<=month_length;i++){
         document.write("<td align=center>"+day+"</td>")
         day++
     }
     document.write("</tr><tr>")
     // the first day of the next month
     start_day=i
  }
  document.write("</tr></tbody>");
}
