# Check Latest Go Version
You can check latest Go Version for any OS like: Linux, macOS or Windows at [Check](https://go.dev/dl/) .
# Install for current version and zsh user commands:
```
wget https://dl.google.com/go/go1.21.3.linux-amd64.tar.gz
sudo tar -xvf go1.21.3.linux-amd64.tar.gz
sudo mv go /usr/local
echo "export GOROOT=/usr/local/go" >> ~/.zshrc
echo "export GOPATH=\$HOME/go" >> ~/.zshrc
echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.zshrc
source ~/.zshrc
```
# Install for bash
```
wget https://dl.google.com/go/go1.23.0.linux-amd64.tar.gz
sudo tar -xvf go1.23.0.linux-amd64.tar.gz
sudo mv go /usr/local
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=\$HOME/go" >> ~/.bashrc
echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
```
