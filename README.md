## Jenkins image ##
---

We can use this repo as a way of going back and forth on this system until you get it into a state you're happy with at which point feel free to move into your own repo. I have also added detailed comments throughout this system to better inform why I'm doing what and this README will contain additional links for you to learn more and explore the posibilites.
### How to build
---
build the docker image using the following in the root of this repo.
``` $ docker build -t jenkins:dirty .```
### How to run
---
Since what we want to capture with this image is what the pipeline configurations looks like as well as the configurations for anything else you may want. We are going to want to volume mount out the `jenkins_home` dirrectory in order to be able to view what those configurations look like. So before the first run on someones machine you should make an output volume to "attach" as the mount point. Run the following command in order to create the volume.
``` $ docker volume create jenkins_home ```
Now with this persistant volume changes that you make between runs on the same machine will be preserved.
In order to run it locally after building use the following command.
``` $ docker run --rm -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password -v jenkins_home:/var/jenkins_home jenkins:dirty ```

After a time jenkins will standup at `localhost:8080` use username `admin` password `password` for now to login and make any changes that you see fit from there.
### More reading
---
This all comes from the jenkins image repository [here](https://github.com/jenkinsci/docker/blob/master/README.md) if you want to read more about the options that you have. For this to work in a real "production" env there are few more things we'd want to do, mainly we need to setup the actual runtime agents for running the pipelines. If you want to start reading ahead on the plan for that we will be using the amazon-ecs plugin which I've already installed just not yet configured with fargate details [here](https://plugins.jenkins.io/amazon-ecs/).