###
 # @Author: your name
 # @Date: 2020-04-03 00:17:20
 # @LastEditTime: 2020-06-02 00:06:18
 # @LastEditors: Please set LastEditors
 # @Description: In User Settings Edit
 # @FilePath: \vuepress-blog\deploy.sh
### 
# 确保脚本抛出遇到的错误
set -e

# 打包生成静态文件
npm run build

# 进入打包好的文件夹
cd docs/.vuepress/dist

# 创建git的本地仓库，提交修改
git init
git add -A
git commit -m 'deploy'

# 覆盖式地将本地仓库发布至github，因为发布不需要保留历史记录
# 格式为：git push -f git@github.com:'用户名'/'仓库名'.git master
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages
git push -f git@github.com/Vimalate/Vimalate.git master:gh-pages
# https://github.com/Vimalate/Vimalate
cd -
