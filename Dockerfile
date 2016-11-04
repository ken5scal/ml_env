FROM ubuntu:latest
MAINTAINER Kengo Suzuki

# Install Required Packages
RUN set -ex && apt-get update && apt-get install -y \
    man \
    vim \
    aria2 \
    curl \
    wget \
    bzip2 \
    git

ENV HOME /root

# Install Pyenv
RUN git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN set -ex && \
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc && \
    /bin/bash -c 'source $HOME/.bashrc'

# Install Anaconda (Jupyter Notebook will be installed as well)
#RUN set -ex && pyenv install anaconda3-4.1.1
RUN set -ex && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh -O $HOME/anaconda.sh && \
    /bin/bash $HOME/anaconda.sh -b -p $PYENV_ROOT/versions/anaconda3-4.1.1 && \
    rm ~/anaconda.sh 

ENV PATH $PYENV_ROOT/versions/anaconda3-4.1.1/bin/:$PATH
RUN set -ex && conda update conda


# Run Jupyter Notebook on port 8888
# Add Tini. Tini operates as a process subreaper for jupyter. Prevents Kernel Crash
# http://jupyter-notebook.readthedocs.io/en/latest/public_server.html
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

RUN mkdir $HOME/workspace
WORKDIR /$HOME/workspace
EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
