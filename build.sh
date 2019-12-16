#/bin/sh

hexo g -d
git add *
git commit -m "update blog"
git push

