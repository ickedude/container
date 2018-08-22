#!/bin/sh

error() {
	echo "$@" >&2
}

usage() {
	cat <<HEREDOC
$0 NAME[=SUFFIX[=SUFFIX[...]]][:TAG[:TAG[...]]] [...]

Call docker build for given NAME. NAME is a directory in the current working
directory, which contains the build context. SUFFIX is a specific dockerfile
within this directory. docker tag is called for each TAG.
HEREDOC
}

repository='kwoldt'

while [ $# -gt 0 ]; do
	arg="$1"
	shift
	if [ "$arg" = "-h" ] || [ "$arg" = "--help" ]; then
		usage
		exit 0
	fi

	name=$(echo "$arg" | grep -o '^[^=:]\+')
	if [ $? -ne 0 ]; then
		error "$name_suffix is not a valid tag"
		usage
		exit 1
	elif [ ! -d "$name" ]; then
		error "$name is not a valid build context"
		exit 1
	fi

	suffixes=$(echo "$arg" | grep -o '\(=[^=:]\+\)*' | cut -d'=' -f2-)
	if [ -z "$suffixes" ]; then
		suffixes="="
	fi

	tags=$(echo "$arg" | grep -o '\(:[^:]\+\)*' | cut -d':' -f2-)
	if [ -z "$tags" ]; then
		tags='latest'
		error "no tag specified, using 'latest'"
	fi

	old_ifs="$IFS"
	IFS='=:'
	for suffix in $suffixes; do
		dockerfile="Dockerfile"
		if [ -n "$suffix" ]; then
			dockerfile="$dockerfile.$suffix"
		fi
		if [ ! -f "$name/$dockerfile" ]; then
			error "dockerfile '$name/$dockerfile' does not exist"
			continue
		fi

		img_id=$(cd "$name"; LANG=C LC_TYPE=C docker build -f "$dockerfile" . | tee /dev/stderr | awk '/Successfully built/{print $NF}')
		if [ $? -eq 0 ]; then
			img_name="$repository/$name"
			if [ -n "$suffix" ]; then
				img_name="$img_name-$suffix"
			fi

			for tag in $tags; do
				docker tag "$img_id" "$img_name:$tag"
			done
		fi
	done
	IFS="$old_ifs"
done
