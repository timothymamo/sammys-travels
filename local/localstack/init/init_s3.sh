#!/bin/bash
awslocal s3api create-bucket --bucket local-sammy-travels
awslocal s3 cp /tmp/images s3://local-sammy-travels/ --recursive
awslocal s3api put-bucket-cors --bucket local-sammy-travels  --cors-configuration file:///tmp/cors/cors-policy.json