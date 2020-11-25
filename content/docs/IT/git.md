
Git flow

https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow
https://www.endoflineblog.com/gitflow-considered-harmful

Git worklows

http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html

```bash
git checkout master
git pull origin master
git checkout -b 3275-add-commenting
# frequently
git fetch origin master
git rebase origin/master
# before push
git rebase -i origin/master
# squash except the first (top) commit
git checkout master
git merge 3275-add-commenting
git push origin master
```

https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
