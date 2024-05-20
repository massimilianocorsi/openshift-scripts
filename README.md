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
https://github.com/massimilianocorsi/openshift-scripts/blob/main/README-cleanup-elasticsearch-index.md
