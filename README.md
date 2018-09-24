Docker Deploy Tools
-

A crude and simple bash script to deploy / update docker environments with docker-compose over SSH.

This has been done only for simpler deploy flow when hosting multiple docker environments and deploy automation like Jenkins etc is not an option for some reason or other. 

Usage
--

Create mapping.yml to config directory. Add project mapping to mapping.yml:

```yaml
sites:
  project_name: # First parameter for the command
    environment: # Second parameter ie. dev/stage/production
      ssh_config: "" # SSH alias or connection string.
      compose_file: "" # Docker-compose file absolute path.
      docker_env: "" # Docker environment name.
    environment_1: # Second parameter
      ssh_config: "" # SSH alias or connection string.
      compose_file: "" # Docker-compose file absolute path.
      docker_env: "" # Docker environment name.
```

Command: 
```./deploy.sh project_name environment ```


