#!/bin/bash

CC='/home/sebastian/documents/programming/llvm/jail/llvm501/bin/clang'
CFLAGS='-g -S -emit-llvm'
SRC_IN='main.c'
IR_OUT='main.ll'

HTML_DIR='/home/sebastian/.qt-creator-workspace/Phasar/test/.google-code-prettify'
LINES_FILE='line-numbers.txt'
EXPECTED_LINES_FILE='expected-line-numbers.txt'
PHASAR_OUTPUT_FILE='out'

OUT_HTML="html/source-code.html"
OUT_CSS="html/css/mark-lines.css"

PHASAR_BIN='/home/sebastian/documents/programming/llvm/jail/llvm501/bin/phasar'
PHASAR_PLUGIN='/home/sebastian/.qt-creator-workspace/build-Phasar-Desktop-Debug/MonoIntraEnvironmentVariableTracing/libMonoIntraEnvironmentVariableTracing.so'
PHASAR_RESULTS_FILE='results.json'

SUMMARY_FILE='test-result-index.html'

function create_html {
    rm -f ${OUT_HTML}
    echo '<!doctype html>' >> ${OUT_HTML}
    echo '<html>' >> ${OUT_HTML}
    echo '<head>' >> ${OUT_HTML}
    echo '<title>Gude!</title>' >> ${OUT_HTML}
    echo '<link rel="stylesheet" href="google-code-prettify/skins/desert.css">' >> ${OUT_HTML}
    echo '<link rel="stylesheet" href="css/custom.css">' >> ${OUT_HTML}
    echo '<link rel="stylesheet" href="css/mark-lines.css">' >> ${OUT_HTML}
    echo '<script src="google-code-prettify/prettify.js"></script>' >> ${OUT_HTML}
    echo '</head>' >> ${OUT_HTML}
    echo '<body onload="PR.prettyPrint()">' >> ${OUT_HTML}
    echo '<pre class="prettyprint linenums lang-c">' >> ${OUT_HTML}
    while IFS='' read -r line || [[ -n "${line}" ]]; do
        echo "${line}" >> ${OUT_HTML}
    done < "${SRC_IN}"
    echo '</pre>' >> ${OUT_HTML}
    echo '<div>' >> ${OUT_HTML}
    while IFS='' read -r line || [[ -n "${line}" ]]; do
        echo "${line}<br>" >> ${OUT_HTML}
    done < "${PHASAR_OUTPUT_FILE}"
    echo '</div>' >> ${OUT_HTML}
    echo '</body>' >> ${OUT_HTML}
    echo '</html>' >> ${OUT_HTML}

    # create css
    rm -f ${OUT_CSS}
    while read -r line || [[ -n "${line}" ]]; do
        echo "li.L${line} { background-color: grey; }" >> ${OUT_CSS}
    done < "${LINES_FILE}"
}

function create_summary_start {
    echo '<!doctype html>' > ${SUMMARY_FILE}
    echo '<html>' >> ${SUMMARY_FILE}
    echo '<head>' >> ${SUMMARY_FILE}
    echo '<title>Gude!</title>' >> ${SUMMARY_FILE}
    echo '</head>' >> ${SUMMARY_FILE}
    echo '<body>' >> ${SUMMARY_FILE}
    echo '<table border="1">' >> ${SUMMARY_FILE}
    echo '<tr>' >> ${SUMMARY_FILE}
        echo '<th>' >> ${SUMMARY_FILE}
            echo 'Test' >> ${SUMMARY_FILE}
        echo '</th>' >> ${SUMMARY_FILE}
        echo '<th>' >> ${SUMMARY_FILE}
            echo 'Report' >> ${SUMMARY_FILE}
        echo '</th>' >> ${SUMMARY_FILE}
        echo '<th>' >> ${SUMMARY_FILE}
            echo 'Result' >> ${SUMMARY_FILE}
        echo '</th>' >> ${SUMMARY_FILE}
    echo '</tr>' >> ${SUMMARY_FILE}
}

function add_test_result {
    TEST_NAME="${1}"
    TEST_LINK="${2}"
    TEST_RESULT="${3}"

    echo '<tr>' >> ${SUMMARY_FILE}
        echo '<td>' >> ${SUMMARY_FILE}
            echo ${TEST_NAME} >> ${SUMMARY_FILE}
        echo '</td>' >> ${SUMMARY_FILE}
        echo '<td>' >> ${SUMMARY_FILE}
            echo "<a href=\"${TEST_LINK}\">Report</a>" >> ${SUMMARY_FILE}
        echo '</td>' >> ${SUMMARY_FILE}
        echo '<td>' >> ${SUMMARY_FILE}
            echo ${TEST_RESULT} >> ${SUMMARY_FILE}
        echo '</td>' >> ${SUMMARY_FILE}
    echo '</tr>' >> ${SUMMARY_FILE}
}

function create_summary_end {
    echo '</table>' >> ${SUMMARY_FILE}
    echo '</body>' >> ${SUMMARY_FILE}
    echo '</html>' >> ${SUMMARY_FILE}
}

create_summary_start

DIRECTORY=${1}
if [ -z "${DIRECTORY}" ]
then
    DIRECTORY="./[0-9][0-9][0-9]*"
fi

for test_dir in ${DIRECTORY}
do
    echo "Handling ${test_dir}"
    cd ${test_dir}

    echo "Creating html skeleton"
    rm -rf html
    mkdir -p html/css
    ln -s ${HTML_DIR} html/google-code-prettify
    ln -s ${HTML_DIR}/css/custom.css html/css/

    echo "Compiling to IR"
    ${CC} ${CFLAGS} ${SRC_IN} -o ${IR_OUT}

    echo "Running analysis"
    ${PHASAR_BIN} -m ${IR_OUT} -M 0 -D plugin --analysis-plugin ${PHASAR_PLUGIN} > ${PHASAR_OUTPUT_FILE} 2>&1

    echo "Checking result"
    diff ${LINES_FILE} ${EXPECTED_LINES_FILE} > /dev/null 2>&1
    RC=$?
    TEST_RESULT=""
    if [ $RC -eq 0 ]; then
        TEST_RESULT="OK"
    else
        TEST_RESULT="FAILURE"
    fi

    echo "Creating report"
    create_html

    rm -f ${PHASAR_RESULTS_FILE}

    cd - > /dev/null 2>&1

    echo "Adding test result to overview"
    add_test_result ${test_dir} ${test_dir}/${OUT_HTML} ${TEST_RESULT}

    echo ""
done

create_summary_end

#EOF
