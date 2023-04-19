# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/chris.choy/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker sdk kubectl minikube kube-ps1)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export JAVA_HOME=$(/usr/libexec/java_home)
export DOCKER_HOST=tcp://10.180.46.10:2375
export INTEGRATION_HOST=10.180.46.10
export HOST=${INTEGRATION_HOST}
export TASK_HOST=${INTEGRATION_HOST}
export SBT_EXECUTABLE_NAME=sbt
export DISCOVERY_HOST=${INTEGRATION_HOST};
export REGION=UNITED_STATES
export TENANT_ADMIN_URL=https://frontend.service.imanagecloud.com
export CLIENT_SERVER_URL=https://frontend.service.imanagecloud.com
eval "$(jenv init -)"

export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=stratusstoragepoc;AccountKey=???;EndpointSuffix=core.windows.net"
export AZURE_STORAGE_CONNECTION_STRING2="DefaultEndpointsProtocol=https;AccountName=imanagecloudperftest;AccountKey=???;EndpointSuffix=core.windows.net"

# FORMATTING
alias grep='GREP_COLOR="0;37;41" LANG=C grep --color=auto'
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

alias whichpill='echo -e "You take the ${BLUE}blue pill${NOCOLOR}—the story ends, you wake up in bed and believe whatever you want to believe. You take the ${RED}red pill${NOCOLOR}—you stay in Wonderland, and I show you how deep the rabbit hole goes. Remember: all I’m offering is the ${YELLOW}truth${NOCOLOR}. Nothing more."';

# SHORTCUTS
alias myvm="ssh ubuntu@choy-linuxdev.imanagelabs.com"
alias ll="ls -l"
alias mci="mvn clean install"

## GIT SHORTCUTS
export GITHUB_USERNAME=cchoy96
export GITHUB_API_KEY=???
alias pullall='cwd=`pwd`; for repo in `ls`; do echo -e "${BLUE}${repo}${NOCOLOR}"; cd $repo; git pull; cd $cwd; done; touch last_pullall'
alias cloneall='for i in `seq 1 4`; do curl -s https://$GITHUB_USERNAME:$GITHUB_API_KEY@api.github.com/orgs/imanagedev/repos?per_page=200\&page=$i | jq .[].ssh_url | xargs -n 1 git clone; done'
alias git_project_version="git describe --abbrev=0"
alias gs="git status"
alias go="git checkout"
alias gb="git branch"

# DOCKER SHORTCUTS
alias dockerclean="~/scripts/dockerclean.sh"
alias dockerpurge='docker system prune --volumes'
alias dockerfind="docker ps -a | grep"
function docker_logs_nl {
        docker logs -tf $1 | sed -l -e $'s/__NL__/\\\n/g' | sed -l -e s/ERROR/`printf "\033[1;31mERROR\033[0m"`/ | sed -l -e s/TRACE/`printf "\033[1;35mTRACE\033[0m"`/ | sed -l -e s/DEBUG/`printf "\033[1;36mDEBUG\033[0m"`/ | sed -l -e s/INFO/`printf "\033[1;32mINFO\033[0m"`/ | sed -l -e s/WARN/`printf "\033[1;33mWARN\033[0m"`/
}

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
PROMPT='$(kube_ps1)'$PROMPT
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/Users/chris.choy/.sdkman"
#[[ -s "/Users/chris.choy/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/chris.choy/.sdkman/bin/sdkman-init.sh"
