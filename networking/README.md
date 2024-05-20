# Networking Scripts

This directory contains scripts for network-related tasks in an OpenShift environment.

## Scripts

### tcpdump_node.sh

This script automates the process of capturing network packets on OpenShift nodes where specific pods are running, and then copying the captured files to a local directory. The script uses `tcpdump` and `oc debug` to perform these operations.

#### Usage

1. Make the script executable:
   ```bash
   chmod +x tcpdump_node.sh
   ```

2. Run the script:
   ```bash
   ./tcpdump_node.sh
   ```

3. Follow the on-screen menu to perform various actions.

#### Script Functions

1. **Get Nodes**: Finds and lists nodes containing the pods that match the specified `pod_regex`.

2. **Run tcpdump on Nodes**: Executes `tcpdump` on the nodes containing the pods of interest and captures the network packets for the specified `capture_time`.

3. **Copy Capture Files from Nodes**: Copies the captured `.pcap` files from the nodes to the local `/tmp` directory.

4. **Configure pod_regex**: Allows the user to set or update the `pod_regex` value.

5. **Configure capture_time**: Allows the user to set or update the `capture_time` value.

6. **Exit**: Exits the script.

#### Example

```bash
Choose an action:
1. Get nodes
2. Run tcpdump on nodes
3. Copy capture files from nodes
4. Configure pod_regex
5. Configure capture_time
6. Exit
Enter the number corresponding to the desired action: 1
Node list:
node1
node2
...
```

#### Notes

- Ensure the script has the correct permissions and the OpenShift CLI is properly configured.
- Be cautious when running the script in a production environment as it can generate a significant amount of data.
- Configure proxy ENV

