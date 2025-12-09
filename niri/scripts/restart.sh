#!/bin/bash

if (($# == 0)); then
  echo "用法: $0 <程序名>"
  echo "示例: $0 firefox 或 $0 'code -n'"
  exit 1
fi

for cmd in "$@"; do
  # 提取基础命令名（去除参数）
  base_cmd=$(echo "$cmd" | awk '{print $1}')

  # 检查是否有进程在运行
  if pgrep -f "^$base_cmd" >/dev/null 2>&1; then
    echo "🔄 程序正在运行，结束: $base_cmd"
    pkill -f "^$base_cmd"
    sleep 0.5 # 等待进程结束
  else
    echo "🚀 启动: $cmd"
    # 在子shell中运行并分离
    (eval "$cmd" &>/dev/null &)
  fi
done

exit 0
