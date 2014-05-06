<%@page import="java.nio.file.*"%>
<%@page import="madsat2.xml.WatchJSPPlanXML"%>
<%@page import="madsat2.bean.Answer"%>
<%@page import="java.util.List"%>
<%@page import="madsat2.controller.QueryController"%>
<%@page import="Query.Plan"%>
<%@page import="java.io.*"%>
<html>
<head>
</head>
<body>
	<h3>Madsat Results</h3>
	<tbody>
		<%
			String resultPath = "C:/Agent7/WebContent/result.xml";

			if (Files.exists(Paths.get(resultPath))) {
				Files.delete(Paths.get(resultPath));
				System.out.println(resultPath + " was deleted ");
			}

			String path = "C:\\Agent7\\WebContent\\";
			String path2 = "C:\\Agent7\\src\\madsat2\\xml\\data\\planXML.txt";
			String query = request.getParameter("q");
			System.out.println("query= " + query);
			out.println(query);
			String db = "madsat";
			String nlQText = "";
			String user = "root";
			String pword = "Ria";
			String sql = "SELECT salute.Platform FROM salute JOIN naimobility ON salute.NAI = naimobility.NAI WHERE naimobility.Mobility = 'NoGo'";

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
					plan.generatePlan(db, user, pword, sql, path);

					String dirPath = "C:\\Agent7\\WebContent";
					String fullpath = dirPath + "\\planXML.txt";
					boolean recursive = true;

					Path dir = Paths.get(path);
					WatchJSPPlanXML wpXML = new WatchJSPPlanXML(dir, recursive);
					if (wpXML.isPlanXMLFileReady(fullpath)) {
						File dest = new File(path2);
						dest.setWritable(true);
						Files.copy(Paths.get(fullpath), dest.toPath(),
								StandardCopyOption.REPLACE_EXISTING);
						
						System.out.println("*******Success");
					}

				}

			} catch (Exception e) {
				System.err.println("Translation or Plan Error");
				String noresultPath = "C:/Agent7/WebContent/no-can-do.xml";
				if (Files.exists(Paths.get(noresultPath))) {
					File dest = new File(resultPath);
					dest.setWritable(true);
					Files.copy(Paths.get(noresultPath), dest.toPath(),
							StandardCopyOption.REPLACE_EXISTING);

				}

			}
			
			String transPath = "C:/Agent7/WebContent/translation.xml";
			if (Files.exists(Paths.get(transPath))) {
				try{
				Files.delete(Paths.get(transPath));
				System.out.println(transPath + " was deleted ");
				}catch (Exception e){
					System.out.println(transPath + " cannot be  deleted ");
				}
			}
		%>
	
</body>
</html>


