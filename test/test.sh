#!/bin/bash
function clean_all
{
    for name in *
    do
        sub=${name}
        end_cond="test"
        if [ ${sub} = ${end_cond} ];
        then
            break
        fi
        echo ${sub}
        rm -f ${sub}/test
    done
}

function test_all
{
    
    for name in *
    do
        if [ -d ${name} ]
        then
            end_cond='test'
            if [ ${name} == ${end_cond} ]
            then
                break
            fi
            echo ${name}
            cp -r test/* ${name}
            cd ${name}
            ./Grade.bat
            read -p "finished "$name". press any key to grade next student..."
            cd ..
        fi
    done
}

function extract_column
{
    #$x, where x is the column number
    awk '{print $2}' FS="," test.csv > extract.txt
}

function curl_cmd ()
{
    echo "cin is $p"
    #curl command, where $p replaces the cin
}

function curl_all
{
    count=0 #count for how many parallel executions
    while read p; do
        echo "$p"
        curl_cmd "$p"&
        #so 5 at a go, where pre-increment, so first will be 1, not 0
        ((++count % 5 == 0)) && wait
    done <extract.txt
}


extract_column
curl_all
#clean_all
#test_all