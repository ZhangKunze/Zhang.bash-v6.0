#!/data/data/com.termux/files/usr/bin/bash
# Zhang.bash —— Termux 命令行小助手（v6.0 单文件 · 多彩版）
# 说明：原本 sub.bash 的内容已合并进本文件，便于单文件分发 / 测试。
#       如需恢复外置 sub.bash，见文件末尾「外置模式」注释。

runing_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export Zhang_bash_run=true

# ============================================================
#  吐槽库
# ============================================================
you_are_excited=(
    "今天是不是有点太兴奋了"
    "哎哟喂，你输的这啥玩意儿？找不着啊"
    "😂😂😂command not found😂😂😂"
    "哎哟喂，都怪 Microsoft，他让你输错了！"
    "这都怪 NVIDIA，所以你才输错了"
    "本程序没有使用 LLM 哦！所以说不会预测你的行为"
    "今天早上是没睡醒吗，看不清吗？😂😂😂"
    "你确定这不是在输入火星语？"
    "键盘上的猫又踩了一下吧？"
    "要不要试试输入 ls 清醒一下？"
    "CPU 表示：这个锅我不背"
    "输入了个寂寞，鉴定完毕"
    "这个选项不存在，但它曾经活在你心里"
    "请把这次输入录入《人类迷惑输入大典》"
    "别灰心，再输错一次说不定就对……不对"
    "你输入的这一串，连 SHA-256 都算不出意义"
)

ZHANG_HISTORY=()

# ============================================================
#  来自 sub.bash：文件管理
# ============================================================
sub1(){
    while true; do
        echo -e "\e[96m[1] 复制文件或目录\e[0m"
        echo -e "\e[92m[2] 删除文件或目录\e[0m"
        echo -e "\e[93m[3] 给 xxx 加执行权限\e[0m"
        echo -e "\e[95m[4] 切换目录\e[0m"
        echo -e "\e[94m[5] 打印当前工作目录\e[0m"
        echo -e "\e[36m[6] 新建目录（含父目录）\e[0m"
        echo -e "\e[35m[7] 查看文件内容\e[0m"
        echo -e "\e[33m[8] 移动 / 重命名\e[0m"
        echo -e "\e[32m[9] 列出目录内容\e[0m"
        echo -e "\e[91m[0] 退出\e[0m"
        read -r -p "选择哪个? " XXX
        if ! [[ "$XXX" =~ ^[0-9]+$ ]]; then
            eval "$XXX"
            continue
        fi
        case $XXX in
            0) break ;;
            1) read -r -p "请提供原路径：" cp_a
               read -r -p "请提供目标路径：" cp_b
               cp -a -- "$cp_a" "$cp_b" ;;
            2) read -r -p "🆘警告🆘：文件删除请深思熟虑。请输入要删除的路径：" rm_a
               rm -rf -- "$rm_a" ;;
            3) read -r -p "请提供要给执行权限的文件位置：" chmod_a
               chmod +x -- "$chmod_a" ;;
            4) read -r -p "想切换到哪个目录？" cd_directory
               cd -- "$cd_directory" || echo -e "\e[91m切换失败（$?）\e[0m" ;;
            5) pwd ;;
            6) read -r -p "要新建的目录路径：" mk_a
               mkdir -p -- "$mk_a" && echo -e "\e[92m已创建：$mk_a\e[0m" ;;
            7) read -r -p "要查看的文件：" cat_a
               if [ -f "$cat_a" ]; then
                   echo -e "\e[96m───── $cat_a ─────\e[0m"
                   cat -- "$cat_a"
                   echo -e "\e[96m───────────────────\e[0m"
               else
                   echo -e "\e[91m文件不存在：$cat_a\e[0m"
               fi ;;
            8) read -r -p "源路径：" mv_a
               read -r -p "目标路径：" mv_b
               mv -- "$mv_a" "$mv_b" ;;
            9) read -r -p "要列出的目录（回车=当前）：" ls_a
               ls -lah "${ls_a:-.}" ;;
            *) echo -e "\e[93m未知选项：$XXX\e[0m" ;;
        esac
    done
}

