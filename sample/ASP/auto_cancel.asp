<!--#include virtual="jsonObject.asp"-->

<%
Response.LCID = 1043

Dim order_code, product_code

set order_code = request.QueryString("order_code")
set product_code = request.QueryString("product_code")

set auto_cancel = New JSONarray

Dim conn, result, sql, command

set conn = CreateObject("ADODB.Connection")
conn.Open "your connection string"

Set command = Server.CreateObject("ADODB.Command")
Set command.ActiveConnection = conn
command.CommandType = adCmdText

command.CommandText = "SELECT	'order_status' = " + _
	 		                "CASE "+ _
	 		                "when order_status = '���Ա�' then 0 "+ _
	 		                "when order_status = 'Ȯ��' then 1 "+ _
			                "when order_status = '�ֹ����' then 2 "+ _
	 		                "when order_status = '�ֹ�����' then 3 "+ _
	 		                "else 9 "+ _
	 		                "END "+ _
	 		                "'reason' = " +_
	 		                "CASE "+ _
                            "when order_status = '���Ա�' then '���Ա�' "+ _
                            "when order_status = 'Ȯ��' then '�ֹ� ���� Ȯ��' "+ _
                            "when order_status = '�ֹ����' then '�ֹ� ���' "+ _
                            "when order_status = '�ֹ�����' then '�ֹ� ����' "+ _
                            "else 'Ȯ�ο��(���ܻ�Ȳ)' "+ _
                            "END "+ _
                            "from your_order_table "+_
                            "where order_code = ? "+_
                            "and product_code = ?"

command.Parameters.Append(command.CreateParameter("order_code", adchar, adParamInput, Len(order_code), order_code))
command.Parameters.Append(command.CreateParameter("product_code", adchar, adParamInput, Len(product_code), product_code))

set result = command.execute
auto_cancel.LoadRecordset result

result.Close
conn.Close

response.ContentType = "application/json;charset=euc-kr"
response.Write(auto_cancel.Serialize())

%>
