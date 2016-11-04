% docker pull ubuntu                                                                                         (git)-[master]

apt-get update
apt-get -y upgrade

# Dependencies
apt-get install -y man
apt-get install -y vim
apt-get install -y aria2
apt-get install -y curl
apt-get install -y wget
apt-get install -y bzip2

# Git
apt-get -y install git
git config --global user.name "Kengo Suzuki"
git config --global user.email "kengoscal@gmail.com"

# Pyenv install
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Anaconda Install(Jupyterもインスコされる)
pyenv install anaconda3-4.1.1 # Latest Anaconda
echo 'export PATH="$PYENV_ROOT/versions/anaconda3-4.1.1/bin/:$PATH"' >> ~/.bashrc
conda update conda # Just Making sure to update conda -y

# Workding Dir
mkdir workspace

# Run Jupyter Notebook
jupyter notebook --port=8888 --no-browser --ip=0.0.0.0