# ============================================================
#  来自 sub.bash：Proot 专项
# ============================================================
sub2(){
    if ! command -v proot-distro >/dev/null 2>&1; then
        echo -e "\e[93m⚠️  未检测到 proot-distro，建议先执行 [1]。\e[0m"
    fi
    while true; do
        echo -e "\e[96m[1] 安装 Proot\e[0m"
        echo -e "\e[92m[2] 安装 Proot Debian\e[0m"
        echo -e "\e[93m[3] 启动 Proot Debian\e[0m"
        echo -e "\e[36m[4] 列出已安装的发行版\e[0m"
        echo -e "\e[35m[5] 卸载指定发行版\e[0m"
        echo -e "\e[33m[6] 安装其他发行版\e[0m"
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
            4) proot-distro list 2>/dev/null | sed 's/^/  /' ;;
            5) read -r -p "要卸载哪个发行版？（例如 debian）" distro_rm
               [ -n "$distro_rm" ] && proot-distro remove "$distro_rm" ;;
            6) read -r -p "要安装哪个发行版？" distro_in
               [ -n "$distro_in" ] && proot-distro install "$distro_in" ;;
            *) echo -e "\e[93m未知选项：$Proot\e[0m" ;;
        esac
    done
}

# ============================================================
#  来自 sub.bash：软件管理
# ============================================================
sub3(){
    if ! command -v pkg >/dev/null 2>&1; then
        echo -e "\e[91m⚠️  未检测到 pkg 命令，本功能需要 Termux。\e[0m"
        return 1
    fi
    while true; do
        echo -e "\e[95m注意：本功能深度依赖 Termux，非 Termux 用户请飘过。\e[0m"
        echo -e "\e[96m[1] 安装『新』软件\e[0m"
        echo -e "\e[92m[2] 卸载软件\e[0m"
        echo -e "\e[93m[3] 列出所有已安装软件\e[0m"
        echo -e "\e[36m[4] 搜索软件包\e[0m"
        echo -e "\e[35m[5] 更新软件源\e[0m"
        echo -e "\e[33m[6] 升级软件\e[0m"
        echo -e "\e[91m[0] 退出\e[0m"
        read -r -p "选择哪一个? " PKG
        if ! [[ "$PKG" =~ ^[0-9]+$ ]]; then
            eval "$PKG"
            continue
        fi
        case $PKG in
            0) break ;;
            1) read -r -p "请输入该软件包的准确包名：" install
               [ -n "$install" ] && pkg install "$install" ;;
            2) read -r -p "请谨慎卸载软件。输入包名：" remove
               [ -n "$remove" ] && pkg remove "$remove" ;;
            3) pkg list-installed ;;
            4) read -r -p "搜索关键词：" kw
               [ -n "$kw" ] && pkg search "$kw" ;;
            5) pkg update ;;
            6) pkg upgrade ;;
            *) echo -e "\e[93m未知选项：$PKG\e[0m" ;;
        esac
    done
}

# ============================================================
#  来自 sub.bash：猜数字
# ============================================================
_update_record() {
    local file="$1" key="$2" val="$3"
    [ -z "$file" ] && return 1
    local tmp
    tmp="$(mktemp 2>/dev/null || echo "${file}.tmp.$$")"
    if [ -f "$file" ]; then
        grep -v "^${key}:" "$file" > "$tmp" 2>/dev/null || true
    fi
    echo "${key}:${val}" >> "$tmp"
    mv "$tmp" "$file" 2>/dev/null
}

