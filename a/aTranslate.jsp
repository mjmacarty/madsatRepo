<%@page import="Query.Translation"%>
<%@page import="java.sql.DriverManager"%>

<%

	String user = "root";
	String pword = "Ria";
	String db = "";
	String nlQText = "";

	DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	boolean isQueryOK = false;

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
<li class="translation"><%= sqls[i] %></li>
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




