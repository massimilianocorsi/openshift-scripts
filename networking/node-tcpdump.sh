#!/bin/bash

# Default values for pod_regex and capture_time
default_pod_regex="logging"
default_capture_time="600" # seconds

# Initial setting of values
pod_regex="$default_pod_regex"
capture_time="$default_capture_time"
proxy="http://127.0.0.1:8080"

# Loop through nodes
tcpdump_node () {
    # Execute debug mode for the current node
    oc debug node/$node --to-namespace dummy << EOF &

    # Commands to run inside the node
    chroot /host
    export https_proxy=$proxy
    sudo podman rm toolbox-root --force
    toolbox
    nsenter -n -t \$(chroot /host crictl inspect --output yaml \$(chroot /host crictl ps | awk '/$pod_regex/{print \$1}') | grep 'pid' | awk '{print \$2}' | head -1) -- tcpdump -nn -i any -w /host/var/tmp/\$(cat /etc/hostname)_$(echo $pod_regex)_\$(date +%d_%m_%Y-%H_%M_%S-%Z).pcap &

    # Wait $capture_time seconds
    sleep $capture_time
    # Exit the toolbox
    exit
EOF
}

copy_capture_file () {
    data=$(date +%d_%m_%Y)
    ssh core@$node "sudo chmod 777 /var/tmp/*${data}*.pcap"
    scp core@$node:/var/tmp/*${data}*.pcap /tmp/
}

# Find the node names that contain the pods of interest
get_nodes () {
    oc get pod -A -o wide | grep $pod_regex
    nodes=$(oc get pod -A -o wide | grep $pod_regex | awk '{print $8}')
    echo "Node list:"
    for node in $nodes; do
        echo $node
    done
}

tcpdump_loop_node () {
    # Loop through tcpdump nodes
    for node in $nodes; do
        tcpdump_node & # parallel job
    done

    # Wait for all processes to finish
    wait
}

copy_loop_node () {
    # Loop through nodes to copy files
    for node in $nodes; do
        copy_capture_file & # parallel job
    done
    # Wait for all processes to finish
    wait
}

# Function to configure pod_regex
configure_pod_regex() {
    read -p "Enter the new value for pod_regex (press Enter to keep the default value '$default_pod_regex', current: '$pod_regex' ): " new_pod_regex
    if [ -n "$new_pod_regex" ]; then
        pod_regex="$new_pod_regex"
    else
        pod_regex="$default_pod_regex"
    fi
}

# Function to configure capture_time
configure_capture_time() {
    read -p "Enter the new value for capture_time in seconds (press Enter to keep the default value '$default_capture_time', current: '$capture_time' ): " new_capture_time
    if [ -n "$new_capture_time" ]; then
        capture_time="$new_capture_time"
    else
        capture_time="$default_capture_time"
    fi
}

# Function to display the menu
show_menu() {
    echo "Choose an action:"
    echo "1. Get nodes"
    echo "2. Run tcpdump on nodes"
    echo "3. Copy capture files from nodes"
    echo "4. Configure pod_regex"
    echo "5. Configure capture_time"
    echo "6. Exit"
}

# Function to perform actions based on user choice
perform_action() {
    local choice
    read -p "Enter the number corresponding to the desired action: " choice
    case $choice in
        1) get_nodes ;;
        2) get_nodes && tcpdump_loop_node ;;
        3) get_nodes && copy_loop_node ;;
        4) configure_pod_regex ;;
        5) configure_capture_time ;;
        6) echo "Exiting." && exit ;;
        *) echo "Invalid choice. Try again." && show_menu ;;
    esac
}

# Main
while true; do
    show_menu
    perform_action
done
