<HTML>
    <HEAD>
        <TITLE>Submitting Text Fields</TITLE>
		<SCRIPT>
			function qtyChange()
			{
				
    </HEAD>
 
    <BODY>
        <H1>Submitting Text Fields</H1>
        <FORM ACTION="/gaurav/prog" METHOD="GET">
		<TABLE>
			<TR>
				<TD>Enter size of procurement</td>
				<td><INPUT TYPE="text" name="proc"></td>
			</tr>
			<tr>
				<td>Enter maximum value lower than what would be considered waste</td>
				<td><INPUT TYPE="text" name="waste"></td>
			</tr>
				<td>Enter no of unique pieces</td>
				<td><INPUT TYPE="text" name="no"></td>
			</tr>
		</TABLE>
<INPUT TYPE="SUBMIT" value="Submit">
        </FORM>
    </BODY>
<HTML>


Enter No of Procurements
            <INPUT TYPE="TEXT" NAME="proc">
            <BR>Enter maximum size lower than what would be considered waste
            <INPUT TYPE="TEXT" NAME="waste">
            <BR>Enter no of unique pieces to be cut
            <INPUT TYPE="TEXT" NAME="no">
            <BR>
            <INPUT TYPE="SUBMIT" value="Submit">