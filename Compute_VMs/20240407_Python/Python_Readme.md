- References: https://cloud.google.com/python/docs/getting-started/getting-started-on-compute-engine
- Run command: gcloud compute ssh my-bq-instance
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/7cc2259f-87d3-409e-b0f3-7dff38b2f1ec)

- **[Set-up Python environment in VM](https://cloud.google.com/python/docs/setup#linux)**:
  - Run below commands: 
    **sudo apt update**

    **sudo apt install python3 python3-dev python3-venv**

  -  Install pip package using below commands:
      **sudo apt-get install wget**
     
      **wget https://bootstrap.pypa.io/get-pip.py**

      **sudo python3 get-pip.py**

  - Check the pip3 version: **pip3 --version**

  - **Using venv to isolate dependencies**:
    - [venv](https://docs.python.org/3/library/venv.html) is a tool that creates isolated Python environments to isolate one project's dependencies from the other.
    - Run the **venv command** to create a virtual copy of entire Python installation in a **folder named "env"**, but you can specify any name for the folder.
        python3 -m venv env
    - Set your **shell to use the venv paths** for Python by activating the virtual environment: **source env/bin/activate**
    - Now you can **install packages without affecting other projects** or your global Python installation: **pip install google-cloud-storage**
    - If you want to **stop using the virtual environment** and go back to your global Python, you can deactivate it: **deactivate**   

- To **develop Python apps**, you need an **editor e.g. nano, [Visual Studio Code](https://code.visualstudio.com/), Sublime Text, Atom, [PyCharm](https://www.jetbrains.com/pycharm/)**
- To test the environment, simply try running a Hello World app: **python main.py**
- If this doesn't work:

![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/a0a3ca1a-9af2-48d3-8ee9-3190b2688b3f)
 
- Simply run: **python3 main.py**
![image](https://github.com/Ajit1279/GCP_Learning/assets/81754034/674cb5a7-4aa0-496b-a9e7-9cc0513fb92e)
