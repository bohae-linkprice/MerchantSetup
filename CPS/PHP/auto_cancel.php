<?php
$auto_cancel = array();

$db_ip = "DATABASE IP";
$db_id = "DATABASE ID";
$db_pw = "DATABASE PASSWORD";
$db_nm = "DATABASE NAME";
$conn = mysqli_connect($db_ip, $db_id, $db_pw, $db_nm);

$sql = "SELECT	
	CASE 
	WHEN	order_status = '미입급' THEN 0 
	WHEN	order_status = '확정' THEN 1
	WHEN	order_status = '주문취소' THEN 2
	WHEN	order_status = '주문없음' THEN 3
	ELSE	9
	END AS `order_status`,
	CASE
	WHEN 	order_status = '미입급' THEN '미입금' 
	WHEN	order_status = '확정' THEN '주문 최종 확정'
	WHEN	order_status = '주문취소' THEN '주문 취소'
	WHEN	order_status = '주문없음' THEN '주문 없음'
	ELSE '확인요망(예외상황')
	END AS `reason`
	FROM	your_order_table
	WHERE	order_code = ?
	AND	product_code = ?";

$stmt = mysqli_stmt_init($conn);
if(mysqli_stmt_prepare($stmt,$sql)){
    mysqli_stmt_bind_param($stmt,"ss",$_GET["order_code"],$_GET["product_code"]);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $auto_cancel = mysqli_fetch_assoc($result);
    mysqli_stmt_close($stmt);
}

header('Content-Type: application/json');
echo json_encode($auto_cancel);

?>