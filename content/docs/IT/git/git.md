# Git

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


## Commit

https://gist.github.com/lisawolderiksen/a7b99d94c92c6671181611be1641c733
https://cbea.ms/git-commit/#seven-rules
http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
https://www.git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#_commit_guidelines
https://github.com/torvalds/subsurface-for-dirk/blob/master/README.md#contributing
http://who-t.blogspot.co.at/2009/12/on-commit-messages.html
https://github.com/erlang/otp/wiki/writing-good-commit-messages
https://github.com/spring-projects/spring-framework/blob/30bce7/CONTRIBUTING.md#format-commit-messages

## Resources

- https://codewords.recurse.com/issues/two/git-from-the-inside-out
- https://jwiegley.github.io/git-from-the-bottom-up/
- https://git-scm.com/docs/git-switch
- https://news.ycombinator.com/item?id=32370675
- https://itoshkov.github.io/git-tutorial Teach Yourself Git Without Learning a Single Git Command by Ivan Toshkov
