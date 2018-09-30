
# About the JupyterLab Setup repo

This repository has the purpose of provide instructions for install the JupyterLab environment with the basic configuration for make LaTex document in IEEE format.

The instructions are tested in a clean Ubuntu 18.04 installation but these can be implemented in any Linux distribution based on Debian. 

For Mac and Windows users you have 3 options:
- Install Ubuntu (or any Linux distribution based on Debian)
    - In your machine. :heart:
    - In a virtual machine with VirtualBox. :thumbsup:
- Interpret the instructions to perform them in your machine. :alien:

## About JupyterLab

[JupyterLab](https://jupyterlab.readthedocs.io/en/stable/)
is a web-based user interface for 
[Project Jupyter](https://jupyter-notebook.readthedocs.io/en/stable/),
a project that provides an open-source web application for the creation of digital notebook documents that combine live runnable code with narrative text (Markdown), equations (LaTeX), images, interactive visualizations and other rich output.

![JupyterLab Interface](images/jupyterlab.png)

The Notebook has support for over 40 programming languages, including Python, R, Julia, and Scala.

Your code can produce rich, interactive output: HTML, images, videos, LaTeX, and custom MIME types.

JupyterLab offers a notebook, terminal, text editor, file browser, rich outputs and others components in a flexible and powerful user interface. 


# Getting started

## Python installation :snake:

We consider working with the most recent
[Python](https://www.python.org/downloads/) version
that at this time (september, 2018) is `3.7.0`.

If you prefer to work with the Python version of your system it is not necessary to perform the next steps.

For Linux it is necessary build and install Python from sources.

The following instructions install the necessary packages to compile the python specified version from the downloaded sources for later installation.

```
sudo apt update

v=3.7.0

sudo apt install -y --no-install-recommends \
gcc \
libbz2-dev \
libffi-dev \
libgdbm-dev \
liblzma-dev \
libncursesw5-dev \
libreadline-dev \
libsqlite3-dev \
libssl-dev \
tk-dev \
uuid-dev

wget https://www.python.org/ftp/python/$v/Python-$v.tar.xz
tar -xf ./Python-$v.tar.xz
cd Python-$v
./configure
make -j $(nproc)
sudo make altinstall
cd ..
rm ./Python-$v.tar.xz
sudo rm -rf ./Python-$v
```

The 
[install_python.sh](install_python.sh) script contains the above instructions, you can execute it with the following instruction :wink:.

```
wget https://raw.githubusercontent.com/ITTcs/jupyterlab_setup/master/install_python.sh && chmod 755 ./install_python.sh && ./install_python.sh && rm ./install_python.sh
```

### Virtualenv Installation

Next we will install `virtualenv` that is a tool to create isolated Python environments.

```
python3.7 -m pip install --user virtualenv
sudo apt install python3-distutils

echo "PATH=\$PATH:~/.local/bin" >> ~/.bashrc
source ~/.bashrc
virtualenv py37
```

# JupyterLab installation 

First we need to activate our environment.
```
source ~/py37/bin/activate
```

We installed JupyterLab through `pip`

```
pip install jupyterlab
```


## Configuration

### TEX Live installation
```
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf ./install-tl-unx.tar.gz
cd ./install-tl-2018...
sudo ./install-tl
I
```
Once finished add the installation directory to the `PATH` variable

```
echo "PATH=\$PATH:/usr/local/texlive/2018/bin/x86_64-linux" >> ~/.bashrc
source ~/.bashrc
tex --version
```


### JupyterLab LaTeX extension

#### Installation

In our Python environment we install `jupyterlab_latex`

```
pip install jupyterlab_latex
sudo apt install nodejs npm pandoc
jupyter labextension install @jupyterlab/latex
jupyter labextension install @jupyterlab/toc
```

#### Configuration

```
mkdir ~/.jupyter
echo "c.LatexConfig.latex_command = 'pdflatex'" >> ~/.jupyter/jupyter_notebook_config.py
```

## Test JupyterLab LaTeX

Download an IEEEtran tex file example
```
wget http://mirrors.ctan.org/macros/latex/contrib/IEEEtran/bare_conf.tex
```

Start up JupyterLab using:
```
jupyter lab
```
JupyterLab will open automatically in your browser. 

Open the `bare_conf.tex` file, make a right click in the text editor and choose `Show LaTex Preview`.

A PDF file will be displayed.

# Jupyter Notebook to PDF using LaTex IEEEtran class

To convert a Notebook to LaTex or PDF, Jupyter use the 
[article](https://github.com/jupyter/nbconvert/blob/master/nbconvert/templates/latex/article.tplx) 
template by default.

You can specify which template to use with the argument `--template`, for example, to use the 
[report](https://github.com/jupyter/nbconvert/blob/master/nbconvert/templates/latex/report.tplx) template:

```
jupyter nbconvert --to pdf --template report notebook.ipynb
```

You can design your own templates, we design a template using the LaTex IEEEtran.

We make a Notebook based in the `bare_conf.tex` file structure with embedded Python code and References.

```
git clone https://github.com/ITTcs/ieee_jupyter_latex_template.git
```

Now you can show the `notebook.ipynb` and convert this to pdf.

```
jupyter nbconvert --to pdf --template ieee_conf_onecolumn notebook.ipynb
```

The `notebook.pdf` file will be created.
