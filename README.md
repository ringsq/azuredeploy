

## Settings Reference

**azure_appid**
The AppId used for a service provider login

**azure_password**
The password used for a service provider login

**azure_tenant**
The tenant used for a service provider login

**resource_group**
**container_name**
**image**
**dns**
**registry**
**registry_user**
**registry_password**
**envvars**
A list of environment variables to pass to azure deploy.  These must then be set in the environment section.
```
envvars:
  - PORT
  - PROTOCOL
```
