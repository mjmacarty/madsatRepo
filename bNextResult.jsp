<%@page import="madsat2.bean.Answer"%>
<%@page import="madsat2.bean.Column"%>
<%@page import="java.util.*"%>
<%@page import="madsat2.xml.FileUtil"%>
<%@page import="madsat2.controller.ResultXMLReader"%>
<%@page import="java.util.*"%>
<%@page import="java.util.*"%>



<%
    String sessionDir =(String) session.getAttribute("sessionDir");
	String query = request.getParameter("q");
	System.out.println("query= " + query);
	System.out.println("rowNumber of prev session= "
			+ session.getAttribute("rowNumber"));
	int j = 0;
	int prevRowNumber = 0;
	int rowNumberInc = 0;
	int rowSize=100;
	
	try{
		rowNumberInc = Integer.parseInt(query);
	}catch(Exception e){
		System.out.println("Check values of next and previous buttons");
	}
	try {
		String prStr = (String) session.getAttribute("rowNumber");
		prevRowNumber = Integer.parseInt(prStr);
		j = rowNumberInc + prevRowNumber;
		if (j > -1) {
			session.setAttribute("rowNumber", String.valueOf(j));
		}
	} catch (Exception e) {
		session.setAttribute("rowNumber", "0");
		
	}

	String dirPath = request.getContextPath() + "\\WebContent\\"
			+ sessionDir;
	String resultPath = dirPath + "\\result.txt";
	System.out.println("result path=" + resultPath);

	List<Answer> results = null;
	if (FileUtil.isPlanXMLFileReady(resultPath)) {
	
		ResultXMLReader pr = new ResultXMLReader();
		results = pr.processXML(resultPath);
	}
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
			} else if (results != null && results.size() > 0) {
				int sz = results.size();
				if(j >sz ){
					j=sz -10;
					session.setAttribute("rowNumber", String.valueOf(j));
				}
				if(j< 0){
					j=0;
					session.setAttribute("rowNumber", String.valueOf(j));
				}
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
		   int resCount= 0;
			while (j < results.size() && j > -1) {
					Answer res = results.get(j);
					List<Column> colList = res.getColumnList();
					j++;
					if(resCount++ == rowSize) break;
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
			<th>NO RESULTS FOUND</th>
		</tr>

		<%
			}
		%>

	</tbody>
</table>
