# When we grab a base image it is always important to pin to a specific version so that you always have things run exactly the same
# Here I just grabbed the latest version of jenkins from the comunity approved jenkins image coming from this registry. https://hub.docker.com/r/jenkins/jenkins
FROM jenkins/jenkins:2.369 

####
# We want to define things that are unlikely to change higher up in the file because every line in the Dockerfile after a change will also need to be recreated.
# More reading on that here https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
###
# We want to disable the setup wizard so that it can just spin up and only look for configuration provided within this image
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# Define where the configuration as code file will be within the container
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# This file is how you should only ever install plugins for jenkins. Doing it this way allows you complete controll over what is running and what version.
# This way you don't run into non-deterministic issues as well as an automated way of ensuring you always have the correct plugins running without manual intervention.
# In the future if you need to update the version of a plugin
COPY config/plugins.txt /usr/share/jenkins/ref/plugins.txt
# Installs the plugins and versions provided in plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Add the file casc file from this repo to the image
COPY config/casc.yaml /var/jenkins_home/casc.yaml