<%
'★程序版权归作者nowayer所有★
'★使用者必须遵循 创作共用（Creative Commons）协议★
'★你可以免费: 拷贝、分发、呈现和表演当前作品,制作派生作品,但是不得移除Nowayer相关连接和标识★
'★如果您制作了派生作品,或有对程序的意见建议以及BUG，请访问官方网站★
'★Nowayerwebftp官方网站：http://www.nowayer.com★
'★Powered by Nowayerwebftp★
'★2009-2-8★
'★本文件编码：gb2312(ansi)★
dim apsw:apsw="111111"     '★登录密码，您需要修改，留空可取消登录密码★
dim url:url="config_n.asp"   '★本程序文件名，默认为index.asp,最好不要重命名本程序文件名★
dim exename
exename="bmp,jpg,gif,png,txt,rar,zip,doc,xls,css,exe,html,swf,mdb,asp,php,aspx"     '★允许上传的文件类型
if right(exename,1)<>"," then exename=exename&","
dim chk_exename
dim webftp_loginchk:webftp_loginchk=request.cookies("webftp_loginchk")
if apsw="" then webftp_loginchk="webftp_login_pass"
title="NowayerwebftpV1.2"
programname="Nowayer网页FTP程序V1.2"
programinfo="Asp网页FTP程序，对您网站内的文件和文件夹进行可视化的管理操作。"
rootpath=replace(server.mappath("/"),"\","/")
mypath=replace(server.mappath("."),"\","/")
myfullpath=mypath&replace("/"&url,"\","/")
myname = replace(myfullpath,mypath&"/","")
dim act:act=request.querystring("act")
fileurl =request("fileurl")
if fileurl="" then fileurl=mypath
fileurl=replace(fileurl,"\","/")
editurl=request("editurl")
editurl=replace(editurl,"\","/")
dim fso:Set fso = Server.CreateObject("Scripting.FileSystemObject")
dim upfile:upfile=Request("upfile")
dim uploadfilename:uploadfilename=Request("uploadfilename"):uploadfilename=Replace(uploadfilename,"\","")
dim uploadpath:uploadpath=Request("uploadpath")
dim editcharset:editcharset="utf-8"
QUERY_STRING=Request.ServerVariables("QUERY_STRING")

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="<%=programinfo%>"/>
<style>
body{font-size:13px;font-family:Georgia,Courier New,宋体;margin:10px;padding:0;}
div{padding:3px;margin:0;}
p{padding:2px;margin:0;}
form{padding:0;margin:0;}
a{  
text-decoration:none;
color:#000;
}
img{border:0;}
#juice{color:#ff6600;}
#menu{
width:800px;
height:30px;
}
#msg{
height:20px;
padding:20px;
margin:5px;
margin-left:20%;
margin-right:20%;
border:1px solid #FF6600;
color:#FF6600;
font-size:16px;
font-weight:bold;
}
#folders{}
#folders li{
float:left;
text-align:center;
width:155px;
height:70px;
list-style:none;
list-style-position: outside;
}
#files{clear:both;width:900px;margin:0;padding:0}
#files #img{
float:left;
width:24px;
}
#files #name{
float:left;
width:300px;
padding-top:8px;
}
#files #caozuo{
padding-top:8px;
float:left;
width:230px;
}
#files #size{
float:left;
width:80px;
}
#files #date{
float:left;
width:200px;
}
#text{
border:1px #666 solid;
color:#000;
}
#btn{
border:1px #666 solid;
background:#eee;
height:22px;
padding:3px;
color:#666;
}
#title{text-align:center;padding:5px;font-size:16px;font-weight:bold;}
#title a{color:#ff6600;}
#copy{text-align:center;padding-top:15px;clear:both;}
#copy a{color:#ff6600;}
</style>
<title><%=title%> - <%=programinfo%></title>
</head>
<body>
<div id=title><a title='<%=programname%>&#10<%=programinfo%>' target=_blank href='http://www.nowayer.com'><%=programname%></a></div>
<%
if act="logincheck" then logincheck()
if webftp_loginchk<>"webftp_login_pass" then login():response.end

