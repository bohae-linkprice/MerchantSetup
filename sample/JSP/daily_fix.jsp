<%
    /*
    # DataBase ����

    # LINKPRICE �� ���ؼ� ���ŵ� �ֹ����� QUERY
    # 	QUERY ����  : ��������=yyyymmdd and ���޻�=��ũ�����̽�
    # 	SELECT �÷� : ���Žð�, LPINFO ��Ű, ������ID, �������̸�, �ֹ���ȣ, ��ǰ�ڵ�, �ֹ�����, ��ǰ�ܰ�
    #ex) query = "select * from ��ũ�����̽� �������̺� where ��¥ = 'yyyymmdd' and ���޻� = 'LINKPRICE'";
    */
    String connInfo = "jdbc:oracle:thin:@localhost:1521:orcl";
    java.sql.Connection conn = null;
    java.sql.Statement stmt = null;
    java.sql.ResultSet rs = null;

    Class.forName("oracle.jdbc.driver.OracleDriver");
    /*============================================*/
    //Properties ����
    java.util.Properties props = new java.util.Properties();
    props.put("user","user");
    props.put("password","password");
    props.put("CHARSET","eucksc");

    conn = java.sql.DriverManager.getConnection(connInfo,props);

    // QUERY ����� $row ��� ������ ����Ǿ��ٰ� ����

    StringBuffer sb = new StringBuffer();
    int index = 0;
    String sql = "select * from ��ũ�����̽� �������̺� where ��¥ = 'yyyymmdd'";
    try {
        stmt = conn.createStatement();
        stmt.executeQuery(sql);
        rs = stmt.getResultSet();

        while (rs.next())
        {
            sb = new StringBuffer();
            if (index > 0)	sb.append("\r\n");

            sb.append(rs.getString("HHMISS") + "\t");
            sb.append(rs.getString("LPINFO") + "\t");
            sb.append(rs.getString("ID") + "(" + rs.getString("NAME") + ")" + "\t");
            sb.append(rs.getString("ORDER_CODE") + "\t");
            sb.append(rs.getString("PRODUCT_CODE") + "\t");
            sb.append(rs.getString("ITEM_COUNT") + "\t");
            sb.append(rs.getString("PRICE") + "\t");
            sb.append(rs.getString("CATEGORY_CODE") + "\t\t");
            sb.append(rs.getString("PRODUCT_NAME") + "\t");
            sb.append(rs.getString("REMOTE_IP"));
            out.print (sb.toString());
            index++;
        }
    }
    catch(Exception e)
    {
        out.println (e.getMessage());
    }
    finally
    {
        if (rs != null) try {rs.close();} catch (Exception e) {}
        if (stmt != null) try {stmt.close();} catch (Exception e) {}
        if (conn != null)
        {
            try	{conn.close();}	catch (Exception e)	{}
        }
    }
%>