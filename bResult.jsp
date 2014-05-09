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
	//	String sessionDir = request.getSession().getId();
	String sessionDir = (String) session.getAttribute("sessionDir");
	String dirPath = "C:/Agent7/WebContent/" + sessionDir;
	String planPath = dirPath + "/planXML.txt";
	boolean usePlanAgent = false;
	String resultPath = dirPath + "/result.txt";

	if (usePlanAgent) {
		resultPath = request.getContextPath()
				+ "/WebContent/result.txt";
	}

	List<Answer> results = result.getResults(dirPath, resultPath,
			usePlanAgent);
%>
<h3>Query Status</h3>
<table>
	<tbody>
		<tr>
			<th>Processing Plan XML</th>
		</tr>
	</tbody>
</table>
