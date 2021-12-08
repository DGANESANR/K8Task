# Only allow root user to execute the script.
if [ `whoami` == 'root' ]; then
  sleep 1;
else
  printf "Please run this script as root or sudo.\n\n";
  exit 1;
fi
#To remove the existing packages
apt-get remove docker docker-engine docker.io containerd runc

#Refresh the update packages
apt-get update

#Installing the prerequisites
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
	
#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#Repo Addition
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
#refresh repo
apt-get update

#pull the packages for installation
apt-get install docker-ce docker-ce-cli containerd.io
apt-get clean

#Testing the installation 
docker run hello-world
