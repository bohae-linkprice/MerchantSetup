<%
    ' DataBase ����

    ' LINKPRICE �� ���ؼ� ���ŵ� �ֹ����� QUERY
    ' 	QUERY ����  : ��������=yyyymmdd and ���޻�=��ũ�����̽�
    ' 	SELECT �÷� : ���Žð�, LPINFO ��Ű, ������ID, �������̸�, �ֹ���ȣ, ��ǰ�ڵ�, �ֹ�����, ��ǰ�ܰ�, ������IP

    ' QUERY ����� Rs ��� ������ ����Ǿ��ٰ� ����

    Do until Rs.EOF
        line = Rs("HHMISS") & chr(9)
        line = line & Rs("LPINFO") & chr(9)
        line = line & Rs("ID") & "(" & Rs("NAME") & ")" & chr(9)
        line = line & Rs("ORDER_NO") & chr(9)
        line = line & Rs("PRODUCT_CODE") & chr(9)
        line = line & Rs("ITEM_COUNT") & chr(9)
        line = line & Rs("PRICE") & chr(9)
        line = line & Rs("CATEGORY_CODE") & chr(9) & chr(9)
        line = line & Rs("PRODUCT_NAME") & chr(9)
        line = line & Rs("REMOTE_ADDR")

        Rs.MoveNext

        if Rs.EOF = false then
            line = line & chr(13) & chr(10)
        end if

        Response.write line
    Loop

    ' DataBase ���� ����
%>