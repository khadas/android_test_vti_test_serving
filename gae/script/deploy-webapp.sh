#!/bin/bash
#
# Copyright 2018 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ "$#" -ne 1 ]; then
  echo "usage: deploy-webapp.sh prod|test|public|local"
  exit 1
fi

if [ $1 = "prod" ]; then
  SERVICE="vtslab-schedule-prod"
elif [ $1 = "test" ]; then
  SERVICE="vtslab-schedule-test"
elif [ $1 = "public" ]; then
  SERVICE="vtslab-schedule"
else
  dev_appserver.py ./
  exit 0
fi

echo "Deploying the web app to $SERVICE ..."

gcloud app deploy app.yaml cron.yaml index.yaml queue.yaml worker.yaml --project=$SERVICE

echo "Deployment done!"
