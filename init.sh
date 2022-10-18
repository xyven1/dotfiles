sudo apt update && sudo apt upgrade -y
sudo apt install build-essential -y

cat .tool-versions >> ~/.tool-versions
cat .bashrc >> ~/.bashrc
cat .bash_aliases >> ~/.bash_aliases

rm -rf ~/.asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
asdf update
echo $'\n# asdf config' >> ~/.bashrc
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
. ~/.bashrc

cat ~/.tool-versions | cut -d' ' -f1 | grep "^[^\#]" | xargs -i asdf plugin add {}
asdf install
