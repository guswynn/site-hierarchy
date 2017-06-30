#!/bin/bash

p=$(pwd)
page_dir=../hier
output_directory=$page_dir/coms
file_base=iframe_test
mkdir -p $output_directory

repo_path=../885
rm -r ../hier/*

pushd $repo_path > /dev/null

mkdir -p $page_dir/img_folders
current=img_folders/a
for commit in $(git log --reverse --format="%H")
do
  #echo $commit
  date="$(git show -s --format=%ct $commit)"
  git checkout -q $commit
  new_dir="$output_directory/$date"
  #echo $new_dir
  mkdir -p $new_dir
  cp *.html $new_dir
  cp -r stylesheets/ $new_dir


  for d in *imgs/; do
    if [ -d $d ] 
    then
      echo "GOOD"
      diff $page_dir/$current/$d $d
      if [ $? -eq 0 ]
      then
        ln -s ../../$current/$d $new_dir
      else
        current="$current"a
        mkdir -p $page_dir/$current
        cp -r $d $page_dir/$current/$d
        ln -s ../../$current/$d $new_dir
      fi
    fi
 done


  #python gen_page.py $new_dir $date $commit $page_dir $file_base
done

git checkout -q master

popd > /dev/null

for d in $output_directory/*/; do cp HIER_BASE.html "$d"; done
for d in $output_directory/*/; do cp HIER_BASE.css "$d"; done

pushd $output_directory > /dev/null
echo 'commits = [' > ../../site-hier/commits.js

ls | awk '{print "\""$0"\","}'  | head -c -2 >> ../../site-hier/commits.js
echo ']' >> ../../site-hier/commits.js

