FILE=~/.tool-versions
if ! command -v <the_command> &> /dev/null
then
  asdf update

  cat ~/.tool-versions | cut -d' ' -f1 | grep "^[^\#]" | xargs -i asdf plugin add {}
  asdf install
  cat ~/.tool-versions | xargs -l bash -c 'asdf global $0 $1'
  rm -rf ~/.temp_init

  asdf direnv setup --shell bash --version latest
  echo "Done setting things up. Please restart your machine to get everything working"
else
  sudo apt update && sudo apt upgrade -y
  sudo apt install build-essential git -y
  
  if [[ -f $FILE ]]; then
    git clone https://github.com/Xyven1/dotfiles.git ~/.temp_init
    cd ~/.temp_init
    cat .tool-versions >> ~/.tool-versions
    cat .bashrc >> ~/.bashrc
    cat .bash_aliases >> ~/.bash_aliases
    sudo touch /.envrc
    cat .envrc | sudo tee -a /.envrc
    rm -rf ~/.asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    echo '\n# asdf config' >> ~/.bashrc
    echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
  fi
  echo "Please source .bashrc and then run this command again"
fi
