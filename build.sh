#!/bin/sh

error() {
	echo "$@" >&2
}

usage() {
	cat <<HEREDOC
$0 NAME[:TAG[:TAG[...]]] [...]

Call docker build for given NAME. NAME is a directory in the current working
directory, which contains the build context. docker tag is called for each
TAG.
HEREDOC
}

while [ $# -gt 0 ]; do
	arg="$1"
	shift
	name=$(echo "$arg" | cut -d: -f1)
	if [ "$name" = "-h" ] || [ "$name" = "--help" ]; then
		usage
		exit 0
	elif [ -z "$name" ]; then
		error "$name is not a valid tag"
		usage
		exit 1
	fi
	tags=$(echo "$arg" | cut -d: -f2- | tr ':' '\n')
	if [ "$name" = "$tags" ]; then
		tags='latest'
	fi
	if [ -f "$name/Dockerfile" ]; then
		img_id=$(cd "$name"; LANG=C LC_TYPE=C docker build . | tee /dev/stderr | awk '/Successfully built/{print $NF}')
		for tag in $tags; do
			docker tag "$img_id" "kwoldt/$name:$tag"
		done
	else
		error "$name is not a valid build context"
		exit 1
	fi
done
