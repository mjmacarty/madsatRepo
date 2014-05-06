<%@page import="madsat2.bean.Answer"%>
<%@page import="madsat2.bean.Column"%>
<%@page import="java.util.*"%>


<jsp:useBean id="result" class="madsat2.controller.ResultController"
	scope="session" />
<jsp:setProperty name="result" property="*" />
<jsp:useBean id="delete" class="madsat2.controller.FileDeleteController"
	scope="session" />
<jsp:setProperty name="delete" property="*" />

<%
	String sessionDir = request.getSession().getId();
	String dirPath = request.getContextPath() + "\\WebContent\\"
			+ sessionDir;
	String planPath = dirPath + "\\planXML.txt";
	boolean usePlanAgent=false;
	String resultPath = dirPath + "\\result.xml";
	
	if(usePlanAgent){
		resultPath = request.getContextPath()+ "\\WebContent\\result.xml";
	}
	
	
	List<Answer> results = result.getResults(dirPath, resultPath, usePlanAgent);
%>
<h3>Query Results</h3>
<table>
	<tbody>
		<%
			if (results == null) {
				results = result.getResults(dirPath, resultPath, usePlanAgent);
			} else if (results == null) {
		%>
		<tr>
			<th>NO RESULTS FOUND</th>
		</tr>

		<%
			}
			if (results != null && results.size() > 0) {
				List<Column> headers = results.get(0).getColumnList();
		%>
		<tr>
			<%
				for (int i = 0; i < headers.size(); i++) {
						Column col = headers.get(i);
			%>

			<th><%=col.getName()%></th>


			<%
				}
			%>
		</tr>
		<%
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


			<%
				}
			%>
		</tr>
		<%
			}
			} else {
		%>
		<tr>
			<th>No Results Found </th>
		</tr>

		<%
			}
			delete.deletePlan(planPath);
			delete.deleteResult(resultPath);
			resultPath = dirPath + "\\result.xml";
		//	delete.deleteResult(resultPath);
			delete.deleteDir(dirPath);
			delete.cleanStatusFile();

		%>

	</tbody>
</table>
