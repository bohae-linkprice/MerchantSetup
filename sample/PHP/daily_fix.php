<?php
	// DataBase ����

	// LINKPRICE �� ���ؼ� ��û�� �������� QUERY
	// QUERY ����  : ��������=yyyymmdd and ���޻�=��ũ�����̽�
	// SELECT �÷� : ���Žð�, LPINFO, ������ID, �������̸�, �ֹ���ȣ, ��ǰ�ڵ�, �ֹ�����, �����ݾ�
	// ex) $sql = "select * from ��ũ�����̽�_�������̺� where ��¥ like '$yyyymmdd%' and LPINFO is not null";

	$sql = "
		select hhmiss, lpinfo, id, name, order_code, product_code, item_count, price, category_code, product_name, remote_addr
		from tlinkprice
		where yyyymmdd = '".$yyyymmdd."'
	";

	$result = mysql_query($query, $connect);
	$total = mysql_num_rows($result);

	while ($total > 0)
	{
		$row = mysql_fetch_array($result);

		$line  = $row["HHMISS"]."\t";
		$line .= $row["LPINFO"]."\t";
		$line .= $row["ID"]."(".$row["NAME"].")"."\t";
		$line .= $row["ORDER_CODE"]."\t";
		$line .= $row["PRODUCT_CODE"]."\t";
		$line .= $row["ITEM_COUNT"]."\t";
		$line .= $row["PRICE"]."\t";
		$line .= $row["CATEGORY_CODE"]."\t\t";
		$line .= $row["PRODUCT_NAME"]."\t";

		// ���� �������� ������ ���� �ƴϸ� �� �ٲ�(\n)�� �Ѵ�.
		if ($total != 1)
			$line .= $row["REMOTE_ADDR"]."\n";
		else
			$line .= $row["REMOTE_ADDR"];

		echo $line;

		$total--;
	}

	// DataBase ���� ����
?>