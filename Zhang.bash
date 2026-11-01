#!/data/data/com.termux/files/usr/bin/bash
runing_directory="$(cd "$(dirname "$0")" && pwd)"
sub_bash='sub.bash'
sub_path="$runing_directory/$sub_bash"
if [ -f "$sub_path" ]; then
if diff <(echo "cac6a4057aba1249dd8efe8a3bae9dbbdf05f91e6e3a69b6f3371d2ea7549598  -") <(cat "$sub_path" | sha256sum) > /dev/null; then
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
-v) echo "本脚本是 Zhang.bash 的6.0版本"
if [ "$0" == "$BASH_SOURCE" ]; then
exit 0
else
return 0
fi
;;
--version) echo "本脚本是 Zhang.bash 的6.0版本"
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
echo -e "\e[32m这是 Zhang.bash，Version：6.0"
echo -e "\e[96m[1] 文件管理\e[0m"
echo -e "\e[92m[2] Proot 专项\e[0m"
echo -e "\e[93m[3] 软件管理\e[0m"
echo -e "\e[95m[4] 猜数字游戏\e[0m"
echo -e "\e[91m[0] 退出\e[0m"
echo -e "未来还会添加更多选项\e[94m"
read -r -p "选择哪一个? " YYN || break
if ! [[ "$YYN" =~ ^[0-9]+$ ]]; then
    eval "$YYN"
    continue
fi
case $YYN in
0) break ;;
1) echo -e "\e[96m" && sub1 ;;
2) echo -e "\e[92m" && sub2 ;;
3) echo -e "\e[93m" && sub3 ;;
4) echo -e "\e[95m" && sub4 ;;
*) echo -e "\033[95m${you_are_excited[$RANDOM % ${#you_are_excited[@]}]}\033[0m" ;;
esac
done
