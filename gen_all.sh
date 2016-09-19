#!/bin/bash

p=$(pwd)
page_dir=../hierarchy
output_directory=$page_dir/coms
file_base=iframe_test
mkdir -p $output_directory

repo_path=../website

cd $repo_path

for commit in $(git log --format="%H")
do
  #echo $commit
  date="$(git show -s --format=%ct $commit)"
  git checkout $commit
  new_dir="$output_directory/$date"
  #echo $new_dir
  mkdir $new_dir
  cp *.html $new_dir
  cp -r stylesheets/ $new_dir
  cp -r *imgs/ $new_dir
  #python gen_page.py $new_dir $date $commit $page_dir $file_base
done
git checkout master
cd $p
