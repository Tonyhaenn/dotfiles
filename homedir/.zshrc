# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh
# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
#POWERLEVEL9K_MODE`='awesome-patched'
export ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status docker_machine)
# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_NVM_FOREGROUND='000'
POWERLEVEL9K_NVM_BACKGROUND='072'
POWERLEVEL9K_SHOW_CHANGESET=true
#export ZSH_THEME="random"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize compleat dirpersist autojump git gulp history cp)

source $ZSH/oh-my-zsh.sh

source /usr/local/opt/nvm/nvm.sh

autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    nvm use default &> /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Customize to your needs...
unsetopt correct

###
# http://peterlyons.com/problog/2012/09/managing-per-project-interpreters-and-the-path
#This helper function will add a directory to the PATH if it exists
#This is a simple way to handle different machines, OSes, and configurations
add_path() {
    if [ -d "${1}" ]; then
        if [ -z "${PATH}" ]; then
            export PATH="${1}"
        else
          export PATH=$PATH:"${1}"
        fi
    fi
}

setup_path() {
  PATH=
  # Normal system stuff comes first for security
  # So npm packages can't override basic commands like ls

  # Homebrew
  add_path "/usr/local/bin"

  add_path "/bin"
  add_path "/usr/bin"
  add_path "/sbin"
  add_path "/usr/sbin"
  add_path "/usr/X11/bin"

  # Personal home dir stuff
  add_path "${HOME}/bin"
  add_path "${HOME}/scripts"

  # Local pwd stuff
  add_path "${PWD}/script"
  add_path "${PWD}/bin"

  # For node
  add_path "${PWD}/node_modules/.bin"
  add_path "${HOME}/shared_node.js/node_modules/.bin"
  add_path "${HOME}/shared_node.js/node/bin"

  # For per-project python virtualenvs
  add_path "${PWD}/python/bin"
  add_path "${PWD}/env/bin"

  add_path "${HOME}/.rbenv/bin"

  export PATH
  [[ -d "${HOME}/.rbenv/bin" ]] && eval "$(rbenv init -)"
}
# Run this during shell startup.
# Can be re-run as needed manually as well
setup_path
###