sub4(){
    local max attempts diff_name
    while true; do
        echo -e "\e[95m请选择难度："
        echo -e "  \e[92m[1] 简单（1-5，5 次机会）"
        echo -e "  \e[93m[2] 普通（1-10，5 次机会）"
        echo -e "  \e[96m[3] 困难（1-100，7 次机会）"
        read -r -p "→ " diff_choice
        case "$diff_choice" in
            1) max=5;   attempts=5; diff_name="简单"; break ;;
            2) max=10;  attempts=5; diff_name="普通"; break ;;
            3) max=100; attempts=7; diff_name="困难"; break ;;
            *) echo -e "\e[91m❌ 只能选 1 / 2 / 3，请重新选择。\e[0m" ;;
        esac
    done

    local target=$((RANDOM % max + 1))
    local guess used=0

    echo -e "\n\033[96m🔮 我生成了一个 1 到 $max 之间的数字（难度：$diff_name）。\033[0m"
    echo -e "\033[93m你只有 $attempts 次机会，祝你好运。\033[0m"

    while [ $attempts -gt 0 ]; do
        echo -e "\n\033[95m━━━ 剩余次数: $attempts ━━━\033[0m"
        read -p "输入你的猜测: " guess
        if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
            echo -e "\033[91m❌ 请输入有效的数字！\033[0m"
            continue
        fi
        used=$((used + 1))
        if [ "$guess" -eq "$target" ]; then
            echo -e "\033[92m🎉 牛逼！就是 $target！你用了 $used 次。\033[0m"
            return 0
        elif [ "$guess" -lt "$target" ]; then
            echo "太小了，往大点猜。"
        else
            echo "太大了，往小点猜。"
        fi
        attempts=$((attempts - 1))
        if [ $attempts -eq 2 ]; then
            echo -e "\033[93m⚠️ 只剩 2 次了，你可想好了。\033[0m"
        elif [ $attempts -eq 1 ]; then
            echo -e "\033[91m⚠️ 最后一次机会了！别手抖！\033[0m"
        fi
    done
    echo -e "\n\033[91m💀 机会用完。答案是: $target 。\e[0m"
    echo -e "\033[93m要不... 承认自己运气不好吧。\e[0m"
}

# ============================================================
#  辅助函数
# ============================================================
_zhang_banner() {
    echo -e "\e[95m"
    cat <<'BANNER'
   ╔══════════════════════════════════════════╗
   ║       Zhang.bash  ·  v6.0  ·  Termux     ║
   ╚══════════════════════════════════════════╝
BANNER
    echo -e "\e[0m"
}

_zhang_sysinfo() {
    echo -e "\e[96m─── 系统信息 ───\e[0m"
    echo -e "主机名   : \e[92m$(uname -n)\e[0m"
    echo -e "内核     : \e[92m$(uname -sr)\e[0m"
    echo -e "架构     : \e[92m$(uname -m)\e[0m"
    echo -e "日期时间 : \e[92m$(date '+%Y-%m-%d %H:%M:%S')\e[0m"
    echo -e "当前目录 : \e[92m$(pwd)\e[0m"
    echo -e "主目录   : \e[92m$HOME\e[0m"
    echo -e "Bash     : \e[92m$BASH_VERSION\e[0m"
    echo -e "磁盘     : \e[92m$(df -h "$HOME" 2>/dev/null | tail -1 | awk '{print $4" 可用 / "$2" 总量（"$5" 已用）"}')\e[0m"
    if [ -f /proc/meminfo ]; then
        local mem_total mem_free
        mem_total=$(awk '/MemTotal/ {printf "%.1f MB", $2/1024}' /proc/meminfo)
        mem_free=$(awk '/MemAvailable/ {printf "%.1f MB", $2/1024}' /proc/meminfo)
        echo -e "内存     : \e[92m可用 $mem_free / 总量 $mem_total\e[0m"
    fi
}

