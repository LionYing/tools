<?php
$referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';
file_put_contents('logo.txt', $referer."\r\n",FILE_APPEND);
?>