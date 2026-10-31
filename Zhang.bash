#/data/data/com.termux/files/usr/bin/bash
sub1(){
while true; do
echo "[1] 复制文件或目录"
echo "[2] 删除文件或目录"
echo "[3] 给 xxx 加执行权限"
echo "[4] 切换目录"
echo "[5] 打印当前工作目录"
echo "[0] 退出"
read -r -p "选择哪个? " XXX
if ! [[ "$XXX" =~ ^[0-9]+$ ]]; then
    eval "$XXX"
    continue
fi
case $XXX in
0) break ;;
1) read -r -p "请提供原路径" cp_a
read -r -p "请提供目标路径" cp_b
cp -a $cp_a $cp_b
;;
2) read -r -p "🆘警告🆘:文件删除请深思熟虑。 " rm_a
rm -rf $rm_a
;;
3) read -r -p "请提供要给执行权限文件的位置。 " chmod_a
chmod +x $chmod_a
;;
4) read -r -p "想切换到哪个目录？" cd_directory
cd $cd_directory
;;
5) pwd ;;
esac
done
}
sub2(){
while true; do
echo "[1] 安装 Proot"
echo "[2] 安装 Proot Debian"
echo "[3] 启动 Proot Debian"
echo "[0] 退出"
read -r -p "选择哪一个? " Proot
if ! [[ "$Proot" =~ ^[0-9]+$ ]]; then
    eval "$Proot"
    continue
fi
case $Proot in
0) break ;;
1) pkg install proot-distro ;;
2) proot-distro install debian ;;
3) proot-distro login debian ;;
esac
done
}
sub3(){
while true; do
echo "注意:本功能的深度依赖 Termux，非 Termux 用户不能用！"
echo "[1] 安装『新』软件"
echo "[2] 卸载软件"
echo "[3] 列出所有软件"
echo "[0] 退出"
read -r -p "选择哪一个? " PKG
if ! [[ "$PKG" =~ ^[0-9]+$ ]]; then
    eval "$PKG"
    continue
fi
case $PKG in
0) break ;;
1) read -r -p "请输入该软件包的准确包名 " install
pkg install $install
;;
2) read -r -p "请谨慎卸载软件 " remove
pkg remove $remove
;;
3) pkg list-installed ;;
esac
done
}
sub4(){
local target=$((RANDOM % 10 + 1))
local attempts=5
local guess
echo -e "\033[36m🔮 我生成了一个 1 到 10 之间的数字。\033[0m"
echo -e "\033[33m你只有 5 次机会，祝你好运。\033[0m"
while [ $attempts -gt 0 ]; do
echo -e "\n\033[35m━━━ 剩余次数: $attempts ━━━\033[0m"
read -p "输入你的猜测: " guess
if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
echo -e "\033[31m❌ 请输入有效的数字！\033[0m"
continue
fi
if [ $guess -eq $target ]; then
echo -e "\033[32m🎉 牛逼！就是 $target！\033[0m"
return 0
elif [ $guess -lt $target ]; then
echo "太小了，往大点猜。"
else
echo "太大了，往小点猜。"
fi
((attempts--))
if [ $attempts -eq 2 ]; then
echo -e "\033[33m⚠️ 只剩 2 次了，你可想好了。\033[0m"
elif [ $attempts -eq 1 ]; then
echo -e "\033[31m⚠️ 最后一次机会了！别手抖！\033[0m"
fi
done
echo -e "\n\033[31m💀 5 次全错。答案是: $target 。\033[0m"
echo -e "\033[33m要不... 承认自己运气不好吧。\033[0m"
}
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
echo "[1] 文件管理"
echo "[2] Proot 专项"
echo "[3] 软件管理"
echo "[4] 猜数字游戏"
echo "[0] 退出"
echo "未来还会添加更多选项"
read -r -p "选择哪一个? " YYN
if ! [[ "$YYN" =~ ^[0-9]+$ ]]; then
    eval "$YYN"
    continue
fi
case $YYN in
0) break ;;
1) sub1 ;;
2) sub2 ;;
3) sub3 ;;
4) sub4 ;;
*) echo -e "\033[35m${you_are_excited[$RANDOM % ${#you_are_excited[@]}]}\033[0m" ;;
esac
done
