<%@page import="java.nio.file.*"%>
<%@page import="madsat2.xml.WatchJSPPlanXML"%>
<%@page import="madsat2.bean.Answer"%>
<%@page import="java.util.List"%>
<%@page import="madsat2.controller.QueryController"%>
<%@page import="Query.Translation"%>
<%@page import="java.io.*"%>


<%
	String resultPath = "C:/Agent7/WebContent/result.xml";
	if (Files.exists(Paths.get(resultPath))) {
		Files.delete(Paths.get(resultPath));
		System.out.println(resultPath + " was deleted ");
	}
	String path = "C:\\Agent7\\src\\madsat2\\xml\\data\\";
	boolean isQueryOK = false;
	String query = request.getParameter("q");
	String db = "";
	String nlQText = "";
	String user = "root";
	String pword = "Ria";

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
						 %>
						<?xml version="1.0"?>
						<queries>	
						<%	
						for (int i = 0; i < sqls.length; i++) {
							

							 %>
							 <sql><%= sqls[i] %></sql>
							
							
							<%
						}
						 %>
						</queries>
						<%	
					}
				}
			} catch (Exception e) {
				isQueryOK = false;
				out.println("Translation or Plan Error");
			}
		}

	}
%>




