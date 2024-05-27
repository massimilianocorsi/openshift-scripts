# Delete terminating Projects

## Script Description
This script is designed to delete OpenShift projects that are stuck in the "Terminating" status. It retrieves projects in the "Terminating" status, retrieves their namespace details in JSON format, removes occurrences of `"kubernetes"` from the JSON, and sends a PUT request to finalize the deletion of the namespace.

## How to Execute
### Option 1: Execute Using ./deleteprojectterminatingstatus.sh
1. Ensure the script has execution permissions. If not, grant execution permission using the command:
   ```
   chmod +x delete_terminating_projects.sh
   ```
2. Execute the script using the command:
   ```
   ./delete_terminating_projects.sh
   ```

### Option 2: Execute from Shell
You can also execute the script directly from the shell using the following command:
```bash
for ns in $(oc get projects | awk '/Terminating/{ print $1 }') ; do oc get ns $ns -o json > $ns.json ; cp $ns.json $ns.backup.json; sed -i 's/"kubernetes"//g' $ns.json ; curl -kv -H "Content-Type: application/json" -H "Authorization: Bearer $(oc whoami -t)" -X PUT --data-binary @$ns.json  $(oc whoami --show-server)/api/v1/namespaces/$ns/finalize; done;
```

### Option 3: Download using curl
You can download the script using `curl` with the following command:
```bash
curl -O https://raw.githubusercontent.com/massimilianocorsi/openshift-projects-delete/main/delete_terminating_projects.sh
```

### Option 4: Download using wget
Alternatively, you can use `wget` to download the script:
```bash
wget https://raw.githubusercontent.com/massimilianocorsi/openshift-projects-delete/main/delete_terminating_projects.sh
```

## Note
Ensure that you have appropriate permissions to execute OpenShift commands and delete namespaces before running this script.
Make sure you have the necessary permissions to execute OpenShift commands and perform namespace deletions.
