
#!/bin/bash
# 部署到 github pages 脚本
# 错误时终止脚本
set -e

# 删除打包文件夹
rm -rf public

# 打包。even 是主题
hugo -t hermit # if using a theme, replace with `hugo -t <YOURTHEME>`

# 进入打包文件夹
cd public

# 添加 readme
echo '## Store Hugo HTML files <br> Blog Markdown File [https://github.com/AverageJoeWang/AverageJoeWang.github.io/tree/gh-blog](https://github.com/AverageJoeWang/AverageJoeWang.github.io/tree/gh-blog)' > README.md

echo 'averagejoe.wang' > CNAME

#cp ../favicon.ico .
# Add changes to git.
git init
git add -A

# Commit changes.
msg="building site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"


# 推送到 github pages
# nusr.github.io 只能使用 master分支
# -f 强制推送
git push -f git@github.com:AverageJoeWang/AverageJoeWang.github.io.git master

# 回到原文件夹
cd ..

# 删除public 
rm -rf public

# 同步原文

git add -A
git commit -m "$msg"
git push -f git@github.com:AverageJoeWang/AverageJoeWang.github.io.git gh-blog
