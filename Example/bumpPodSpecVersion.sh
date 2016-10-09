#!/bin/sh

#  bumpPodSpecVersion.sh
#  QGGImagePicker
#
#  Created by taizi on 16/10/9.
#  Copyright © 2016年 taizi. All rights reserved.

podspec-bump -p ../QGGImagePicker.podspec -w
git commit -am "bump `podspec-bump --dump-version`"
git tag "`podspec-bump --dump-version`"
git push --tags
pod trunk push
