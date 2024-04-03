#!/bin/bash

# Define a variable CMD_PREFIX that is set to "sudo" if the user is not root
if [ "$(id -u)" != "0" ]; then
    CMD_PREFIX="sudo"
else
    CMD_PREFIX=""
fi

# Update and Install Zsh, curl, git, wget, zip
${CMD_PREFIX} apt-get update
${CMD_PREFIX} apt-get install -y zsh curl git wget zip

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Clone the necessary plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add plugins to .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-history-substring-search zsh-autosuggestions)/' ~/.zshrc

# Download and install Oh My Posh
mkdir -p ~/.local/bin
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

# Add Oh My Posh init command to .zshrc
echo 'eval "$($HOME/oh-my-posh init zsh --config $HOME/.poshthemes.omp.json)"' >> ~/.zshrc
echo 'eval "$($HOME/.local/bin/oh-my-posh init zsh --config $HOME/themes/jonnychipz.omp.json)"' >> ~/.zshrc


# Change default shell to Zsh
chsh -s $(which zsh)

echo "Installation complete. Please log out and log back in for the default shell change to take effect."
