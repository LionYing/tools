<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>广州治水信息平台</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="../webstyle/css/global.css">
	<link rel="stylesheet" type="text/css" href="../webstyle/css/Elebul_boards.css">
	<link rel="stylesheet" type="text/css" href="../webstyle/css/index.css">
	<link rel="stylesheet" type="text/css" href="../webstyle/css/public.css">
	<script type="text/javascript" src="../js/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="../webstyle/js/log.js"></script>

	<script type="text/javascript">
	/*	$(window).load(function(){
		// 将你希望在页面完全就绪之后运行的代码放在这里
		alert("hello");
		});
		$(window).load(function(){
				//自动创建一个遮罩层
				$("<div>").attr({"style":"display:block;width:100%;height:100%;background:#000;opacity:1;position:fixed;top:0;z-index:10;opacity:0.1;","id":"maskded"}).appendTo($('body'));
					//获取登陆框的宽度
					 var log = $('.log_EveryDayQA');
					 var m_wd=log.width();
				
					 //获取整个页面的宽度
					 var m_doc=$(document).width();
					 var m_cn=Math.floor((m_doc-m_wd)/2);
					 log.css({"position":"absolute","left":m_cn,"top":"128px",'z-index':100})
					 $('#maskded').after(log);
					 log.show();
			})*/
		$("document").ready(function(){	
			//验证码
			$("#Verify").click(function(){
	      		$(this).attr("src","../common/getvalicode.htm?timestamp="+new Date().getTime());//加上时间说明每次提交的请求不一样，如果不加，验证码只能刷新一次	      		
	        });
			$("#retrievepassword").click(function(){
				$("#form1").attr("action","../common/retrievepassword.htm");
				$("#form1").submit();					
			});
			$(".regist").click(function(){
				alert("目前只支持在手机端进行注册，请在首页扫描二维码下载、安装广州治水App后进行注册!")
			});
			$('.log_close').click(function(){
				$('.log_form').hide();
				$('.log_EveryDayQA').hide();
				$('#maskded').remove();
				return false;
			})	
			$("#close").click(function(){
				$("#float_icon").hide();
			})
			
		});
		$(document).keyup(function(event){
			  if(event.keyCode ==13){
				  btnLogin();
			  }
		});
		//登录
		function btnLogin(){				
			var mobilephone = $('#mobilephone').val();				
			var password = $('#password').val();				
			var txtValicode=$('#txtValicode').val();
			if(mobilephone=="" || password==""){
				alert("用户名和密码不能为空!");
				return false;
			}				
			else if(txtValicode==""){
				alert("验证码不能为空");
				return false;
			}
			else {
				$("#form1").attr("action","../common/login.htm");
				$("#form1").submit();
			}
		}
		//退出
		function btn_logout(){
			window.location.href="../common/logout.htm";
		}
	</script>		
