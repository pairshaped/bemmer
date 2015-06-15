#!/usr/bin/env sh

# Make sure directories exist

echo "Building Bemmer..."
echo "----------------------------"
echo "Creating directory structure"
mkdir -p ./react

# Compile litcoffee to javascript files

echo "Compiling class Bemmer..."
coffee -p -c ./source/class.litcoffee > ./bemmerClass.js
echo "Compiling bemmer()..."
coffee -p -c ./source/bemmer.litcoffee > ./bemmer.js
echo "Compiling ReactBemmer..."
coffee -p -c source/react/index.litcoffee > ./react/react.js
echo "Done"
