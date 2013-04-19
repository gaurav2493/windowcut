<HTML>
    <HEAD>
        <TITLE>Submitting Text Fields</TITLE>
    </HEAD>
 
    <BODY>
        <H1>Submitting Text Fields</H1>
        <FORM ACTION="fields.jsp" METHOD="POST">
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
		<BR>
            <INPUT TYPE="SUBMIT" value="Submit">
        </FORM>
    </BODY>
</HTML>