</head>
<body style="padding-bottom: 0px;">
<form action="" name="form" id="form" method="post">
	<!-- 头部 -->
	 <div class="hz_2015">
		<div class="w">
			<div class="hl">
				<!--<span><a href="#" target="_blank" title="网站导航">网站导航</a></span>
				<span class="spacer"></span>
				<span><a href="#" target="_blank" title="移动版">移动版</a></span>-->
				<s:if test="currentUser==null">
					<span><a href="javascript:void(0)" class="u_login">登录</a></span>
					<span class="spacer"></span>
					<span><a href="javascript:void(0)" class="regist">注册</a></span>
				</s:if>
				<s:else>
					<span><s:property value="currentUser.username"/></span>
					<!--<s:if test="currentUser.authority==2">您有<s:property value="compnum"/>条投诉未处理</s:if>-->
					<span class="spacer"></span>
					<span><a href="javascript:void(0)" class="btn_logout" onclick="btn_logout()">退出</a></span>
				</s:else>				
			</div>						
		</div>	
	</div>
	
	<div class="nav_2015">
		<div class="w">
			<div class="nl">
				<img src="../webstyle/images/log-gz.jpg">
			</div>
			<div class="nr">
				<ul>
					<li class="ifo0 sel_ifo0"><a href="../homepage/home.htm">首页</a></li>
					<s:iterator value="menuList" status="row">
						<li class="ifo<s:property value='#row.count'/>">
						<a href="../systemmanage/goCustomerDashBord.htm?id=<s:property value='id'/>"><s:property value='title'/></a></li>
					</s:iterator>
				</ul>
			</div>
		</div>
		<span class="cl_up"></span>
	</div>
	<!-- 内容区 -->
	<div class="show_2015">
		<img src="../webstyle/images/bannergz.jpg">
	</div>
	
	<div class="content">
		<div class="w clearfix">
			<div class="col">
			<!-- 河长职责 -->
			<div class="sug  clearfix" style="border:none;padding:0;margin-bottom:18px;">
				 <div class="sg_name">
					<img src="../webstyle/images/P109_gz.png" alt="河长图片" title="河长的图片">
				</div>
				<div class="sg_ct">
					<h2>河长职责</h2>
					<p style="font-size: 14px;"><s:property value="RiverChiefIntroduction.content" escape="false"/>						
					</p>
				</div>
				<i class="sg_ico">&nbsp;</i>
			</div>
			<!-- 河长职责 -->
				<div class="sug1">
					<h2 style="padding-top: 8px;padding-bottom: 8px;">网站简介</h2>
					<hr style="height:1px;border:none;border-top:1px dashed #0066CC;" />
					<div class="c_instr clearfix">
						<div class="c_img">
							<img src="../webstyle/images/c_img1_gz.png">
						</div>
						<div class="c_dec">						
							<div class="n_con"style="font-size:15px;">								
								<p style="line-height:30px;color: #666;width: 400px;"><s:property value="WebIntroduction.content" escape="false"/></p>
							</div>						
						</div>
					</div>
				</div>

				<div class="sug1" style="margin-top:25px;"> 
					<h2 style="padding-top: 8px;padding-bottom: 8px;">新闻动态&nbsp;
					<a href="../homepage/homenewslist.htm?news.type=1" >/更多</a></h2>
					<hr style="height:1px;border:none;border-top:1px dashed #0066CC;" />
					<div class="c_instr clearfix">
						<div class="c_img">
							<img src="../webstyle/images/c_img2_gz.png">
						</div>
						<div class="c_dec" style="width: 395px;">					
							<s:iterator value="ListNews" status="row">
							<div class="n_title" style="font-size:14px;color: #666; white-space: nowrap;text-overflow:ellipsis;line-height:30px;overflow:hidden;">
								<span>								
								<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
								 <img src="../webstyle/images/new_ico.jpg">&nbsp;
								 <s:if test="top.top==1"><label style="color:#00A9EC;">[置顶]</label></s:if>					 
								 <s:if test="creator_user.authority==3">[<s:property value="creator_user.position"/>]</s:if>
								 <s:if test="creator_user.authority==5">[广州市]</s:if>
								 <s:property value="theme"/>
								</a></span>
							</div>
							</s:iterator>						
					   </div>
				   </div>
			</div>
		</div>	
	<div class="cor" style="width:290px">
		<div class="message">
			<div class="met ct1" style="font-size: 18px;">
				广州治水APP
			</div>			
		<div class="mec">
		<br>
			<ul>	
				<li style="font-size: 15px;color: #666;"><i></i>河流（涌）信息公开</li>
				<li style="font-size: 15px;color: #666;"><i></i>河流（涌）监测数据</li>								
				<li style="font-size: 15px;color: #666;"><i></i>河流（涌）污染投诉建议</li>
				<li style="font-size: 15px;color: #666;"><i></i>水务动态</li>  
			</ul>
				<br>
			<div class="mec tc">
				<a href="../download/downloadweb.jsp" ><img src="../webstyle/images/iphone_ico.png"></a>
				<a href="../download/downloadweb.jsp" ><img src="../webstyle/images/andorid_ico_gz.png"></a>
			</div>
			<div class="me_log">&nbsp;</div><br>
		</div>
		<div class="message">
			<div class="met">
				<h2>最新公告</h2>
				<a href="../homepage/homenewslist.htm?news.type=2">/更多</a>							
			</div>			
				<s:iterator value="ListNotice" status="row">
					<div style="font-size:14px;padding-left: 15px;color:#666; white-space: nowrap;text-overflow:ellipsis;line-height:30px;overflow:hidden;">					
					<span>
						<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
						<img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;		
						<s:if test="top.top==1"><label style="color:#00A9EC;">[置顶]</label></s:if>		
						<s:if test="creator_user.authority==3">[<s:property value="creator_user.position"/>]</s:if>
						<s:if test="creator_user.authority==7">[<s:property value="creator_user.realname"/>]</s:if>
						<s:if test="creator_user.authority==5">[广州市]</s:if>
						<s:property value="theme"/>
						</a>
					</span>
					</div>
				</s:iterator>				
		</div>
			<div class="me_log">&nbsp;</div>
			
			<div class="met">
				<h2>文件下载</h2>
				<a href="../homepage/homenewslist.htm?news.type=3">/更多</a>				
			</div> 					
			
			<div class="mec">
					<s:iterator value="ListAttachload" status="row">
					<div style="font-size:14px;padding-left: 15px;color:#666; white-space: nowrap;text-overflow:ellipsis;line-height:30px;overflow:hidden;">					
					<span>
						<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
						<img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;						
						<s:if test="top.top==1"><span style="color:#00A9EC;">[置顶]</span></s:if>
						<s:if test="creator_user.authority==3">[<s:property value="creator_user.position"/>]</s:if>
						<s:if test="creator_user.authority==5">[广州市]</s:if>						
						<s:property value="theme"/>
						</a>
					</span>
					</div>
				</s:iterator>	
			</div>
			<div class="met">
				<h2>水务前沿</h2>
				<a href="../homepage/homenewslist.htm?news.type=7">/更多</a>				
			</div> 					
			
			<div class="mec">
			
			<div class="infor_tab">
					<div class="tab_t clearfix">
						<span class="tab1 add_green">前沿动态</span>
						<span class="tab2">政策法规</span>
						<span class="tab3">水务专项</span>
					</div>
					<ul class="tab_cont"style="padding-left: 0px">
						<li>
							<s:iterator value="listqydt" status="row">
								<div style="font-size:14px;padding-left: 15px;color:#666; white-space: nowrap;text-overflow:ellipsis;line-height:30px;overflow:hidden;">													
									<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
									<img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;						
									<s:if test="top.top==1"><label style="color:#00a9ec;">[置顶]</label></s:if>
									<s:if test="newstype==1">[顶级水务专家]</s:if>
									<s:if test="newstype==2">[前沿技术工艺]</s:if>
									<s:if test="newstype==3">[成熟应用实例]</s:if>
									<s:if test="newstype==4">[先进示范城市]</s:if>
									<s:if test="newstype==5">[政策法规标准]</s:if>
									<s:if test="newstype==6">[技术推广名录]</s:if>						
									<s:property value="theme"/>
									</a>							
								</div>
							</s:iterator>	
						</li>
						<li style="display:none;">
							<s:iterator value="listzcfg" status="row">
								<div style="font-size:14px;padding-left: 15px;color:#666; white-space: nowrap;text-overflow:ellipsis;line-height:30px;overflow:hidden;">													
									<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
									<img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;						
									<s:if test="top.top==1"><label style="color:#00a9ec;">[置顶]</label></s:if>
									<s:if test="newstype==1">[政策]</s:if>		
									<s:if test="newstype==2">[法规]</s:if>	
									<s:if test="newstype==3">[标准]</s:if>				
									<s:property value="theme"/>
									</a>							
								</div>
							</s:iterator>	
						</li>
						<li  style="display:none;">
							<s:iterator value="listswzx" status="row">
								<div style="font-size:14px;padding-left: 15px;color:#666; white-space: nowrap;text-overflow:ellipsis;line-height:30px;overflow:hidden;">													
									<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
									<img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;						
									<s:if test="top.top==1"><label style="color:#00a9ec;">[置顶]</label></s:if>
									<s:if test="newstype==1">[黑臭水体]</s:if>						
									<s:property value="theme"/>
									</a>							
								</div>
							</s:iterator>	
						</li>						
					</ul>
				</div>
					
			</div>
			<div class="met">
				<h2>水务常识</h2>
				<a href="../homepage/homenewslist.htm?news.type=6">/更多</a>							
			</div>	
			<s:iterator value="ListEveryDayQA" status="row">							
				<div style="font-size:15px;padding-left: 15px;color:#666; line-height:30px;overflow : auto;">
					<span >
						<img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;问：
						<s:property value="theme"/>						
					</span>	
				</div>				
				<div style="font-size:15px;padding-left: 15px;color:#666; line-height:30px;overflow : auto;">
					<span>	
						 <img src="../webstyle/images/new_ico.jpg">&nbsp;&nbsp;答：&nbsp;
						<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'><s:property value="ShowPartOfEverydayQA"/></a>																
					</span>
				</div>					
			</s:iterator>		
			<div class="me_log">&nbsp;</div>
		</div>
	</div>
