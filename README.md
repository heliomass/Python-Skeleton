This repository contains a wrapper script to use with your Python projects. It provides a number of shortcuts to help you get up and running quickly:

1. Automatically handles creation of a Python environment
2. Automatically handled pip dependencies
3. Provides a shorter command to execute your Python script

This tool is very much so-called "[MeWare](https://blog.codinghorror.com/usware-vs-themware/)", and it's something I use with every new Python script I develop. It's here in case others find it useful as well.

## Setup

Follow _all_ the steps below for each new project. It assumes you already have a `.py` file which you want to run.

1. Copy the `python-skeleton.sh` wrapper into your project directory.
2. Rename `python-skeleton.sh` to match the name of your Python file.

    For example, if your Python file is named `my_script.py` then rename `python-skeleton.sh` to `my_script.sh`
3. If you have any `pip` dependencies, add them to a new file named `dependencies`. Each dependency should be on its own line. For example:

    ```
    requests
    beautifulsoup4
    Flask
    ```
4. Finally, make the wrapper executable:

    ```
    chmod +x my_script.sh
    ```
   
## Usage

When you want to run your Python script, simply run the wrapper. The first time you run it, it will handle setting up the local Python environment for you. Thereafter it will invoke the environment prior to running your Python code.

All command line arguments are transparently passed through to your Python script, with two exceptions:

- `--environment`: Use this if you want to rebuild your Python environment. There are usually two scenarios where you'd need to do this. Firstly, if you've modified your `dependencies` file then you'll need to do it. Also if you change the version of the `python` executable you're using, you may also need to rebuild the environment.
- `--debug`: Use this to see verbose output from the wrapper as it runs. It will also get passed into your Python script, so you can use it to invoke debugging there as well should you so choose.