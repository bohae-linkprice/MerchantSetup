<?php
define(RETURN_DAYS,7);			//���� ���� �Ⱓ(��Ű ��ȿ�Ⱓ)

$lpinfo = $_REQUEST["lpinfo"];	//Affiliate ����
$url = $_REQUEST["url"];		//�̵��� ������

if ($lpinfo == "" ||  $url == "")  {
    // alert: LPMS: Parameter Error
    echo "<html><head><script type=\"text/javascript\">
	    alert('LPMS: ������ �� �����ϴ�. ����Ʈ ����ڿ��� �����Ͻñ� �ٶ��ϴ�.');
	    history.go(-1);
        </script></head></html>";
    exit;
}

Header("P3P:CP=\"NOI DEVa TAIa OUR BUS UNI\"");

if (RETURN_DAYS == 0) {
    SetCookie("LPINFO", $lpinfo, 0, "/", ".example.com");
} else {
    SetCookie("LPINFO", $lpinfo, time() + (RETURN_DAYS * 24 * 60 * 60), "/", ".example.com");
}

Header("Location: ".$url);
?>