<%@ page language="java" contentType="application/json; charset=euc-kr" %>

<%@ page import="org.json.simple.*"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*" %>

<%
String sql = new String();
String order_code = request.getParameter("order_code");
String product_code = request.getParameter("product_code");

sql = "SELECT	'order_status' = "
	 		   +"CASE "
	 		   +"when order_status = '���Ա�' then 0 "
	 		   +"when order_status = 'Ȯ��' then 1 "
			   +"when order_status = '�ֹ����' then 2 "
	 		   +"when order_status = '�ֹ�����' then 3 "
	 		   +"else 9 "
	 		   +"END "
	 		   +"'reason' = "
	 		   +"CASE "
               +"when order_status = '���Ա�' then '���Ա�' "
               +"when order_status = 'Ȯ��' then '�ֹ� ���� Ȯ��' "
               +"when order_status = '�ֹ����' then '�ֹ� ���' "
       		   +"when order_status = '�ֹ�����' then '�ֹ� ����' "
   	 		   +"else 'Ȯ�ο��(���ܻ�Ȳ)' "
               +"END "
               +"from your_order_table "
               +"where order_code = ? "
                +"product_code = ?"
Connection conn = null;
PreparedStatement stmt = null;
ResultSet result = null;

stmt = conn.prepareStatement(sql);
stmt.setString(1, order_code);
stmt.setString(2, product_code);
result = stmt.executeQuery();

JSONArray auto_cancel = new JSONArray();
while(result.next()){
	JSONObject json = new JSONObject();

	int total_rows = result.getMetaData().getColumnCount();
	for(int i = 0; i < total_rows; i++){
		json.put(result.getMetaData().getColumnLabel(i + 1).toLowerCase(), result.getObject(i+1));
	}
	auto_cancel.add(json);
}

	out.println(auto_cancel.toString());
	out.flush();
%>