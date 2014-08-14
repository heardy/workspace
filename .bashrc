alias subl='cmd //C C:\\Program\ Files\\Sublime\ Text\ 3\\sublime_text.exe'
alias rebash='source ~/.bashrc'
alias rb=rebash
alias eb='subl ~/.bashrc'

alias gc='git checkout'
alias gd='git checkout develop'

alias gw='grunt watch'

alias cdw='cd /c/git'
alias cdm='cdw && cd makingmoney'
alias cdmw='cdm && cdweb'
alias cdt='cdw && cd top-gear'
alias cdtw='cdt && cdweb'

function cdweb() {
	FOLDER=`find . -type d -maxdepth 1 -regex ".*Bauer.*Web"`
	cd $FOLDER
}

function sln() {
	FILE=`find . -maxdepth 1 -regex ".*Bauer.*Web.sln"`
	cmd //c msbuild.exe $FILE
}

function msbuild() {
	cd bauerdigital
	git pull
	cd -
	cmd //c msbuild.exe bauerdigital\\BauerDigital.sln

	cd cms
	git pull
	cd -
	cmd //c msbuild.exe cms\\Bauer.Umbraco.Cms.sln

	FILE=`find . -maxdepth 1 -regex ".*Bauer.*Web.sln"`
	cmd //c msbuild.exe $FILE
}

function dmsbuild() {
	cd bauerdigital
	git checkout develop-v3
	git pull
	cd -
	cmd //c msbuild.exe bauerdigital\\BauerDigital.sln

	cd cms
	git checkout develop
	git pull
	cd -
	cmd //c msbuild.exe cms\\Bauer.Umbraco.Cms.sln

	FILE=`find . -maxdepth 1 -regex ".*Bauer.*Web.sln"`
	cmd //c msbuild.exe $FILE
}

function submodule() {
	cd bauerdigital
	git clean -fxd
	
	cd ../cms/packages
	git clean -fxd
	git checkout .
	cd ..
	git clean -fxd

	cd ../packages
	git checkout .
	git clean -fxd

	cd ..
	git submodule update --init --recursive
}

function sc() {
	echo -n "Enter Jira # (eg ABCPRJ-1): "
	read JIRA
	echo -n "Enter Time (eg: 1h): "
	read TIME
	echo -n "Enter Comment: "
	read COMMENT
	MESSAGE="$JIRA #time $TIME $COMMENT #comment $COMMENT"
	echo -n "Enter to commit or CRTL+C to exit. Message: $MESSAGE"
	read GO
	git commit -m "$JIRA #time $TIME $COMMENT #comment $COMMENT"
}

function gupdate() {
	rm -rf ./cms ./packages ./bauerdigital
	git checkout $2 # branch to update from
	git pull
	git checkout $1 # branch to update to
	git merge develop
	git submodule update --init --recursive
	cd bauerdigital
	git checkout develop-v3
	cd ../cms
	git checkout develop
	cd ..
	cmd //c msbuild.exe bauerdigital\\BauerDigital.sln
	cmd //c msbuild.exe cms\\Bauer.Umbraco.Cms.sln
	echo "Now:"
	echo "- check that all the projects loaded"
	echo "- right click 'reload' if one didn't"
	echo "- compile the project you're working on and it should build"
	echo "- run the project in your browser."
	echo "\n"
	echo "Good luck, that's all I can do for you."
}
