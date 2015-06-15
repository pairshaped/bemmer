#!/usr/bin/env sh

# Make sure directories exist

echo "Building Bemmer..."
echo "----------------------------"
echo "Creating directory structure"
mkdir -p ./bemmer/react

# Compile litcoffee to javascript files

echo "Compiling class Bemmer..."
coffee -p -c ./source/class.litcoffee > ./bemmer/class.js
echo "Compiling bemmer()..."
coffee -p -c ./source/bemmer.litcoffee > ./bemmer/bemmer.js
echo "Compiling ReactBemmer..."
coffee -p -c source/react/index.litcoffee > ./bemmer/react/reactBemmer.js
echo "Done"
