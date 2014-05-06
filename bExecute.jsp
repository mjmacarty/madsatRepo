<%@page import="java.nio.file.*"%>
<%@page import="madsat2.bean.Answer"%>
<%@page import="java.util.List"%>
<%@page import="Query.Plan"%>
<%@page import="java.io.*"%>
<%@page import="madsat2.xml.FileUtil"%>


<jsp:useBean id="execute" class="madsat2.controller.ExecuteController"
	scope="session" />
<jsp:setProperty name="execute" property="*" />
<jsp:useBean id="delete" class="madsat2.controller.FileDeleteController"
	scope="session" />
<jsp:setProperty name="delete" property="*" />

<%
	String user = "root";
	String pword = "Matthew";
	String query = request.getParameter("q");
	String sessionDir = request.getSession().getId();
	String planPath =request.getContextPath()+ "\\WebContent\\" + sessionDir + "\\";
	
	System.out.println("request.getContextPath()= " + request.getContextPath());
	System.out.println("query= " + query);
	List<String> lines = execute.processTranslation(query, user, pword,
			planPath);
%>
<h3>Raw Plan XML</h3>
<%
	for (String str : lines) {
%>
<li><xmp><%=str%></xmp></li>
<%
	}

%>

