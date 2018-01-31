#!/bin/bash

source run_or_fail.sh

# delete previous id 
rm -f .commit_id

# go to repo and update it to given commit
run_or_fail "Repository folder not found!" pushd $1 1> /dev/null
run_or_fail "Could not reset git" git reset --hard HEAD

# get the most recent commit
COMMIT=$(run_or_fail "Could not call 'git log' on repository" git log -n1)
if [ $? != 0 ]; then
  echo "Could not call 'git log' on repository"
  exit 1
fi
# get its id
COMMIT_ID=`echo $COMMIT | awk '{ print $2 }'`

# update the repo
run_or_fail "Could not pull from repository" git pull

# get the most recent commit
COMMIT=$(run_or_fail "Could not call 'git log' on repository" git log -n1)
if [ $? != 0 ]; then
  echo "Could not call 'git log' on repository"
  exit 1
fi
# get its id
NEW_COMMIT_ID=`echo $COMMIT | awk '{ print $2 }'`

# if the id changed, then write it to a file
if [ $NEW_COMMIT_ID != $COMMIT_ID ]; then
  popd 1> /dev/null
  echo $NEW_COMMIT_ID > .commit_id
fi


# source: python import
# pushd A: 把指定目录A压入目录栈，同时切换到A目录，再次pushd, 将栈顶的A目录和栈顶下一目录B对调，切换到B目录
# 2> /dev/null 代表忽略掉错误信息, 1> /dev/null 把标准输出重定向到/dev/null，其实就是屏蔽标准输出
# git log -nx: 最后x个log
# awk '{ print $2 }: 打印第二个字段
# popd: 与pushd相反，弹出，切换到栈顶的下一个目录
