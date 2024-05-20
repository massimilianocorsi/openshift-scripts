```markdown
# OpenShift Scripts Collection

Welcome to the OpenShift Scripts Collection repository! This repository contains a collection of Bash scripts designed to simplify various tasks in an OpenShift environment. Each script is intended to automate common operations, making it easier to manage and maintain your OpenShift clusters.

## Contents

- [Elasticsearch Index Deletion Script](cleanup-elasticsearch-index.sh): Automates the deletion of specific Elasticsearch indices based on predefined criteria.

## Prerequisites

- OpenShift CLI (`oc`) installed and configured.
- Necessary permissions to execute commands within the relevant OpenShift namespaces.
- Any specific dependencies or configurations mentioned in individual script descriptions.

## Usage

Each script is located in the `scripts` directory and can be executed independently. Below are general steps to use any script in this collection:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/openshift-scripts.git
   cd openshift-scripts
   ```

2. Navigate to the `scripts` directory:
   ```bash
   cd scripts
   ```

3. Make the desired script executable:
   ```bash
   chmod +x script_name.sh
   ```

4. Run the script:
   ```bash
   ./script_name.sh
   ```

## Scripts

### Elasticsearch Index Deletion Script

This script automates the deletion of specific Elasticsearch indices in an OpenShift environment. It processes indices related to `app`, `infra`, and `audit`, calculates half of the indices for each category, and deletes those indices.

#### Usage

1. Make the script executable:
   ```bash
   chmod +x cleanup-elasticsearch-index.sh
   ```

2. Run the script:
   ```bash
   ./cleanup-elasticsearch-index.sh
   ```

#### Example Output

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

## Contributing

We welcome contributions to this repository! If you have a script that you believe would be useful to others, please feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

Questo `README.md` fornisce una panoramica del repository, i requisiti, le istruzioni generali per l'uso degli script, dettagli su uno script specifico (in questo caso lo script per la cancellazione degli indici Elasticsearch) e informazioni su come contribuire al progetto. Puoi adattare e aggiungere informazioni man mano che aggiungi nuovi script al repository.
