
PORT=3000

all:
	@echo "make run"
	@echo "make watch"
	@echo "make localdev"

run: compile
	# Make sure that nothing is running at port $(PORT).
	$(eval pid := `lsof -i tcp:$(PORT) | grep LISTEN | cut -d" " -f2`)
	if [ $(pid) ]; then kill $(pid); fi
	coffee --watch -c ./ &
	supervisor app.js

compile:
	coffee -cb ./

watch:
	coffee --watch -c ./

localdev:
	npm install
	npm install supervisor -g
	apt-get install mongodb

