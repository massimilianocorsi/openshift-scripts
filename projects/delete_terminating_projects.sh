#!/bin/bash

# Loop through projects in Terminating state
for ns in $(oc get projects | awk '/Terminating/{ print $1 }'); do
    # Get namespace details in JSON format
    oc get namespace $ns -o json > $ns.json
    
    # Backup namespace details
    cp $ns.json $ns.backup.json
    
    # Remove "kubernetes" from JSON (if present)
    sed -i 's/"kubernetes"//g' $ns.json
    
    # Finalize namespace deletion
    curl -kv -H "Content-Type: application/json" -H "Authorization: Bearer $(oc whoami -t)" -X PUT --data-binary @$ns.json $(oc whoami --show-server)/api/v1/namespaces/$ns/finalize
done

##########################################################################################################################################################################################################################################################################################################################################################################
###                                                                                                                                                                                                                                                                                                                                                                    ###
### for ns in $(oc get projects | awk '/Terminating/{ print $1 }') ; do oc get ns $ns -o json > $ns.json ; cp $ns.json $ns.backup.json; sed -i 's/"kubernetes"//g' $ns.json ; curl -kv -H "Content-Type: application/json" -H "Authorization: Bearer $(oc whoami -t)" -X PUT --data-binary @$ns.json  $(oc whoami --show-server)/api/v1/namespaces/$ns/finalize; done; ###
###                                                                                                                                                                                                                                                                                                                                                                    ###
##########################################################################################################################################################################################################################################################################################################################################################################