exitmenu="":if apsw<>"" then exitmenu="<a href='?Act=loginexit'>退出登陆</a>"
%>
<div id=menu>
<a href='<%=url%>?fileurl=<%=server.urlencode(rootpath)%>&show=show'>站点跟目录</a>&nbsp;&nbsp;
<a href='<%=url%>?fileurl=<%=server.urlencode(mypath)%>&show=show'>本程序目录</a>&nbsp;&nbsp;
<a href='<%=url%>?act=addfolder&fileurl=<%=server.urlencode(fileurl)%>'>新建目录</a>&nbsp;&nbsp;
<a href='<%=url%>?act=addfile&fileurl=<%=server.urlencode(fileurl)%>'>新建文件</a>&nbsp;&nbsp;
<a href='<%=url%>?act=upload&fileurl=<%=server.urlencode(fileurl)%>'>上传文件</a>&nbsp;&nbsp;
<a href="javascript:onclick=history.back()">BACK</a>&nbsp;&nbsp;
<%=exitmenu%>
</div>
<form method=post name=index action="<%=url%>?show=show">
<p align=center>路径:<input type="text" id=text name=fileurl size=50 value='<%=fileurl%>'>
&nbsp;<input type="submit" id=btn value="跳转" >&nbsp;&nbsp;
</p>
</form>
<%
if QUERY_STRING="" then showfile()
if act="loginexit" then loginexit()
if request("show")<>"" then showfile()
if act="editfile" then editfile()
if act="save" then savefile()
if act="addfile" then addfile()
if request.querystring("movefile1")<>"" then movefile1()
if act="movefile" then call movefile():backurl(1)
if request.querystring("copyfile1")<>"" then copyfile1()
if act="copyfile" then call copyfile():backurl(1)
if request.querystring("delfile")<>"" then deletefile(request.querystring("delfile")):backurl(1)
if act="addfolder" then addfolder()
if act="saveaddfolder" then saveaddfolder():backurl(1)
if request.querystring("delfolder")<>"" then deletefolder(request.querystring("delfolder")):backurl(1)
if request.querystring("movefolder1")<>"" then movefolder1()
if act="movefolder" then call movefolder():backurl(1)
if request.querystring("copyfolder1")<>"" then copyfolder1()
if act="copyfolder" then call copyfolder():backurl(1)
if request.querystring("downurl")<>"" then call DownFile(fileurl&"/"&request.querystring("downurl"),request.querystring("downurl")):backurl(1)
if act="upload" then upload()
if act="saveupload" then call Saveupload(uploadpath,uploadfilename)


'*********************************
function login()
%>
<form name='frm' method='post' action='<%=url%>?act=logincheck'>
<p align=center>请输入登陆密码：<br><input name=psw value='' type=text size=20> 
<input type="submit" name="button" id="button" value="登陆"/></p>
</form>
<%
end function

function logincheck()
psw=request.form("psw")
if psw=apsw then
response.cookies("webftp_loginchk")="webftp_login_pass"
response.cookies("webftp_loginchk").expires=date+1
response.write"<div id=msg>登陆成功！</div>"
call gourl(url&"?show=show",1)
else
response.write"<div id=msg>密码错误！</div>"
call backurl(1)
end if
end function

function loginexit()
response.cookies("webftp_loginchk")=""
response.cookies("webftp_loginchk").expires=date+1
response.write"<div id=msg>退出登陆成功！</div>"
call gourl(url&"?act=login",1)
end function


'******************************
function showfile()
	if not Fso.folderExists(fileurl) then response.write"<div id=msg>路径错误</div>":response.end
%>
<div id=folders>
	<%
	Dim Root,F,Ext,Extarr,Extimg
	Set Root = Fso.GetFolder(fileurl)
			For Each F In Root.SubFolders
urls=server.urlencode(fileurl&"/"&f.name)
				Response.write "<li><a title='文件夹名："&f.name&"' href='"&url&"?show=show&fileurl="&urls&"'><img src=images/folder.gif><br>" & left(F.Name,10) & "</a><br>"
chk1=fileurl&"/"&F.Name
urls=server.urlencode(fileurl&"/"&f.name)&"&fileurl="&server.urlencode(fileurl)
if chk1<>mypath and chk1<>mypath&"/images" then
%>
<a title='文件夹名：<%=f.name%>&#10删除文件夹' onclick="if(confirm('确定删除吗?')){location.href='<%=url%>?delfolder=<%=urls%>';}">删除</a>&nbsp;
<a title='文件夹名：<%=f.name%>&#10移动或重命名文件夹' href="<%=url%>?movefolder1=<%=urls%>">move</a>&nbsp;
<a title='文件夹名：<%=f.name%>&#10拷贝复制文件夹' href="<%=url%>?copyfolder1=<%=urls%>">copy</a>&nbsp;
<%
else
response.write"★本程序目录★"
end if
Response.write "</li>"
			Next
			response.write"</div>"
			shu=0
			For Each F In Root.files