</div>
</div>				
<div class="tel">
		<div class="w">
			<a href="../download/downloadweb.jsp"><img src="../webstyle/images/GZ0623.png"></a>
		</div>
</div>
</form>
	<!-- 底部 -->
	<div class="foot_2015" style="position: relative;">
		<div class="w">
<%-- 			<span class="copyleft" style="padding-left: 250px;">广州市水务局 版权所有 </span> --%>
<%-- 			<span class="copyright" style="padding-right: 250px;"><a style="color:#fff;" href="mailto:waterlab@zju.edu.cn">浙江大学控制学院水质预警实验室 技术支持</a></span> --%>
<%-- 			<span class="copyleft" style="padding-left: 10px;padding-right: 30px;"> --%>
<%-- 			APP下载量<s:property value='pageview.onloadcount'/>,注册量<s:property value='pageview.registercount'/>,投诉量<s:property value='pageview.complaincount'/>, --%>
<%-- 			网站浏览量<s:property value='pageview.pageviewcount'/> 手机浏览量<s:property value='pageview.phoneviewcount'/> --%>
<%-- 			</span>			 --%>
		</div>
	</div>
	<!-- 登陆界面 -->	
	<div id="log_form" class="log_form">
			<h2>
				用户登录
				<a href="#" class="lg_close">&nbsp;</a>
			</h2>
			<div class="login">
			<form action="" name="form1" id="form1" method="post">
				<dl class="clearfix">
					<dt>手机号码：</dt>
					<!--  <dd><input id="username" type="text"  name="user.username"/><span>*</span></dd>-->
					<dd><input id="mobilephone" type="text"  name="user.mobilephone"/><span>*</span></dd>
				</dl>
				<dl class="clearfix">
					<dt>密码：</dt>
					<dd><input id="password"  type="password" name="user.password"/><span>*</span></dd>
				</dl>
				<dl class="clearfix">
					<dt>验证码：</dt>
					<dd><input type="text" id="txtValicode"	name="valicode_input"style="width: 161px;"/>	
						<img src="../common/getvalicode.htm" id="Verify" style="cursor:hand;height:30px" alt="看不清换一张"/><span>*</span>
					</dd>
				</dl>
			</form>
				<dl class="clearfix">
					<dt>&nbsp;</dt>
					<dd><a href="javascript:void(0)" class="log_sub" style="cursor:hand;" onclick="btnLogin()">登录</a>&nbsp;
						<a href="javascript:void(0)" class="log_close" style="cursor:hand;">取消</a>
						<!--  <a class="f_pwd" id="retrievepassword">忘记密码?</a>-->
					</dd>
				</dl>
				<br></br>
				<!--  <dl class="clearfix">
					<dt>&nbsp;</dt>
					<dd style="color:#b5b4b4;">还没有账户，<a href="#" class="f_pwd">立即注册</a></dd>
				</dl>-->
			</div>
	  </div>
	<!-- 水务常识 	-->
	<div id="log_EveryDayQA" class="log_EveryDayQA">
			<h2>
				水务常识
				<a href="#" class="log_EveryDayQA">&nbsp;</a>
			</h2>
			<div class="EveryDayQA">
					
					<s:iterator value="ListEveryDayQA" status="row">
						<dl>
						<dt>&nbsp;</dt>
						<dd>
							<span >
								<a href='../homepage/homenewssingle.htm?newsid=<s:property value="id"/>'>
								<s:property value="theme"/>
								</a>
							</span>	
						</dd>
						</dl>
						
						<dl>	
						<dt>&nbsp;</dt>
						<dd>		
							<span >	
								<s:property value="abstarct"/></p>																		
							</span>
						</dd>
						</dl>	
					</s:iterator>	

				<dl class="clearfix">
					<dt>&nbsp;</dt>
				<dd>
					<a href="javascript:void(0)" class="log_close" style="cursor:hand;" >不再显示</a>&nbsp;		
					<a href="javascript:void(0)" class="log_close" style="cursor:hand;">取消</a>		
				</dd>
				</dl>
				<br></br>
			</div>
	  </div>
	  
