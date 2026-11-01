#!/data/data/com.termux/files/usr/bin/bash
runing_directory="$(cd "$(dirname "$0")" && pwd)"
sub_bash='sub.bash'
sub_path="$runing_directory/$sub_bash"
if [ -f "$sub_path" ]; then
if diff <(echo "00c2d752d9f9c43e49e058f43a8d575f8e3d67eecb5dbcc9fc978f72c556ae80  -") <(cat "$sub_path" | sha256sum) > /dev/null; then
chmod +x "$sub_path"
source "$sub_path"
else
echo 'sub.bash已经被恶意修改，脚本退出'
if [ "$0" == "$BASH_SOURCE" ]; then
exit 1
else
return 1
fi
fi
fi
you_are_excited=(
"今天是不是有点太兴奋了"
"哎哟喂，你输的这啥玩意儿？找不着啊"
"😂😂😂command not found😂😂😂"
"哎哟喂，都怪 Microsoft，他让你输错了！"
"这都怪 NVIDIA，所以你才输错了"
"本程序没有使用 LLM 哦！所以说不会预测你的行为"
"今天早上是没睡醒吗，看不清吗？😂😂😂"
)
export Zhang_bash_run=true
case $1 in
-v) echo "本脚本是 Zhang.bash 的5.0版本"
if [ "$0" == "$BASH_SOURCE" ]; then
exit 0
else
return 0
fi
;;
--version) echo "本脚本是 Zhang.bash 的5.0版本"
if [[ "$0" == "$BASH_SOURCE" ]]; then
exit 0
else
return 0
fi
;;
--help) echo "本脚本可以直接调用，这是最主要的用法。-v/--version 显示版本号。"
if [[ "$0" == "$BASH_SOURCE" ]]; then
exit 0
else
return 0
fi
;;
esac
while true; do
echo "这是 Zhang.bash，Version：5.0"
echo -e "\e[33m[1] 文件管理"
echo -e "\e[33m[2] Proot 专项"
echo -e "\e[33m[3] 软件管理"
echo -e "\e[33m[4] 猜数字游戏"
echo -e "\e[33m[0] 退出"
echo -e "未来还会添加更多选项\e[35m"
read -r -p "选择哪一个? " YYN || break
if ! [[ "$YYN" =~ ^[0-9]+$ ]]; then
    eval "$YYN"
    continue
fi
case $YYN in
0) break ;;
1) echo -e "\e[33m" && sub1 ;;
2) echo -e "\e[38m" && sub2 ;;
3) echo -e "\e[37m" && sub3 ;;
4) echo -e "\e[31m" && sub4 ;;
*) echo -e "\033[35m${you_are_excited[$RANDOM % ${#you_are_excited[@]}]}\033[0m" ;;
esac
done
