
PORT=3000

all:
	@echo "make run"
	@echo "make watch"
	@echo "make localdev"

run: compile
	# Make sure that nothing is running on port $(PORT).
	$(eval pid := `lsof -i tcp:$(PORT) | grep LISTEN | cut -d" " -f2`)
	if [ $(pid) ]; then kill $(pid); fi
	supervisor app.js

run-forever: compile
	- forever stop app.js
	forever start app.js

compile:
	coffee -cb ./

watch:
	coffee --watch -c ./

install-dependencies:
	apt-get install mongodb curl openjdk-7-jre
	curl https://npmjs.org/install.sh | bash
	npm install
	npm install forever supervisor -g