<s:if test="showForOthers==1">
<!--飘窗的hehe效果 -->
	  <div id="float_icon" style="position: absolute; z-index: 99999; top: 164px; left: 484px; visibility: visible;">
	  	<div id=close>
	  		<img src="../resource/image/close.gif"/>
	  	</div>
		   <a href="<s:property value='flaotIconUrl'/>" target="_blank">
		   		<img src="<s:property value='flaotIcon'/>" height="150" width="150">
		   </a> 
	  </div> 
	   
	<script type="text/javascript">
		var dirX =1,dirY =1;var posX =0,posY =0;
		document.getElementById("float_icon").style.top =0;
		document.getElementById("float_icon").style.left =0;float_icon.style.visibility ="visible";
		window.setInterval("moveIcon()", 150);
		function moveIcon(){
			posX +=(2 *dirX);
			posY +=(2 *dirY);
			$("#float_icon").css("top",posY);
			$("#float_icon").css("left",posX);
			if(posX < 1 ||posX + document.getElementById("float_icon").offsetWidth >$(window).width()){
				dirX =-dirX;
			}
			if(posY < 1 ||posY + document.getElementById("float_icon").offsetHeight+5 >$(window).height()){
				dirY =-dirY;
			} 
		}
		</script>		
</s:if>
<script type="text/javascript">
		$(function(){
			var t=$('.infor_tab').children('.tab_t').children();
			t.click(function() {
				var index=$(this).index();
				$(this).addClass('add_green').siblings().removeClass('add_green');
				$('.tab_cont').children().eq(index).show().siblings().hide();
			});
		})

		$(function(){
			$('.nr').find('li').hover(
				function(){
					$(this).children('.if_list').show();
				},function(){
					$(this).children('.if_list').hide();
				})
		})
	</script>
</body>
</html>