#!/bin/bash
set -e

install_nvm() {
  # Check if nvm is installed
  if ! command -v nvm &> /dev/null; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

    # Source NVM scripts for the current session
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

    # Add NVM initialization to shell startup file
    if [ -n "$BASH_VERSION" ]; then
      SHELL_PROFILE="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
      SHELL_PROFILE="$HOME/.zshrc"
    fi

    if ! grep -q 'export NVM_DIR="$HOME/.nvm"' "$SHELL_PROFILE"; then
      echo 'export NVM_DIR="$HOME/.nvm"' >> "$SHELL_PROFILE"
      echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$SHELL_PROFILE"
      echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> "$SHELL_PROFILE"
    fi
  else
    echo "NVM is already installed."
  fi

  # Source NVM scripts (if not sourced already)
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

  # Install Node.js version 21.7.1 using nvm
  echo "Installing Node.js version 21.7.1..."
  nvm install 21.7.1

  # Use the installed Node.js version
  nvm use 21.7.1

  # Verify the installation
  node_version=$(node --version)
  if [[ $node_version == v21.7.1 ]]; then
    echo "Node.js version 21.7.1 installed successfully: $node_version"
  else
    echo "There was an issue installing Node.js version 21.7.1."
  fi

  source ~/.bashrc

  npm install --global yarn
  npm install --global pm2

  source ~/.bashrc
}

echo "___________________"
echo "APPLYING UPDATE"

install_nvm
cp -r ./plugins /root/TAOevmCore/
rm /root/TAOevmCore/node-start.sh
rm /root/TAOevmCore/node-setup.sh
rm /root/TAOevmCore/node-stop.sh
cp ./node-start.sh /root/TAOevmCore
cp ./node-setup.sh /root/TAOevmCore
cp ./node-stop.sh /root/TAOevmCore


cd /root/TAOevmCore/plugins/sync-helper
yarn
cd ../../


echo "___________________"
echo "UPDATE COMPLETE"