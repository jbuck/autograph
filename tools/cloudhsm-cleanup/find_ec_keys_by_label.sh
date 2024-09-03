#!/usr/bin/env bash

set -e

CLOUDHSM_USER=${CLOUDHSM_USER:?}
CLOUDHSM_PASSWORD=${CLOUDHSM_PASSWORD:?}
CLOUDHSM_USER_TYPE=${CLOUDHSM_USER_TYPE:-"CU"}

# read key labels from stdin
# search for EC public and private keys matching the label
# write a CSV of label,handle to stdout where the handle can be an empty string
#
# Requires env vars (use set_cloudhsm_env_vars to set them):
#
# CLOUDHSM_USER
# CLOUDHSM_PASSWORD
#
# Accepts the optional env vars:
#
# CLOUDHSM_USER_TYPE
#

TMP=$(mktemp)

while IFS= read -r keylabel; do
    pubkey_handles=$(/opt/cloudhsm/bin/cloudhsm-cli key list --filter attr.label="${keylabel}" | jq '.data.matched_keys[]["key-reference"]')

    for handle in ${pubkey_handles}; do
        echo "${keylabel},${pubkey_handle}"
    done
done
