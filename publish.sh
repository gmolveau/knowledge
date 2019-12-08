#!/usr/bin/env sh

# add _book and _publish to your .gitginore

REMOTE="origin"
BRANCH="docs"
GITBOOK_FOLDER="_book"
PUBLISH_FOLDER="_publish"

if ! git diff-files --quiet --ignore-submodules --
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi
echo "Switching to master branch"
git checkout master

echo "Deleting old publication"
rm -rf ${GITBOOK_FOLDER}

echo "Generating site"
if test $(which gitbook); then
    gitbook build .
elif test $(which npx); then
    npx gitbook-cli build .
else
    echo "gitbook-cli can't be found"
    exit 1
fi

echo "Preparing publish folder"
rm -rf ${PUBLISH_FOLDER} && mkdir ${PUBLISH_FOLDER}
git worktree prune
echo "Checking out ${BRANCH} branch into the publish folder"
git worktree add -B ${BRANCH} ${PUBLISH_FOLDER} --no-checkout

echo "Moving gitbook to publish folder"
mv ${GITBOOK_FOLDER}/* ${PUBLISH_FOLDER}

echo "Adding the CNAME file"
if [ ! -f ./CNAME ]; then
    read -p "Enter the production URL (e.g. myblog.idontknow.com): " PRODUCTION_URL
    echo "${PRODUCTION_URL}" > ${PUBLISH_FOLDER}/CNAME
else
    cp CNAME ${PUBLISH_FOLDER}/CNAME
fi

echo "Updating ${BRANCH} branch"
cd ${PUBLISH_FOLDER} && git add --all && git commit -m "Update (publish.sh)" && cd ..

echo "Pushing to ${REMOTE}"
git push ${REMOTE} +${BRANCH}

echo "Cleaning up"
rm -rf ${GITBOOK_FOLDER} ${PUBLISH_FOLDER}
