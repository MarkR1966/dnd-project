# DnD Project

## Contents

<ul>
  <li>Project Objective</li>
<li>App Overview</li>
<li>Asana Board</li>
<li>Database</li>
<li>CI Pipeline</li>
<li>App Design</li>
  <li>Deployment</li>
<li>Testing</li>
  <li>Risk Assessment</li>
<li>Current Issues</li>
<li>Improvements</li>
</ul>

## Project Objective
The requirements of the project are as follows:
<ul>
<li>An Asana board (or equivalent Kanban board tech) with full expansion on tasks needed to complete the project.</li>
<li>An Application fully integrated using the Feature-Branch model into a Version Control System which will subsequently be built through a CI server and deployed to a cloud-based virtual machine.</li>
<li>If a change is made to a code base, then Webhooks should be used so that Jenkins recreates and redeploys the changed application.</li>
<li>The project must follow the Service-oriented architecture that has been asked for.</li>
<li>The project must be deployed using containerisation and an orchestration tool.</li>
<li>As part of the project, you need to create an Ansible Playbook that will provision the environment that your application needs to run.</li>
<li>The project must make use of a reverse proxy to make your application accessible to the user.</li>
</ul>
  
## App Overview
I created a DnD Character Generation app. As part of having two implementations, the first one is simpler than the first.  

The first app will generate a random class, race and name for the user. 

The second app will generate the same, but also stats for the user's character. The second app also commits the character's class, race and name to a database which persists even after the containers are brought down through the use of a volume.  



![Services relationship](https://imgur.com/2GGDOg8.jpg)

## Asana Board
In order to keep track of my project and it's progress, I used an Asana board. This board also marks the items needed for the Minimum Viable Product (MVP). This also includes completed user stories to allow me to see what I would like the user to be able to do at bare minimum.

![Asana Board](https://imgur.com/eaIHDqz.jpg)

https://app.asana.com/0/1181637805113345/board

## Database
This application only requires a simple table to store information. Data is saved even after the application is brought down and back up via the use of a volume. The following table is used to store data:

![DATA](https://imgur.com/HucMfnU.jpg)

## CI Pipeline  
This first diagram is what I initially imagined the CI Pipeline to look like. 

![First CI Pipeline](https://imgur.com/GKH1nr8.jpg)

This second diagram is what the finalised CI Pipeline looks like. It includes the use of Ansible to configure my machines and Nginx which works as both a reverse proxy and load balancer. 

![Final CI Pipeline](https://imgur.com/vaaHpLQ.jpg)

##  App Design #1

![App 1 Home](https://imgur.com/OKZX2pi.jpg)

The first app just displays a title and generate button. After clicking the generate button, a race, class, and name is displayed to the page. The options for the races and classes are only some of those available in DnD, and the second implementation covers other ones.

![App 2 Generated](https://imgur.com/llVDd5Q.jpg)

## App Design #2
The second implementation is a bit more complex. The page that is displayed to the user is changed, as you can see the text is red.  

![App 2 home page](https://imgur.com/XgmDfkd.jpg)

As I mentioned earlier, the options for class and race are now different compared to the first one.  

As a result, the names generated are different as the name depends on the race passed to it. 

As well as generating different versions of the first app, it also randomly generates stats for the user. It then adds a bonus to their stats depending on their race, as DnD has racial bonuses for stats.  

![App 2 Generated](https://imgur.com/fwXzVKk.jpg)

## Deployment

The deployment of the app is automated and handled different tools such as Jenkins, Ansible and Docker. After making a commit to my GitHub, Jenkins will trigger a pipeline job via webhook. The different stages of the pipeline are outlined in my Jenkinsfile. In order to improve readability, each step refers to a script which handles a different stage of the pipeline. First, Jenkins will checkout the Github repo. It will then run all my unit tests, and if they pass it will move on to the next stage.  

Here, Jenkins will configure my machines with the use of Ansible. My Ansible playbook specifies different roles which allow me to install different requirements depending on what each machine will be responsible for. For every machine, Ansible will install Docker. It will then configure my swarm - creating a swarm on my swarm manager, and joining that swarm on my two worker machines.  

Finally, Jenkins will deploy the application from the swarm manager machine using docker stack. This will balance the load of the containers across the three different machines.

![Successful Pipeline](https://imgur.com/F0sE4BR.jpg)


A failed Pipeline Job will be displayed as such: 

![Failed Pipeline](https://imgur.com/SdeAent.jpg)

## Testing
As part of the project requirement, I also carried out unit testing on both implementations of my application.  

Here you can see the coverage of my tests for each service.

### App 1 Service 1

![1.1](https://imgur.com/Ef0pwze.jpg)

### App 1 Service 2

![1.2](https://imgur.com/nmywWRp.jpg)

### App 1 Service 3

![1.3](https://imgur.com/tNjVRv7.jpg)

### App 1 Service 4

![1.4](https://imgur.com/wvn63Gs.jpg)


### App 2 Service 1

![2.1](https://imgur.com/uo1DyeI.jpg)

### App 2 Service 2

![2.2](https://imgur.com/80aeTyK.jpg)

### App 2 Service 3

![2.3](https://imgur.com/QZbZjIY.jpg)


### App 2 Service 4

![2.4](https://imgur.com/Z97r0uQ.jpg)

## Risk Assessment
I also carried out a risk assessment identifying the potential risks for this project and any mitigation in place. 

![Risk Assessment](https://imgur.com/6Ge9Dhe.jpg)

## Current Issues
There are currently a few issues with the deployment of the application. These are as follows:  

<ul>
  <li>Nginx isn't configured with Ansible</li>
  <li>Sometimes there can be some downtime when deploying the second implementation as containers are being switched out.</li>
  <li>Machines run out of space</li>
</ul>

## Future Improvements
For potential future improvements, I could:  

<ul>
  <li>Add error handling to prevent downtime</li>
  <li>Store stats in database so a complete character is there</li>
  <li>Add a feature so users can query the database to pull a character at any time</li>
  <li>Improve aesthetic</li>
</ul>
