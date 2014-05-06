<%@page import="Query.Translation"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.nio.file.*"%>

<jsp:useBean id="translation"
	class="madsat2.controller.TranslationController" scope="session" />
<jsp:setProperty name="translation" property="*" />

<%
	String user = "root";
	String pword = "Matthew";

	String query = request.getParameter("q");
	String[] sqls = translation.processTranslation(query, user, pword);

	for (int i = 0; i < sqls.length; i++) {
%>
<li class="translation"><%=sqls[i]%></li>
<%
	}
%>




