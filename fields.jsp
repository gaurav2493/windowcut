<HTML>
    <HEAD>
        <TITLE>Submitting Text Fields</TITLE>
	</HEAD>
 
    <BODY>
        <H1>Submitting Text Fields</H1>
        <FORM ACTION="/gaurav/prog" METHOD="Post">
            <br>
<TABLE border=1>
<tr><td>Size of procurement</td>
<%
 out.println("<td><INPUT TYPE=\"TEXT\" NAME=\"proc\" value=\""+request.getParameter("proc").trim()+"\"  ></td></tr>");
 %>
<tr><td>Maximum value lower than what would be considered waste</td>
<%
 out.println("<td><INPUT TYPE=\"TEXT\" NAME=\"waste\" value=\""+request.getParameter("waste").trim()+"\" ></td></tr>");
 %>
<tr><td>no of unique pieces</td>
<%
 out.println("<td><INPUT TYPE=\"TEXT\" NAME=\"no\" value=\""+request.getParameter("no").trim()+" \" ></td></tr>");
 %>
</table>
<hr>
 <TABLE>
	<tr><b>
		<td>Piece size</td>
		<td>Quantity</td></b>
	</tr> 
 <%
for(int i=0;i<Integer.parseInt(request.getParameter("no").trim());i++)
{  
            out.println("<tr><td><INPUT TYPE=\"TEXT\" NAME=\"tf1"+i+"\"></td>");
            out.println("<td><INPUT TYPE=\"TEXT\" NAME=\"tf2"+i+"\"></td></tr>");
}
%>
</TABLE>
<INPUT TYPE="SUBMIT" value="Submit">
        </FORM>
    </BODY>
<HTML>
