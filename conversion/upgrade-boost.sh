#!/bin/bash
export tools_dir=$(pwd)
if [ -z "$BOOST_DIR" ] || [ -z "$BOOST_STABLE_DIR" ]; then
	printf "Error; both BOOST_DIR and BOOST_STABLE_DIR must be specified to make this script work\n"
	exit 1
fi
cd "$BOOST_DIR"

rm -rf "$BOOST_STABLE_DIR/*"
find libs -type f | awk -f "${tools_dir}/boost-filter-source.awk" | xargs -I asdf install -D -m 664 -T asdf "$BOOST_STABLE_DIR"/asdf
# sh is needed to delay the invocation of sed, which is needed to collapse the include directories
find libs -type f | awk -f "${tools_dir}/boost-filter-headers.awk" | xargs -I asdf sh -c 'install -D -m 664 -T asdf "$BOOST_STABLE_DIR"/$(sed -e "s+^.*/include/boost/+boost/+" <<< asdf)'
cp LICENSE_1_0.txt "$BOOST_STABLE_DIR"
