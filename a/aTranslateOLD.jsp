<%@page import="Query.Translation"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.nio.file.*"%>

<jsp:useBean id="translation" class="madsat2.controller.TranslationController" scope="session"/>
<jsp:setProperty name="translation" property="*"/> 
<jsp:useBean id="delete" class="madsat2.controller.FileDeleteController" scope="session"/>
<jsp:setProperty name="delete" property="*"/> 

<%
	String user = "root";
	String pword = "Ria";
	String db = "";
	String nlQText = "";
	String planPath = "C:\\Agent7\\WebContent\\planXML.txt";
	String resultPath = "C:\\Agent7\\WebContent\\result.xml";
	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	boolean isQueryOK = false;
	delete.deletePlan(planPath);
	delete.deleteResult(resultPath);

	String query = request.getParameter("q");
	if (query != null && query.contains(":")) {
		String[] qArray = query.split(":");
		if (qArray.length > 1) {
			db = qArray[0];
			nlQText = qArray[1];
			try {
				Translation trans = new Translation(false);
				int nQ = 10; //length of array
				String[] sqls = null;
				if (!trans.equals(null)) {
					sqls = trans.doTranslation(db, user, pword,
							nlQText, nQ);
					if (sqls.equals(null) || sqls.length < 1) {
						out.println("====NO TRANSLATION FOUND===");
						isQueryOK = false;
					} else {
						for (int i = 0; i < sqls.length; i++) {
%>
<li class="translation"><%=sqls[i]%></li>
<%
	}
					}
				}
			} catch (Exception e) {
				isQueryOK = false;
				out.println("Translation or Plan Error");
			}
		}
	}
%>




