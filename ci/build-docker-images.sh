#!/bin/bash

here=$(dirname $(readlink -f $0))
cd $here

export DOCKER_CLI_EXPERIMENTAL=enabled

PR_NUMBER=$(echo $GIT_BRANCH | sed -n '/^PR-/s/PR-//gp')
if [ "$TAG_NAME" ]; then
    TMP_TAG="ci-$TAG_NAME"
elif [ "$GIT_BRANCH" == "master" ]; then
    TMP_TAG="ci-$GIT_BRANCH"
elif [ "$PR_NUMBER" ]; then
    TMP_TAG=ci-pr-$PR_NUMBER
else
    # Not built with Jenkins
    TMP_TAG="dev"
fi

declare -A images

images[jupyter]="jolibrain/jupyter_dd_notebook"
images[filebrowser]="jolibrain/filebrowser"

for dir in ${!images[@]}; do
    image_url=${images[$dir]}

    if [ "$TAG_NAME" ]; then
        docker manifest inspect $image_url:$TAG_NAME
        if [ "$?" -eq 0 ]; then
            echo "Skipping $image_url:$TAG_NAME, already in registry."
            continue
        fi
    fi

    cd $here/../$dir
    docker build -t $image_url:$TMP_TAG .

    if [ "$TMP_TAG" != "dev" ]; then
        #docker tag $image_url:$TMP_TAG ceres:5000/$image_url:$TMP_TAG
        #docker push ceres:5000/$image_url:$TMP_TAG
        #docker rmi ceres:5000/$image_url:$TMP_TAG

        if [ "$TAG_NAME" ]; then
            # Not yet used
            docker tag $image_url:$TMP_TAG $image_url:${TAG_NAME}
            docker push $image_url:${TAG_NAME}

        elif [ "$GIT_BRANCH" == "master" ]; then
            docker push $image_url:$TMP_TAG

            docker tag $image_url:$TMP_TAG $image_url:latest
            docker push $image_url:latest
        fi
    fi
    cd -
done
