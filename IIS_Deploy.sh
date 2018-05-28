#!/bin/sh
export AWS_CREDENTIALS=`aws sts assume-role --role-arn arn:aws:iam::217912576673:user/Himaja --role-session-name "$(curl 169.254.169.254/latest/meta-data/instance-id)-$(date +%s)" --output text`
export AWS_ACCESS_KEY_ID=`echo $AWS_CREDENTIALS | cut -d ' ' -f 5`
export AWS_SECRET_ACCESS_KEY=`echo $AWS_CREDENTIALS | cut -d ' ' -f 7`
export AWS_SESSION_TOKEN=`echo $AWS_CREDENTIALS | cut -d ' ' -f 8`
export AWS_DEFAULT_REGION=${Region}


# if [ ${Environment} == "dev" ]; then
#     ENVIRONMENTNAME="nonprod"
# else
#     ENVIRONMENTNAME="preprod"
# fi
export STACK_NAME="DemoIIS-${Environment}"
   aws cloudformation create-stack --region ${Region} --stack-name ${STACK_NAME} --template-body file://`pwd`/IIS_CFT.json --parameters file://`pwd`/IIS_Params.json
   aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}
