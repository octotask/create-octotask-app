#!/usr/bin/env bash
. ./script/setup.sh

readonly APP="./bin/create-octotask-app.js"
readonly TEMPLATE=$1
readonly TEST_FOLDER=$(mktemp -d -t cpa-XXXXXXXXXX)
readonly LOGFILENAME="test.output"
readonly LOGFILE="${TEST_FOLDER}/${LOGFILENAME}"

function create_app() {
  mkdir -p "$TEST_FOLDER"
  "$APP" \
    --appName "template-test-app" \
    --desc "A Octotask App for building on Travis" \
    --author "Pro Báwt" \
    --email "octotask@example.com" \
    --user "octotask" \
    --template "$TEMPLATE" \
    --repo "create-octotask-app-${TEMPLATE}" \
    "$TEST_FOLDER"
}

function run_npm_tests() {
    echo; echo "--[test ${TEMPLATE}]-- Run npm tests... "
    cd "$TEST_FOLDER"
    npm test 2>&1 | tee "$LOGFILENAME"
    cd - > /dev/null
}

echo "--[test ${TEMPLATE}]-- Run tests in ${TEST_FOLDER} folder"
create_app
run_npm_tests
./bin/run-tests.js $TEMPLATE $TEST_FOLDER
echo "--[test ${TEMPLATE}]-- All tests completed successfully!"
