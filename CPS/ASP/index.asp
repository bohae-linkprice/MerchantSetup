<!--#include virtual="jsonObject.asp"-->

<%

Const LP_URL  = "https://service.linkprice.com/lppurchase_cps_v3.php"
Const NWNAME = "linkprice"
Dim search_order_code               	'order code from complete payment page
search_order_code = "order_code"

set send_data = New JSONarray

Dim conn, result, sql, command

set conn = CreateObject("ADODB.Connection")
conn.Open "your connection string"\

Set command = Server.CreateObject("ADODB.Command")
Set command.ActiveConnection = conn
command.CommandType = adCmdText

' Change filed name to your field name
' 

' 'lpinfo' => 'LPINFO 쿠키정보(LPINFO cookie value)',
' 'merchant_id' => '계약시 제공 받은 머천트 아이디(Merchant ID from Linkprice)',
' 'order_code' => '주문 코드(Order code)',
' 'product_code' => '상품 코드(Product code)',
' 'product_name' => '상품명(Product name)',
' 'item_count' => '상품 개수(Quantity of product)',
' 'sales' => '금액(Total price)',
' 'category_code' => '계약시 협의(Category in Contract)',	// 카테고리 코드
' 'member_id' => 'user_id',					// 회원 ID
' 'remote_address' => '사용자의 IP(User IP)'			// $_SERVER["REMOTE_ADDR"]
' 'user_agent' => '유저 에이전트(User agent)',	        	// $_SERVER["HTTP_USER_AGENT"]


command.CommandText = "SELECT	network_value 			lpinfo," + _
				"'your merchant id' 		merchant_id,"+ _
				"user_id 			member_id,"+ _
				"order_code 			order_code,"+ _
				"product_code 		    	product_code,"+ _
				"price 				sales,"+ _
				"product_name			product_name,"+ _
				"count 				item_count,"+ _
				"category 			category_code,"+ _
				"remote_address 		remote_addr,"+ _
				"u_agent 			user_agent"+ _
			" FROM your_order_table"+ _
			" WHERE order_code = ?"+ _
			" AND	  network_name =?"

command.Parameters.Append(command.CreateParameter("order_code", adchar, adParamInput, Len(search_order_code), search_order_code))
command.Parameters.Append(command.CreateParameter("network_value", adchar, adParamInput, Len(NWNAME), NWNAME))

set result = command.execute
send_data.LoadRecordset result

result.Close
conn.Close

set con = Server.CreateObject("Msxml2.ServerXMLHTTP")
con.open "POST", LP_URL, false
con.setRequestHeader "Content-Type", "application/json"
con.send send_data.Serialize()

%>