_zhang_about() {
    echo -e "\e[96m─── 关于 Zhang.bash ───\e[0m"
    echo "当前版本  : 6.0（社区增强 · 单文件 · 多彩版）"
    echo "版本说明  : 由 5.0 演进而来，sub.bash 已合并进主文件"
    echo "功能      : 文件管理 / Proot 专项 / 软件管理 / 猜数字"
    echo "命令直通  : 在菜单里直接输入 shell 命令即可执行"
    echo "彩蛋      : 在菜单里输入 zhang 试试~"
}

_zhang_history() {
    echo -e "\e[96m─── 本次会话你输入过的内容 ───\e[0m"
    if [ ${#ZHANG_HISTORY[@]} -eq 0 ]; then
        echo -e "\e[93m（还没输入过任何东西）\e[0m"
    else
        local i
        for i in "${!ZHANG_HISTORY[@]}"; do
            printf "  \e[92m%2d\e[0m. %s\n" "$((i+1))" "${ZHANG_HISTORY[$i]}"
        done
    fi
}

# ============================================================
#  命令行参数
# ============================================================
case "$1" in
    -v|--version)
        echo "本脚本是 Zhang.bash 的 6.0 版本（单文件 · 多彩版）"
        if [ "$0" == "$BASH_SOURCE" ]; then exit 0; else return 0; fi
        ;;
    -h|--help)
        echo "本脚本可以直接调用，这是最主要的用法。"
        echo "  -v / --version  显示版本号"
        echo "  -h / --help     显示此帮助"
        echo "  参数为空时进入交互式菜单。"
        if [ "$0" == "$BASH_SOURCE" ]; then exit 0; else return 0; fi
        ;;
esac

# ============================================================
#  主循环
# ============================================================
_zhang_banner
while true; do
    echo -e "\e[32m这是 Zhang.bash，Version：6.0-DeepSeek Edition"
    echo -e "\e[96m[1] 文件管理\e[0m"
    echo -e "\e[92m[2] Proot 专项\e[0m"
    echo -e "\e[93m[3] 软件管理\e[0m"
    echo -e "\e[95m[4] 猜数字游戏\e[0m"
    echo -e "\e[94m[5] 系统信息\e[0m"
    echo -e "\e[35m[6] 查看本次会话输入\e[0m"
    echo -e "\e[36m[7] 关于 Zhang.bash\e[0m"
    echo -e "\e[91m[0] 退出\e[0m"
    echo -e "\e[94m未来还会添加更多选项……\e[0m"
    read -r -p "选择哪一个? " YYN || break
    ZHANG_HISTORY+=("$YYN")

    # 🥚 彩蛋
    if [[ "$YYN" =~ ^(zhang|Zhang|ZHANG)$ ]]; then
        echo -e "\e[95m🎉 你找到了彩蛋！你绝对是 Zhang.bash 的真爱粉。\e[0m"
        continue
    fi

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
        5) echo -e "\e[94m" && _zhang_sysinfo ;;
        6) echo -e "\e[35m" && _zhang_history ;;
        7) echo -e "\e[36m" && _zhang_about ;;
        *) echo -e "\033[95m${you_are_excited[$RANDOM % ${#you_are_excited[@]}]}\033[0m" ;;
    esac
done

# ============================================================
#  外置模式（可选，需要时把上面 sub1~sub4 删掉，启用下面这段）
# ============================================================
# sub_bash='sub.bash'
# sub_path="$runing_directory/$sub_bash"
# EXPECTED_SUB_SHA256='这里填 sub.bash 的 sha256'
# if [ -f "$sub_path" ]; then
#     actual_sha="$(sha256sum "$sub_path" | awk '{print $1}')"
#     if [ "$actual_sha" = "$EXPECTED_SUB_SHA256" ] || [ "${ZHANG_FORCE:-0}" = "1" ]; then
#         chmod +x "$sub_path"; source "$sub_path"
#     else
#         echo -e "\e[91m🛑 sub.bash 校验失败，退出。\e[0m"; exit 1
#     fi
# fi
