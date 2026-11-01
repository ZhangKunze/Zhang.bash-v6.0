#!/data/data/com.termux/files/usr/bin/bash
uname -a
sleep 3
whoami
sleep 1
id
sleep 4
pwd
sleep 2
#以下是循环菜单
while true; do
echo '[1]回到家目录。cd home'
echo '[2]列出当前目录的所有文件。ls'
echo '[3]列出当前目录所有文件，包括所有者和属性ls -la'
echo '[4]保存日志'
echo '[0]退出。exit'
echo "选择哪一个"
read  YYN
if [[ "$YYN" = "1" ]]; then
cd
fi
if [[ "$YYN" = "2" ]]; then
ls
fi
if [[ "$YYN" = "3" ]]; then
ls -la
fi
if [[ "$YYN" = "0" ]]; then
exit 0
fi
if [[ "$YYN" = "4" ]]; then
mkdir -p ~/Zhang.bash.log
echo "$(date) $(whoami)" >> ~/Zhang.bash.log/runing.log
fi
done
