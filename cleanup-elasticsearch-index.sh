#!/bin/bash

# Array with values app, infra, audit
ARRAY=("app" "infra" "audit")

# Namespace
NAMESPACE="openshift-logging"

# Pod name retrieval
CLEAN_POD_NAME=$(oc -n $NAMESPACE get pods -l component=elasticsearch -o NAME | grep $(oc exec -n $NAMESPACE -c elasticsearch $(oc -n openshift-logging get pods -l component=elasticsearch -o NAME | grep "\-cd-") -- es_util --query=_cat/master?v | awk '/cdm/{ print $NF}') | awk -F"/" '{ print $2}') # Replace with the correct pod name if needed

# Loop through each element in the array
for ELEMENT in "${ARRAY[@]}"; do
  # Execute the command to get the count
  count=$(oc exec -n $NAMESPACE -c elasticsearch $CLEAN_POD_NAME -- es_util --query=_cat/indices | sort -k3 | grep $ELEMENT | wc -l)

  # Divide the count by 2 and get the integer part
  half_count=$((count / 2))

  # Print the output
  echo "Element: $ELEMENT, Count: $count, Half Count: $half_count"

  # Get the names of the indices
  indices=$(oc exec -n $NAMESPACE -c elasticsearch $CLEAN_POD_NAME -- es_util --query=_cat/indices | sort -k3 | grep $ELEMENT | head -$half_count | awk '{print $3}')

  # Loop through each index and execute the curl command to delete the index
  for index in $indices; do
    echo "Deleting index: $index"
    oc exec -n $NAMESPACE -c elasticsearch $CLEAN_POD_NAME -- curl -s --key /etc/elasticsearch/secret/admin-key --cert /etc/elasticsearch/secret/admin-cert --cacert /etc/elasticsearch/secret/admin-ca -XDELETE https://localhost:9200/$index
  done

done
