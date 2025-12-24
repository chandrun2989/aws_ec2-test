Details
1. ansible/ansible.cfg
* Purpose: Project-specific Ansible configuration.
* Key settings:
    * inventory = inventory.aws_ec2.yml — uses the aws_ec2 dynamic inventory file in this folder by default.
    * remote_user = ec2-user — SSH user Ansible will use (typical for Amazon Linux).
    * private_key_file = ~/.ssh/ansible_key — default SSH private key path to connect to instances.
    * host_key_checking = False — disables SSH host key checking (convenient for CI, but less secure).
    * [inventory] enable_plugins = aws_ec2 — enable the aws_ec2 inventory plugin.
* Notes:
    * Ensure the private key exists and has correct permissions (chmod 600).
    * Consider enabling host_key_checking in production or manage known_hosts securely.
    * This file lets you run ansible-playbook playbook.yml without passing -i every time.
2. ansible/inventory.aws_ec2.yml
* Purpose: Configure Ansible's AWS EC2 dynamic inventory plugin to find target hosts.
* Key configuration:
    * plugin: aws_ec2 — uses the aws_ec2 dynamic inventory plugin.
    * regions: [ ap-south-1 ] — only query the ap-south-1 region.
    * filters:
        * tag:Project: my-web-app — only include instances tagged Project=my-web-app.
        * instance-state-name: running — only include running instances.
* Requirements & notes:
    * The plugin requires AWS credentials configured for the control machine (environment variables or ~/.aws/credentials).
    * Requires Python AWS libraries (boto3/botocore) and the appropriate Ansible collection (amazon.aws / community.aws depending on your Ansible version).
    * Ensure EC2 instances have the Project tag exactly matching "my-web-app" and are in ap-south-1.
    * If you want to target multiple regions or tags, update the regions/filters accordingly.
3. ansible/playbook.yml
* Purpose: Deploy the web application on hosts found by the inventory.
* Main operations:
    * hosts: all — runs against all inventory hosts.
    * become: true — runs tasks with privilege escalation (sudo).
    * Tasks:
        * dnf clean all (command) — run dnf clean all; set changed_when: false so it doesn't appear as changed.
        * Install nginx using the dnf module:
            * dnf: name: nginx state: present
        * copy ../src/index.html -> /usr/share/nginx/html/index.html
            * src path is relative to the control machine; ../src/index.html means one level up from ansible/ (ensure that file exists).
        * Start and enable nginx service (service module).
* Notes:
    * Use the dnf module with update_cache: yes instead of a separate dnf clean all command to be more Ansible-native and idempotent.
    * Use handlers to restart/reload nginx only when the copied file changes (improves performance and correctness).
    * Confirm the src path exists from where you run ansible-playbook. If you run from repo root, src path is likely correct; if not, adjust or use playbook_dir variables.
    * Consider adding a file permission/owner for the copied index.html if required.