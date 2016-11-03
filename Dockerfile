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

# Create user
RUN adduser ml
USER ml
WORKDIR /home/ml
ENV HOME /home/ml

# Install Pyenv
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN set -ex && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    /bin/bash -c 'source ~/.bashrc'

# Install Anaconda (Jupyter Notebook will be installed as well)
#RUN set -ex && pyenv install anaconda3-4.1.1
RUN set -ex && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p $PYENV_ROOT/versions/anaconda3-4.1.1 && \
    rm ~/anaconda.sh 

ENV PATH $PYENV_ROOT/versions/anaconda3-4.1.1/bin/:$PATH
RUN set -ex && conda update conda

## Making Workind Dir
RUN mkdir workspace

# Run Jupyter Notebook on port 8888
# Add Tini. Tini operates as a process subreaper for jupyter. Prevents Kernel Crash
# http://jupyter-notebook.readthedocs.io/en/latest/public_server.html
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
