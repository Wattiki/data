#!/usr/bin/env sh

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PROJECTNAME=$1

if  [ $PROJECTNAME ]; then

	FILES=("/var/www/html/data/solr/"$PROJECTNAME"/*")
	URL=http://rosie.unl.edu:8080/solr/api_transmississippi_test/update

	for f in $FILES; do
		echo Posting file $f to $URL
		curl $URL --data-binary @$f -H 'Content-type:application/xml' 
		echo
	done

	#send the commit command to make sure all the changes are flushed and visible
	#curl $URL --data-binary '<commit softCommit=true/>' -H 'Content-type:application/xml'

	curl "$URL?softCommit=true"
	echo

  
else

  echo "Please enter project e.g. scriptname.sh projectname"
  
fi



 
