# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh/

# Powerlevel10k theme path
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=( git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

# In case a command is not found, try to find the package that has it
# function command_not_found_handler {
#     local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
#     printf 'zsh: command not found: %s\n' "$1"
#     local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
#     if (( ${#entries[@]} )) ; then
#         printf "${bright}$1${reset} may be found in the following packages:\n"
#         local pkg
#         for entry in "${entries[@]}" ; do
#             local fields=( ${(0)entry} )
#             if [[ "$pkg" != "${fields[2]}" ]]; then
#                 printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
#             fi
#             printf '    /%s\n' "${fields[4]}"
#             pkg="${fields[2]}"
#         done
#     fi
#     return 127
# }

# Detect AUR wrapper
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# Helpful aliases
alias c='clear' # clear terminal
alias l='eza -lh --icons=auto' # long list
alias ls='eza --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor
alias pp='paru -S'
alias f='fastfetch'
alias zed='zeditor -n'

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias glog='git log --pretty=format:"%h %ad %s" --date=short'
alias glogr='git log --pretty=format:"%h %ad %s" --date=short --reverse'
# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'
# Gamemode
alias high='powerprofilesctl set performance && sudo cpupower frequency-set -g performance && sudo nvidia-smi -pm 1 && echo "🎮 游戏模式：最高性能"'
alias balanced='powerprofilesctl set balanced && sudo cpupower frequency-set -g powersave && sudo nvidia-smi -pm 0 && echo "🎵 娱乐模式：平衡性能"'
alias low='powerprofilesctl set power-saver && sudo cpupower frequency-set -g powersave && sudo nvidia-smi -pm 0 && echo "🔇 静音模式：低功耗静音"'

alias status='echo "🎯 当前性能模式状态：" && \
echo -n "🔋 电源配置文件: " && powerprofilesctl get && \
echo -n "⚡ CPU 调频器: " && cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "未知" && \
echo -n "🎮 NVIDIA GPU 持久模式: " && nvidia-smi --query-gpu=persistence_mode --format=csv,noheader 2>/dev/null || echo "NVIDIA 驱动未安装" && \
echo "💡 提示: 使用 high/balanced/low 切换模式"'
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Display Pokemon
pokemon-colorscripts --no-title -r 1,3,6





export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0
export GDK_BACKEND=wayland
export SDL_VIDEODRIVER=wayland
export DXVK_STATE_CACHE=1
export DXVK_STATE_CACHE_PATH=$HOME/.local/share/dxvk-cache

# 让通配符在无匹配时不报错，而是返回空
unsetopt nomatch

# [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
