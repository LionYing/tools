<?php
date_default_timezone_set("PRC");
$data = addslashes(trim($_POST['what']));
$data = mb_substr(str_replace(array('˵��ʲô�ɡ�'),array(''),$data),0,82,'gb2312');
if (!empty($data))
{
$data = str_replace(array('http://',';','<','>','?','"','(',')','POST','GET','_','/'),array('','&#59;','&lt;','&gt;','&#63;','&#34;','|','|','P0ST','G&#69;T','&#95;','&#47;'),$data);
$ip = preg_replace('/((?:\d+\.){3})\d+/','\\1*',$_SERVER['REMOTE_ADDR']);
$time = date("Y-m-d G:i:s A");
$text = "<div>".$data."<p>IPΪ".$ip."�Ļ��� >>> F4cked At:".$time."</p></div>";
$file = fopen(__FILE__,'a');
fwrite($file,$text);
fclose($file);
echo "<script>location.replace(location.href);</script>";
}
?><head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>F4ckTeam Chating Room</title>
<style type="text/css">
body{font-size:10pt}
html{background:#f7f7f7;}
pre{line-height:120%;}
p{font-size:10pt;font-family:Lucida Handwriting,Times New Roman;}
.tx{font-family:Lucida Handwriting,Times New Roman;}
.left{height:500;width:45%;float:left;text-align:center;margin:3%}
.right{text-align:left;height:500;width:45%;float:left;margin:1%;overflow:auto;border: 1px inset #CCCCCC;}
#head {
	font-family: "Courier New", Courier, monospace;
}
</style>
</head>
<center>
<h1>ͨ�����԰�</h1></center>
<hr width="95%">
<div class="left">
<strong>��ϲ���ѳɹ�ͨ��~</strong><br /><br />
<div style="text-align:left;margin:7px" id="announcement">
1��ǿ�һ�ӭ��λ����������Ϸ~<br /><br />
2����Ϸͨ�ز����Ժ󣬽�ͨ����ϸ������doc��ʽ�ʼ����͵�fan#f4ck.net����֤��ʵ��ɻ�÷�����̳������һö~<br /><br />
3��������̳�ڿ���Ϸ�ڶ����ɺ��ĳ�Ա[����������ϧ]����~<br /><br />
</div>
<form method=post action="?">
<textarea rows="5" id="what" cols="80" name="what" style="border-style:solid;border-width:1" onfocus="if(value=='˵��ʲô�ɡ�') {value=''}" onblur="if(value=='') {value='˵��ʲô�ɡ�'}">˵��ʲô�ɡ�</textarea><br /><br />
<input type="submit" value="�������" tilte="�ύ" style="width:120px;height:35px;border:1px;solid:#666666;font-size:9pt;BACKGROUND-COLOR:#E8E8FF;color:#666666"></form>
<div class="tx">HackGame V2.0 - Code By ����������ϧ@F4ckTeam</div>
</div>
<div class="right">