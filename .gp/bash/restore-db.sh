#!/bin/bash
# shellcheck disable=SC1091
#
# SPDX-License-Identifier: MIT
# Copyright © 2022 Modamod
#
# startup.sh
# Description:
# Initializes the database and starts the snipeit app.
#
# Notes:
# Rerunning this script will update the db password for snipeit user with random passowrd each time.
#
bucket=""
prefix="dump.sql"
output="/tmp/dump.sql"
database="snipeit"
user="snipeit"
password=""

help() {
    # Display Help
    echo "Add description of the script functions here."
    echo
    echo "Syntax: restore-db.sh [-h|b|p|o|u|P|d]"
    echo "options:"
    echo "b     S3 bucket to use to get the db dump."
    echo "p     S3 Prefix to use to get the db dump."
    echo "o     Local filesystem path to store the db dump."
    echo "u     Database user to use for db restoration."
    echo "P     Database password to use db restoration."
    echo "d     Database name to restore the dump in."
}

get_opt() {
while getopts ":hb:p:o:u:P:d:" option; do
    case $option in
    h) # display Help
        help
        exit
        ;;
    b)
        bucket="${OPTARG}"
        echo "Sab but true";;
    p)
        prefix="${OPTARG}" ;;
    o)
        output="${OPTARG}" ;;
    u)
        user="${OPTARG}" ;;
    P)
        password="${OPTARG}" ;;
    d)
        database="${OPTARG}" ;;
    \?) # Invalid option
        echo "Error: Invalid option"
        help
        exit
        ;;
    esac
done
}



get_opt $@

get_dump_from_s3 $bucket $prefix $output

if test -f "$output"; then
    restore_database $user $passowrd $database $output
fi
