Step-by-step guide here: https://dev.to/pavanbelagatti/deploy-any-aiml-application-on-kubernetes-a-step-by-step-guide-2i37
1. Create a VM called **myworkstation** (I created basic Debian image) 

2. **SSH into it from Cloud Shell**: _gcloud compute ssh --zone "asia-south1-c" "myworkstation" --project "tf-proj-21"_

3. **Run** _sudo apt-get update_

4. **Install the docker desktop** on this machine.
   4.1 Refer this link: https://docs.docker.com/desktop/install/debian/ 
   4.2 It displays the below message, which confirms the docker is installed correctly
   ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/ffa0607a-48e3-4681-870d-6f7f7c22f84b)

5. Install **minikube** by following the steps at below link: https://minikube.sigs.k8s.io/docs/start/
   5.1 Encountered below errors while running the **minikube start** command
       ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/6c259848-db1e-4c8a-bc30-357a8c0ba5fa)
   5.2 To resolve this ran the command: **sudo usermod -aG docker $USER && newgrp docker**
   5.3 This started downloading kubernetes and showed a confirmation message
       ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/00129afc-776f-4ca1-bdec-2d407f8a3191)
   5.4 Now interact with your cluster by running the commands
       5.4.1 minikube start
       5.4.2 kubectl get po -A   This showed an error bash: kubectl: command not found
       5.4.3 "Promise Preston's" answer at https://stackoverflow.com/questions/55360666/kubernetes-kubectl-run-command-not-found fixed the error
       5.4.4 Typing kubectl get po -A gave the below screen
             ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/71c4d78e-e65e-4f94-bdd2-f276aaaf81d7)

6. **Install node.js** using the command: sudo apt install nodejs npm -y 
       6.1 **Run -v to check the version of Node.js and NPM, verifying that packages have been installed:** node -v
       6.2 **Verify the NPM installation with:** npm -v
   
7. **Sign up for a free SingleStore database cloud account to integrate our application with a database.**
   
8. **Clone the repository on your VM:** git clone https://github.com/pavanbelagatti/openai-quickstart-node.git 
 
9. **Install the project requirements and dependencies:** npm install

10. **Create a .env file** (touch .env) and **add your OpenAI API key to it using command:** OPENAI_API_KEY=<yourKey> Please note you'll need to sign-up at https://platform.openai.com/ for this.

11. The npm run dev command resulted in below error.
    ![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/1f99c66a-8911-417e-991a-0ba44da2c1f2)

12. Please note: **Node** is a runtime environment that allows developers to execute JavaScript code outside the browser, on the server-side. **NPM**, on the other hand, is a package manager for publishing JavaScript packages (also known as Node modules) to the npm registry. Just a side note if you want to find your directory, use command find / -type d -name '<dir-name>'       

13. **NEED TO INCREASE DIRECTORY SIZE as error while running npm run dev command**
14. sd
15. s
16. ds
17. ds
18. ds
19. ds
20. ds
21. d
22. sd
23. sd
24. sd
25. sd
26. sd
27. sd 

