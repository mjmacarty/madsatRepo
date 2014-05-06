<%@page import="java.nio.file.*"%>
<%@page import="madsat2.xml.ResultXMLReader"%>
<%@page import="java.io.*"%>
<%@page import="madsat2.xml.FileUtil"%>
<%@page import="madsat2.bean.Answer"%>
<%@page import="madsat2.bean.Column"%>
<%@page import="java.util.*"%>
<%@page import="madsat2.controller.*"%>
<%@page import="madsat2.xml.DeleteFiles"%>


<%
	String path = "C:/Agent7/WebContent/temp/";
	//new DeleteFiles().deleteFilesInFolder(path );
	String resultPath = "C:\\Agent7\\WebContent\\result.xml";
	if (Files.exists(Paths.get(resultPath))) {
		try {
			Files.delete(Paths.get(resultPath));
			System.out.println(resultPath + " was deleted ");
		} catch (Exception e) {
			System.out.println(resultPath + " cannot be  deleted ");
		}
	}
	String planPath = "C:\\Agent7\\WebContent\\planXML.txt";
	if (FileUtil.isPlanXMLFileReady(planPath)) {
	PlanXMLProcessor pp = new PlanXMLProcessor();
	List<Answer> results=  pp.processPlan(planPath);
%>
<h3>Query Results</h3>
<table>
	<tbody>
		<%
			if (results == null) {
		%>
		<tr>
			<th>NO RESULTS FOUND</th>
		</tr>

		<%
			}
				if (results != null && results.size() > 0) {
					List<Column> headers = results.get(0).getColumnList();
					for (int i = 0; i < headers.size(); i++) {
						Column col = headers.get(i);
		%>
		<tr>
			<th><%=col.getName()%></th>
		</tr>
		<%
			}
					for (int j = 0; j < results.size(); j++) {
						Answer res = results.get(j);
						List<Column> colList = res.getColumnList();
		%>

		<tr>
			<%
				for (int k = 0; k < colList.size(); k++) {
								Column col = colList.get(k);
			%>
			<td><%=col.getValue()%></td>
		</tr>

		<%
			}
					
				}
			} else {
		%>
		<tr>
			<th>NO RESULTS FOUND</th>
		</tr>

		<%
			}
	
	if (Files.exists(Paths.get(planPath))) {
		try {
			Files.delete(Paths.get(planPath));
			System.out.println(planPath + " was deleted ");
		} catch (Exception e) {
			System.out.println(planPath + " cannot be  deleted ");
		}
	}}
		%>

	</tbody>
</table>
