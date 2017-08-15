<?php
$auto_cancel = array();

$sql = "select	'order_status' = 
                CASE 
                when order_status = '���Ա�' then 0 
                when order_status = 'Ȯ��' then 1
                when order_status = '�ֹ����' then 2
                when order_status = '�ֹ�����' then 3
                else 9
                END,
                'reason' = 
                CASE
                when order_status = '���Ա�' then '���Ա�' 
                when order_status = 'Ȯ��' then '�ֹ� ���� Ȯ��'
                when order_status = '�ֹ����' then '�ֹ� ���'
                when order_status = '�ֹ�����' then '�ֹ� ����'
                else 'Ȯ�ο��(���ܻ�Ȳ')
                END          
		from your_order_table
		where order_code = ?
		and	  product_code = ?";

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