# About

These are terraform scripts to provision infrastructure on the Collaboratory Openstack

# Security Group Considerations

Because the Collab Openstack api is apparently only accessible from inside the network, some convoluted logic had to be added to launch terraform remotely, hence the **apply.sh** script (yes, you need access to a pre-existing vm in order to bootstrap the scripted creation of more vms, you may laugh)

# Usage

- In the top directory, add a **host** file which should be an ansible inventory file listing an existing vm in the collab network that you can ssh to and which has Python 3 installed. **Do not commit this file!** (it is in gitignore)

- Also, add a **terraform.tfvars** under the **infra** directory with the following fields (needless to say the 3 dots need to be replaced with the right values):

```
region = "..."
tenant_id = "..."
application_credential_id = "..."
application_credential_secret = "..."
auth_url = "..."
```

**Do not commit this file either!** (it is in gitignore too)

- Run:

```
apply.sh
```
