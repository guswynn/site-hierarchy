#site hierarchy
Say you have a static site with links to sub-pages. This site has changed over time in a git repo called 'website' and outputs to a repo called 'hierarchy'.

In other words the structure should look like this:
```
tree -L 1
.
├── hierarchy
├── site-hierarchy
└── website

3 directories, 0 files
```
and 
```
./gen_all.sh
```
should be run in site-hierarchy (this repo!). But some small edits of the shell script variables could change this.


What if you want another static site that encapsulates the changing hierarchy of that site?

This is (work in progress) tool to do so.

It currently copies the web-relavent content of each commit into folders named with the commit's unix time. Therefore the whole history of the site is exposed. Try it with:
```python -m SimpleHTTPServer```

The next steps are 1. to add commit filtering to try (!) to filter out small commits that are extraneous to the website changing, and 2. make a way to view this history more intuitively (some work has been done in overlay).

