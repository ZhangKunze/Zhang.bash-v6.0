#!/data/data/com.termux/files/usr/bin/bash
sub1(){
while true; do
echo -e "\e[96m[1] 复制文件或目录\e[0m"
echo -e "\e[92m[2] 删除文件或目录\e[0m"
echo -e "\e[93m[3] 给 xxx 加执行权限\e[0m"
echo -e "\e[95m[4] 切换目录\e[0m"
echo -e "\e[94m[5] 打印当前工作目录\e[0m"
echo -e "\e[91m[0] 退出\e[0m"
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
echo -e "\e[96m[1] 安装 Proot\e[0m"
echo -e "\e[92m[2] 安装 Proot Debian\e[0m"
echo -e "\e[93m[3] 启动 Proot Debian\e[0m"
echo -e "\e[91m[0] 退出\e[0m"
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
echo -e "\e[95m注意:本功能的深度依赖 Termux，非 Termux 用户不能用！\e[0m"
echo -e "\e[96m[1] 安装『新』软件\e[0m"
echo -e "\e[92m[2] 卸载软件\e[0m"
echo -e "\e[93m[3] 列出所有软件\e[0m"
echo -e "\e[91m[0] 退出\e[0m"
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
echo -e "\033[96m🔮 我生成了一个 1 到 10 之间的数字。\033[0m"
echo -e "\033[93m你只有 5 次机会，祝你好运。\033[0m"
while [ $attempts -gt 0 ]; do
echo -e "\n\033[95m━━━ 剩余次数: $attempts ━━━\033[0m"
read -p "输入你的猜测: " guess
if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
echo -e "\033[91m❌ 请输入有效的数字！\033[0m"
continue
fi
if [ $guess -eq $target ]; then
echo -e "\033[92m🎉 牛逼！就是 $target！\033[0m"
return 0
elif [ $guess -lt $target ]; then
echo "太小了，往大点猜。"
else
echo "太大了，往小点猜。"
fi
((attempts--))
if [ $attempts -eq 2 ]; then
echo -e "\033[93m⚠️ 只剩 2 次了，你可想好了。\033[0m"
elif [ $attempts -eq 1 ]; then
echo -e "\033[91m⚠️ 最后一次机会了！别手抖！\033[0m"
fi
done
echo -e "\n\033[91m💀 5 次全错。答案是: $target 。\033[0m"
echo -e "\033[93m要不... 承认自己运气不好吧。\033[0m"
}