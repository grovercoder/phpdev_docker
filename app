#!/bin/bash


# #####################################
# Functions
# #####################################
enter()
{
	target=
	[[ -z $PARAMS ]] && target='phpfpm' || target=$PARAMS

	containername=$(getContainerNameByType "$target")
	$DOCKER exec -it $containername /bin/bash
}

logs()
{
	docker-compose logs $PARAMS
}

rebuild()
{
	docker-compose stop
	docker-compose rm $PARAMS
	docker-compose build	
}

start() 
{
	docker-compose up -d $PARAMS
	docker-compose logs
}

status()
{
	$DOCKER ps
}

stop()
{
	docker-compose stop $PARAMS
}

usage()
{
	echo "Usage:  ./app [action]"
	echo "   actions:  start, stop"
}


# #####################################
# Support functions
# #####################################
#
# Find the generated container name, given the name in the docker-compose.yml file
# 
getContainerNameByType() {
    # abort if no type is specified
    local CONTAINER_TYPE="$1"
    if [ -z "$CONTAINER_TYPE" ];
    then
        echo "No container type specified. Please specifiy a service name (e.g. phpfpm, mysql, nginx, ...)."  >&2
        return 1
    fi

    # check if xargs is available
    if [ -z "$XARGS" ];
    then
        echo "The tool 'xargs' was not found on your system." >&2
        return 1
    fi

    # check if grep is available
    if [ -z "$GREP" ];
    then
        echo "The tool 'grep' was not found on your system." >&2
        return 1
    fi

    # check if sed is available
    if [ -z "$SED" ];
    then
        echo "The tool 'sed' was not found on your system." >&2
        return 1
    fi

    local containerName=$($DOCKER ps -q | $XARGS $DOCKER inspect --format '{{.Name}}' | $GREP "$CONTAINER_TYPE" | $SED 's:/::' | $GREP "$CONTAINER_TYPE_1")
    echo $containerName
    return 0
}

# #####################################
# Main
# #####################################
# first parameter is what action to do
ACTION=$1
# All other arguments are parameters
if [ "$#" -gt "1" ]; then
	shift
	PARAMS=$@
fi

# Mandatory Tools
DOCKER=`which docker`
if [ -z "$DOCKER" ];
then
    echo "'docker' was not found on your system." >&2
    exit 1
fi

# command variables
XARGS=`which xargs`
GREP=`which grep`
SED=`which sed`

# Other variables 
RED='\033[1;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m' # No Color

case "$ACTION" in
	enter)
	enter
	;;

	logs)
	logs
	;;

	rebuild)
	rebuild
	;;

	start)
	start
	;;

	status)
	status
	;;

	stop)
	stop
	;;


	*)
	usage
	;;
esac
