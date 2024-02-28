# README #
The ``AWS Parameter Store`` can be used for managing configuration parameters across services and across environments. For storing sensitive data the Secret Manager or the Parameter Store SecureString can be used. 

Handling the everything as code is one of the best devops practices, therefore the configuration parameters can be handles as code and stored in a repository. Naming conventions for parameter names should be followed to differentiate the environments.

The existing terraform script setup is an example of keeping and creating the parameters in the Parameter Store.
Additionally to the above, there should be pipelines (eg. jenkins, gh, gitlabCI) put in place that will automatically deploy the terraform script on updates of files with parameters. The developers should not modify the parameter store manually, all parameters updates should be done through repository by triggering the respective pipelines.
