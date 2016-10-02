#!/bin/bash

p=$(pwd)
page_dir=../hierarchy
output_directory=$page_dir/coms
file_base=iframe_test
mkdir -p $output_directory

repo_path=../website

pushd $repo_path > /dev/null

for commit in $(git log --format="%H")
do
  #echo $commit
  date="$(git show -s --format=%ct $commit)"
  git checkout -q $commit
  new_dir="$output_directory/$date"
  #echo $new_dir
  mkdir -p $new_dir
  cp *.html $new_dir
  cp -r stylesheets/ $new_dir
  cp -r *imgs/ $new_dir 2> /dev/null

  #python gen_page.py $new_dir $date $commit $page_dir $file_base
done

git checkout -q master

popd > /dev/null

for d in $output_directory/*/; do cp HIER_BASE.html "$d"; done
for d in $output_directory/*/; do cp HIER_BASE.css "$d"; done

pushd $output_directory > /dev/null
echo 'commits = [' > ../../site-hierarchy/commits.js

ls | awk '{print "\""$0"\","}'  | head -c -2 >> ../../site-hierarchy/commits.js
echo ']' >> ../../site-hierarchy/commits.js

popd > /dev/null
