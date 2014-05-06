<%@page import="madsat2.bean.Answer"%>
<%@page import="java.util.List"%>
<%@page import="madsat2.controller.QueryController"%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/jquery.autocomplete.css" />
        <style>
            input {
                font-size: 120%;
            }
        </style>
    </head>
    <body>
        <h3>Madsat Results</h3>

        <table  cellpadding="5">

            <tbody>
                <%

                    String query = request.getParameter("constrained_text");
                    out.println(request.getQueryString());
                    session.setAttribute("sessionQuery", query);

                    QueryController controller = new QueryController();
                    if (!query.equals(null)){
                    List<Answer> answers = controller.getAnswers(query);

                    for (int i = 0; i < answers.size(); i++) {
                        Answer ans = answers.get(i);
                %>

                <tr>
                    <td>           
                        <%= ans.getDescription()%>
                    </td>
                    <td>            
                        <%=ans.getQueryString()%>
                    </td>
                </tr>               

                <%
                    }}
                %>

                <tr>
                    <td>
                        <a href="http://localhost:8080/Agent7/"/>New Query</a>
                    </td>
                </tr>
            </tbody>
        </table>

    </body>

</html>


