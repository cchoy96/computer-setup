export JAVA_HOME=$(/usr/libexec/java_home)
#export DOCKER_HOST=tcp://10.180.46.10:2375
export INTEGRATION_HOST=10.180.46.10
export HOST=${INTEGRATION_HOST}
export TASK_HOST=${INTEGRATION_HOST}
export SBT_EXECUTABLE_NAME=sbt
export DISCOVERY_HOST=${INTEGRATION_HOST};
export REGION=UNITED_STATES
export TENANT_ADMIN_URL=https://frontend.service.imanagecloud.com
export CLIENT_SERVER_URL=https://frontend.service.imanagecloud.com
eval "$(jenv init -)"

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
function read_logs_nl {
    cat $1 | sed -l -e $'s/__NL__/\\\n/g' | sed -l -e s/ERROR/`printf "\033[1;31mERROR\033[0m"`/ | sed -l -e s/TRACE/`printf "\033[1;35mTRACE\033[0m"`/ | sed -l -e s/DEBUG/`printf "\033[1;36mDEBUG\033[0m"`/ | sed -l -e s/INFO/`printf "\033[1;32mINFO\033[0m"`/ | sed -l -e s/WARN/`printf "\033[1;33mWARN\033[0m"`/
}
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/Users/chris.choy/.sdkman"
#[[ -s "/Users/chris.choy/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/chris.choy/.sdkman/bin/sdkman-init.sh"
