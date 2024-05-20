```markdown
# Elasticsearch Index Deletion Script

This Bash script automates the deletion of specific Elasticsearch indices in an OpenShift environment. The script processes indices related to `app`, `infra`, and `audit`, calculates half of the indices for each category, and then deletes those indices.

## Prerequisites

- OpenShift CLI (`oc`) installed and configured.
- Necessary permissions to execute commands in the `openshift-logging` namespace.
- Elasticsearch running in the `openshift-logging` namespace with appropriate security certificates.

## Usage

1. Clone the repository or download the script.

2. Make the script executable:
   ```bash
   chmod +x cleanup-elasticsearch-index.sh
   ```

3. Run the script:
   ```bash
   ./cleanup-elasticsearch-index.sh
   ```

## Script Details

1. **Array Definition**: The script starts by defining an array with values `app`, `infra`, and `audit`.

2. **Namespace and Pod Name Retrieval**: The script sets the `NAMESPACE` to `openshift-logging` and dynamically retrieves the name of the Elasticsearch pod.

3. **Loop Through Array Elements**: For each element (`app`, `infra`, `audit`):
   - It calculates the count of indices.
   - Divides the count by 2 to get the half count.
   - Retrieves the names of the indices to be deleted.
   - Deletes each index using a `curl` command executed within the Elasticsearch pod.

## Example Output

```bash
Element: app, Count: 10, Half Count: 5
Deleting index: app-index-1
Deleting index: app-index-2
Deleting index: app-index-3
Deleting index: app-index-4
Deleting index: app-index-5
Element: infra, Count: 8, Half Count: 4
Deleting index: infra-index-1
Deleting index: infra-index-2
Deleting index: infra-index-3
Deleting index: infra-index-4
Element: audit, Count: 6, Half Count: 3
Deleting index: audit-index-1
Deleting index: audit-index-2
Deleting index: audit-index-3
```

## Notes

- Ensure the script has the correct permissions and the OpenShift CLI is properly configured.
- Double-check the indices being deleted to avoid accidental data loss.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

Adesso puoi copiare e incollare questo testo direttamente in un file `README.md`.
