<%@page import="java.nio.file.*"%>
<%@page import="madsat2.bean.Answer"%>
<%@page import="java.util.List"%>
<%@page import="Query.Plan"%>
<%@page import="java.io.*"%>
<%@page import="madsat2.xml.FileUtil"%>


<%
	String user = "root";
	String pword = "Ria";
	String db = "";
	String nlQText = "";
	String sql = "";
	boolean useAgent = false;

	String query = request.getParameter("q");
	System.out.println("query= " + query);
	if (query.contains(":")) {
		String[] qArray = query.split(":");
		db = qArray[0];
		sql = qArray[1];
	}
	System.out.println("db= " + db);
	System.out.println("sql= " + sql);
	try {
		Plan plan = new Plan(false);
		if (!plan.equals(null)) {
			String path = "C:\\Agent7\\WebContent\\";
			plan.generatePlan(db, user, pword, sql, path);
			String fullpath = "C:\\Agent7\\WebContent\\planXML.txt";
			String path2 = "C:\\Agent7\\src\\madsat2\\xml\\data\\planXML.txt";
			if (FileUtil.isPlanXMLFileReady(fullpath)) {
				if (useAgent) {
					File dest = new File(path2);
					dest.setWritable(true);
					Files.copy(Paths.get(fullpath), dest.toPath(),
							StandardCopyOption.REPLACE_EXISTING);
				}
				System.out.println("Plan Successfully created");
				try {
					FileReader fr = new FileReader(fullpath);
					BufferedReader br = new BufferedReader(fr);
					String sCurrentLine;
%>
<h3>Raw Plan XML</h3>
<%
	while ((sCurrentLine = br.readLine()) != null) {
%>
<li><xmp><%=sCurrentLine%></xmp></li>
<%
	}
					br.close();
					fr.close();
				} catch (IOException e) {
					out.println("Cannot read the results");
				}
			}
		}

	} catch (Exception e) {
		out.println("Translation or Plan Error");
	}
%>

