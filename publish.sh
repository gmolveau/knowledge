#!/usr/bin/env sh

BRANCH="docs"
FOLDER="_book"

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf ${FOLDER}
mkdir ${FOLDER}
git worktree prune

echo "Checking out ${BRANCH} branch into ${FOLDER}"
git worktree add -B ${BRANCH} ${FOLDER} origin/${BRANCH}

echo "Removing existing files"
rm -rf ${FOLDER}/* ${FOLDER}/.*

echo "Generating site"
if test ! $(which npx); then
    echo "nodejs npx is not installed. exiting."
    exit 1
fi
npx gitbook-cli build .

echo "Writing CNAME file"
if [ ! -f ./CNAME ]; then
    read -p "Enter the production URL (e.g. myblog.idontknow.com): " PRODUCTION_URL
    echo "$PRODUCTION_URL" > ${FOLDER}/CNAME
else
    cp CNAME ${FOLDER}/CNAME
fi

echo "Updating ${BRANCH} branch"
cd ${FOLDER} && git add --all && git commit -m "Publishing to ${BRANCH} (publish.sh)" && cd ..

echo "Pushing to github"
git push origin +${BRANCH}

echo "Finished, cleaning up"
rm -rf ${FOLDER}
