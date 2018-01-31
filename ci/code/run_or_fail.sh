# helper method for providing error messages for a command
run_or_fail() {
  local explanation=$1
  shift 1
  "$@"
  if [ $? != 0 ]; then
    echo $explanation 1>&2
    exit 1
  fi
}


# shift命令用于对参数的移动(左移), 通常用于在不知道传入参数个数的情况下依次遍历每个参数然后进行相应处理
# shift将异常信息保存后，左移执行命令，失败则将异常信息重定向到标准错误输出 