shu=shu+1
if shu=1 then response.write"<b><div id=files><div id=img></div><div id=name>文件名</div><div id=caozuo>管理操作</div><div id=size>大小</div><div id=date>最后修改日期</div></div></b>"
				Extarr = Split(F.Name,".")
				Ext = LCase(Extarr(Ubound(Extarr)))
				downurl=fileurl&"/"&f.name
				downurl=replace(downurl,rootpath,"")
	DateLastModified = f.DateLastModified 
		DateCreated = f.DateCreated 
				if Instr("/png/jsp/asa/bat/rm/mp3/pdf/wma/rmvb/asp/aspx/html/htm/shtm/shtml/php/css/js/txt/gif/jpeg/jpg/bmp/swf/mdb/doc/xls/rar/zip/exe/xml/xsl/vbs/ini/","/" & Ext & "/") > 0 Then Extimg = Ext Else Extimg = "file"
				%>
<div id=files>
<div id=img><img src=images/<%=Extimg%>.gif></div>
<div id=name><a target=_blank title='访问:<%=F.Name%>' href="<%=downurl%>"><%=F.Name%></a></div>
<div id=caozuo>
<%
size=F.Size
size=round(size/1024,1)&"K"
if left(size,1)="." then size=0&size
lastdate=f.DateLastModified
Createdate=f.DateCreated
ftype=Extimg
if ftype="file" then ftype="未知"
if fileurl&"/"&f.name<>myfullpath  then
%>
<a  href='<%=url%>?fileurl=<%=server.urlencode(fileurl)%>&editurl=/<%=server.urlencode(f.name)%>&act=editfile'>edit</a>&nbsp;
<%
delfile2=url&"?delfile="&server.urlencode(fileurl&"/"&f.name)&"&fileurl="&fileurl
delfile2=replace(delfile2,"\","/")
%>
<a onclick="if(confirm('确定删除吗?')){location.href='<%=delfile2%>';}" >删除</a>&nbsp;
<a title='移动或重命名文件' href="<%=url%>?movefile1=<%=server.urlencode(fileurl&"/"&f.name)%>&fileurl=<%=fileurl%>">move</a>&nbsp;
<a href="<%=url%>?fileurl=<%=server.urlencode(fileurl)%>&copyfile1=<%=server.urlencode(fileurl&"/"&f.name)%>">copy</a>&nbsp;
<a title='下载' href="<%=url%>?fileurl=<%=server.urlencode(fileurl)%>&downurl=<%=F.Name%>">下载</a>
<%
else
response.write" ★本程序文件★"
end if
%>
</div>
<div id=size><%=size%></div>
<div id=date><%=lastdate%></div>
</div>
<%
Next
set Root = nothing
end function


'****************************************
Sub Upload()
%>
<script language="JavaScript">
function getSaveName()
{
	var filepath=document.frm.upfile.value;
	if(filepath.length<1) return;
	var uploadfilename=filepath.substring(filepath.lastIndexOf("\\")+1,filepath.length);
uploadfilename=uploadfilename.substring(uploadfilename.lastIndexOf("//")+1,uploadfilename.length);
	document.frm.uploadfilename.value=uploadfilename;
}
</script>
<form name="frm" method="post" action="<%=url%>?act=saveupload" enctype="multipart/form-data">
<div>选择上传文件：<input type="file" name="upfile" size="35" onchange="getSaveName();" value='<%=upfile%>'></div>
<div>上传路径：<input type="text" name="uploadpath" size="55" value="<%=fileurl%>"></div>
<div>上传文件名：<input type="text" name="uploadfilename" size="35" value='<%=uploadfilename%>'></div>
<div><input type="submit" name="submit" value="上传" onclick="this.form.action+='&uploadfilename='+escape(this.form.uploadfilename.value)+'&uploadpath='+uploadpath.value">
</td>
</tr>
</table>
</form>
</body>
</html>
<%
End Sub

Sub Saveupload(ByVal uploadpath,ByVal uploadfilename)
on error resume next
	If Right(uploadpath,1)<>"/" Then uploadpath=uploadpath&"/"
exename2=getfiletype(uploadfilename)
list=split(exename,",")
shu=ubound(list)
for i=0 to shu-1
if list(i)=exename2 then 
chk_exename="yes"
exit for
end if
next
if chk_exename<>"yes" then 
		response.write "<div id=msg>不允许上传此类型文件！</div>"
		Exit Sub
end if
	If Len(uploadfilename)<1 Then
		response.write "<div id=msg>请选择文件并输入文件名！</div>"
		Exit Sub
	End If
	uploadpath=uploadpath&uploadfilename
	if Fso.FileExists(uploadpath) then 
	response.write"<div id=msg>文件已经存在！</div>"
	response.write "<meta http-equiv='refresh' content=""2; url=javascript:history.back()"">"
	else
	Call MyUpload(uploadpath)
	If Err Then
		response.write"<div id=msg>文件上传失败！</div>"
	Else
		response.write "<div id=msg>文件上传成功!</div>"
	End If
	backurl(1)
	end if
End Sub

Sub MyUpload(FilePath)
	Dim oStream,tStream,uploadfilename,sData,sSpace,sInfo,iSpaceEnd,iInfoStart,iInfoEnd,iFileStart,iFileEnd,iFileSize,RequestSize,bCrLf
	RequestSize=Request.TotalBytes
	If RequestSize<1 Then Exit Sub
	Set oStream=Server.CreateObject("ADODB.Stream")
	Set tStream=Server.CreateObject("ADODB.Stream")
	With oStream
		.Type=1
		.Mode=3
		.Open
		.Write=Request.BinaryRead(RequestSize)
		.Position=0
		sData=.Read
		bCrLf=ChrB(13)&ChrB(10)
		iSpaceEnd=InStrB(sData,bCrLf)-1
		sSpace=LeftB(sData,iSpaceEnd)
		iInfoStart=iSpaceEnd+3
		iInfoEnd=InStrB(iInfoStart,sData,bCrLf&bCrLf)-1
		iFileStart=iInfoEnd+5
		iFileEnd=InStrB(iFileStart,sData,sSpace)-3
		sData=""
		iFileSize=iFileEnd-iFileStart+1
		tStream.Type=1
		tStream.Mode=3
		tStream.Open
		.Position=iFileStart-1
		.CopyTo tStream,iFileSize
			tStream.SaveToFile FilePath,2
		tStream.Close
		.Close
	End With
	Set tStream=Nothing
	Set oStream=Nothing
End Sub

function getfiletype(name)
str=name
if right(str,1)<>"." then str=str&"."
str2=split(str,".")
shu=ubound(str2)
if shu<=1 then 
getfiletype="未知文件"
else
getfiletype=str2(shu-1)
end if
end function

'*************************************
Function editfile()
on error resume next
editurl=request.querystring("editurl")
source=server.HtmlEncode(LoadFromFile(fileurl&editurl))
cset=session("cset")
%>
<form name='frm' method='post' action='<%=url%>?act=save&fileurl=<%=fileurl%>'>
<p><input name=saveurl value='<%=fileurl&editurl%>' type=text size=70>
编码：<select name=bianma><option value='gb2312' <%if cset="gb2312" then response.write"selected"%>>gb2312</option>
<option value='utf-8' <%if cset="utf-8" then response.write"selected"%>>utf-8</option>
<option value='unicode' <%if cset="unicode" then response.write"selected"%>>unicode</option>
</select></p>
<p><textarea name="content" style="width:90%;height:400px;"><%=source%></textarea></p>
<p><input type="submit" name="button" id="button" value="保存文件"/> &nbsp;
*如果出现乱码，请不要修改和保存此文件，可能文件编码无法被自动识别！</p>
</form>
<%
end Function

Function addFile()
session("fileurl")=fileurl
%>
<p>新建文件到：</p>
<form name='frm' method='post' action='<%=url%>?act=save&fileurl=<%=fileurl%>'>
<input name=saveurl value='<%=fileurl%>/new.txt' type=text size=70> &nbsp;&nbsp;
选择保存编码：<select name=bianma><option value='gb2312' <%if cset="gb2312" then response.write"selected"%>>gb2312</option>
<option value='utf-8' <%if cset="utf-8" then response.write"selected"%>>utf-8</option>
<option value='unicode' <%if cset="unicode" then response.write"selected"%>>unicode</option>
</select>
<p><textarea name="content" style="width:90%;height:400px;"></textarea></p>
<p><input type="submit" name="button" id="button" value="保存文件"/></p>
</form>
<%
End Function

Function saveFile()
saveurl=request.form("saveurl")
content=request.form("content")
bianma=request.form("bianma")
call savetofile(content,saveurl,bianma)
response.write "<div id=msg>编码："&bianma&"<br>文件保存成功！</div>"
backurl(1)
End Function

function movefile1()
%>
<p>移动文件到：</p>
<form name='movefilefrm' method=post action='<%=url%>?fileurl=<%=fileurl%>&act=movefile'>
<p><input name=path1 type=hidden value='<%=request("movefile1")%>' type=text size=70></p>
<p><input name=path2 value='<%=request("movefile1")%>' type=text size=70></p>
<p><input type="submit"  value="move"/></p>
</form>
<%
end function 

function copyfile1()
%>
<p>复制文件到：</p>
<form name='copyfilefrm' method=post action='<%=url%>?fileurl=<%=fileurl%>&act=copyfile'>
<p><input name=path1 type=hidden value='<%=request("copyfile1")%>' type=text size=70></p>
<p><input name=path2 value='<%=request("copyfile1")%>' type=text size=70></p>
<p><input type="submit"  value="copy"/></p>
</form>
<%
end function 

function deletefile(byval dirpath)
Set fso = Server.CreateObject("Scripting.FileSystemObject")
if not fso.fileexists(dirpath) then 
response.write "<div id=msg>文件不存在！</div>"
else
fso.deletefile dirpath
response.write "<div id=msg>文件删除成功！</div>"
end if
set fso=nothing
end function

Function CopyFile()
path1=request.form("path1")
path2=request.form("path2")
if fso.fileexists(path1) and path2<>""  then 
fso.copyFile Path1,Path2
response.write "<div id=msg>文件copy成功！</div>"
end if
set fso=nothing
End Function
  
Function moveFile()
path1=request.form("path1")
path2=request.form("path2")
if fso.fileexists(path1) and path2<>""  then 
fso.moveFile Path1,Path2
response.write "<div id=msg>文件移动成功！</div>"
end if
set fso=nothing
End Function

Function DownFile(Path,name)
Response.Clear
Set OSM = Server.CreateObject("ADODB.Stream")
OSM.Open
OSM.Type = 1
OSM.LoadFromFile Path
sz=InstrRev(path,"\")+1
Response.AddHeader "Content-Disposition", "attachment; filename=" & name
Response.AddHeader "Content-Length", OSM.Size
Response.Charset = "utf-8"
Response.ContentType = "application/octet-stream"
Response.BinaryWrite OSM.Read
Response.Flush
OSM.Close
Set OSM = Nothing
End Function


'********************************
Function addfolder()
%>
<p>新建文件夹到：</p>
<form name='frm' method='post' action='<%=url%>?act=saveaddfolder&fileurl=<%=fileurl%>'>
<input name=folderpath value='<%=fileurl%>/new' type=text size=70>
<p><input type="submit" name="button" id="button" value="保存"/></p>
</form>
<%
End Function

function movefolder1()
%>
<p>移动文件夹到：</p>
<form name='movefolderfrm' method=post action='<%=url%>?fileurl=<%=fileurl%>&act=movefolder'>
<p><input name=path1 type=hidden value='<%=request("movefolder1")%>' type=text size=70></p>
<p><input name=path2 value='<%=request("movefolder1")%>' type=text size=70></p>
<p><input type="submit"  value="copy"/></p>
</form>
<%
end function 

function copyfolder1()
%>
<p>复制文件夹到：</p>
<form name='copyfolderfrm' method=post action='<%=url%>?fileurl=<%=fileurl%>&act=copyfolder'>
<p><input name=path1 type=hidden value='<%=request("copyfolder1")%>' type=text size=70></p>
<p><input name=path2 value='<%=request("copyfolder1")%>' type=text size=70></p>
<p><input type="submit"  value="copy"/></p>
</form>
<%
end function

Function saveaddfolder()
folderpath=request.form("folderpath")
createfolder(folderpath)
End Function

function createfolder(byval dirpath)
Set fso = Server.CreateObject("Scripting.FileSystemObject")
if not fso.folderexists(dirpath) then 
fso.createfolder dirpath
response.write "<div id=msg>文件夹新建成功！</div>"
else
response.write "<div id=msg>文件夹已经存在！</div>"
end if
set fso=nothing
end function

function deletefolder(byval dirpath)
Set fso = Server.CreateObject("Scripting.FileSystemObject")
if not fso.folderexists(dirpath) then 
response.write "<div id=msg>文件夹不存在！</div>"
else
fso.deletefolder dirpath
response.write "<div id=msg>文件夹删除成功！</div>"
end if
set fso=nothing
end function

Function Copyfolder()
path1=request.form("path1")
path2=request.form("path2")
if fso.folderexists(path1) and path2<>""  then 
fso.copyfolder Path1,Path2
response.write "<div id=msg>文件夹copy成功！</div>"
end if
set fso=nothing
End Function
  
Function movefolder()
path1=request.form("path1")
path2=request.form("path2")
if fso.folderexists(path1) and path2<>""  then 
fso.movefolder Path1,Path2
response.write "<div id=msg>文件夹移动成功！</div>"
end if
set fso=nothing
End Function


'************************************
Function LoadfromFile(File)
    Dim objStream
    dim a1,b1,c1,a2,b2,c2,cset
    Dim RText
    RText = Array(0, "")
    Set objStream = Server.CreateObject("ADODB.Stream")
    With objStream
        .Type = 2
        .Mode = 3
        .Open
         .charset = "unicode"
        .Position = objStream.Size
        .LoadfromFile File
        RTexta = Array(0, .ReadText)
        a2=len(RTexta(1))
        a1=objStream.Size
        .Close
    End With
     With objStream
        .Type = 2
        .Mode = 3
        .Open
        .Position = objStream.Size
        .charset = "utf-8"
        .LoadfromFile file
        RTextb = Array(0, .ReadText)
        b2=len(RTextb(1))
        b1=objStream.Size
        .Close
    End With
    With objStream
        .Type = 2
        .Mode = 3
        .Open
        .Position = objStream.Size
        .charset = "gb2312"
        .LoadfromFile file
        RTextc = Array(0, .ReadText)
        c2=len(RTextc(1))
        c1=objStream.Size
        .Close
    End With
if b1<a1 then 
if b1<c1 then csettext=RTextb:cset="utf-8"
if b1<=c1 then 
if b2<c2 then csettext=RTextb:cset="utf-8"
end if
end if
if a1<b1 then 
if a1<c1 then csettext=RTexta:cset="unicode"
if a1<=c1 then 
if a2<c2 then csettext=RTexta:cset="unicode"
end if
end if
if c1<a1 then 
if c1<b1 then csettext=RTextc:cset="gb2312"
if c1<=b1 then 
if c2<b2 then csettext=RTextc:cset="gb2312"
end if
end if
session("cset")=cset
    LoadfromFile = csettext(1)
    Set objStream = Nothing
End Function

Function SaveToFile(strBody,File,charset)
    Dim objStream
    Dim RText
    RText = Array(0, "")
    Set objStream = Server.CreateObject("ADODB.Stream")
    With objStream
        .Type = 2
        .Open
        .Charset = charset
        .Position = objStream.Size
        .WriteText = strBody
        On Error Resume Next
        .SaveToFile File, 2
        If Err Then
            RText = Array(Err.Number, Err.Description)
            SaveToFile = RText
            Err.Clear
            Exit Function
        End If
        .Close
    End With
    RText = Array(0, "保存文件成功!")
    SaveToFile = RText
    Set objStream = Nothing
End Function

'******************************************
function gofileurl(byval str)
response.write "<meta http-equiv='refresh' content="""&str&"; url="&url&"?fileurl="&server.urlencode(fileurl)&"&show=show"">"
end function

function backurl(byval str)
response.write "<meta http-equiv='refresh' content="""&str&";url="&url&"?fileurl="&server.urlencode(fileurl)&"&show=show"">"
end function

function gourl(byval url,byval str)
response.write "<meta http-equiv='refresh' content="""&str&"; url="&url&""">"
end function

	%>
<div id=copy> 
<p>Copyright ? 2008-2009 www.Nowayer.Com All Rights Reserved.</p>
<p>Powered by <a title='<%=title%>&#10<%=programinfo%>' target=_blank href='http://www.nowayer.com'><%=title%></a></p>
</div>
</body>
</html>
<%
'★程序版权归作者nowayer所有★
'★使用者必须遵循 创作共用（Creative Commons）协议★
'★你可以免费: 拷贝、分发、呈现和表演当前作品,制作派生作品,但是不得移除Nowayer相关连接和标识★
'★如果您制作了派生作品,或有对程序的意见建议以及BUG，请访问官方网站★
'★Nowayerwebftp官方网站：http://www.nowayer.com★
'★Powered by Nowayerwebftp★
'★2009-2-8★
%>
<!-----by nowayer----->
<!-----★末路客部落★www.nowayer.com----->