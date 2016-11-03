FROM ubuntu:latest
MAINTAINER Kengo Suzuki

# Make Packages Latest
RUN set -ex && \
    apt-get update  && \
    apt-get -y upgrade

# Install Required Packages
RUN set -ex && \
    apt-get install -y man  && \
    apt-get install -y vim  && \
    apt-get install -y aria2  && \
    apt-get install -y curl  && \
    apt-get install -y wget  && \
    apt-get install -y bzip2  && \
    apt-get install -y git

# Install Pyenv
RUN set -ex && \
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc 

RUN /bin/bash -c "source ~/.bashrc"

# Install Anaconda (Jupyter Notebook will be installed as well)
#RUN set -ex && \
#    pyenv install anaconda3-4.1.1 # Latest Anaconda && \
#    echo 'export PATH="$PYENV_ROOT/versions/anaconda3-4.1.1/bin/:$PATH"' >> ~/.bashrc && \
#    conda update conda # Just Making sure to update conda -y
#
## Making Workind Dir
#RUN mkdir workspace
#
## Run Jupyter Notebook on port 8888
## Add Tini. Tini operates as a process subreaper for jupyter. Prevents Kernel Crash
## http://jupyter-notebook.readthedocs.io/en/latest/public_server.html
#ENV TINI_VERSION v0.6.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
#RUN chmod +x /usr/bin/tini
#ENTRYPOINT ["/usr/bin/tini", "--"]
#
#EXPOSE 8888
#CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
