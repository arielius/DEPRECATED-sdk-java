<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <title>Search approved payments in last month</title>
    </head>
    <body>
        <%-- Include Mercadopago library --%>
        <%@page import="com.mercadopago.MP"%>
        <%@page import="java.util.Map"%>
        <%@page import="java.util.HashMap"%>
        <%@page import="org.codehaus.jettison.json.JSONObject"%>
        <%@page import="org.codehaus.jettison.json.JSONArray"%>
        <%
        /**
         * MercadoPago SDK
         * Search approved payments in last month
         * @date 2012/03/29
         * @author hcasatti
         */
        
        // Create an instance with your MercadoPago credentials (CLIENT_ID and CLIENT_SECRET): 
        // Argentina: https://www.mercadopago.com/mla/herramientas/aplicaciones 
        // Brasil: https://www.mercadopago.com/mlb/ferramentas/aplicacoes
        MP mp = new MP ("CLIENT_ID", "CLIENT_SECRET");
      
        // Sets the filters you want
        Map<String, Object> filters = new HashMap<String, Object> ();
            filters.put("range", "date_created");
            filters.put("begin_date", "NOW-1MONTH");
            filters.put("end_date", "NOW");
            filters.put("status", "approved");
            filters.put("operation_type", "regular_payment");

        // Search payment data according to filters
        JSONObject searchResult = mp.searchPayment (filters);
        JSONArray results = searchResult.getJSONObject("response").getJSONArray("results");
        
        // Show payment information
        %>
        <table border='1'>
            <tr><th>id</th><th>date_created</th><th>operation_type</th><th>external_reference</th></tr>
            <%
            for (int i = 0; i < results.length(); i++) {
                %>
                <tr>
                    <td><%=results.getJSONObject(i).getString("id")%></td>
                    <td><%=results.getJSONObject(i).getString("date_created")%></td>
                    <td><%=results.getJSONObject(i).getString("operation_type")%></td>
                    <td><%=results.getJSONObject(i).getString("external_reference")%></td>
                </tr>
                <%
            }
            %>
        </table>
    </body>
</html>