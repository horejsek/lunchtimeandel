
CLOSURE_LIBRARY=libs/closure-library/
CLOSURE_COMPILER=libs/closure-compiler.jar

PORT=3000

FOREVER=/usr/local/bin/forever

all:
	@echo "make run"
	@echo "make watch"
	@echo "make localdev"

run: compile-coffeescript
	# Make sure that nothing is running on port $(PORT).
	$(eval pid := `lsof -i tcp:$(PORT) | grep LISTEN | cut -d" " -f2`)
	if [ $(pid) ]; then kill $(pid); fi
	supervisor lunchtime.js

run-forever: compile-coffeescript
	- $(FOREVER) stop lunchtime.js
	$(FOREVER) start lunchtime.js

compile: compile-coffeescript compile-javascript
compile-coffeescript:
	coffee -cb ./
compile-javascript:
	python $(CLOSURE_LIBRARY)/closure/bin/calcdeps.py \
	    --path $(CLOSURE_LIBRARY) \
	    --compiler_jar $(CLOSURE_COMPILER) \
	    --output_mode compiled \
	    --input="public/javascripts/restaurant.js" \
	    --input="public/javascripts/restaurants.js" \
	    --input="public/javascripts/search.js" \
	    --compiler_flags="--externs=public/javascripts/externs/googlemapsv3.js" \
	    --compiler_flags="--warning_level=VERBOSE" \
	    --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" \
	    > public/javascripts/app.min.js;

watch:
	coffee --watch -cb ./

install-dependencies:
	apt-get install mongodb curl openjdk-7-jre
	curl https://npmjs.org/install.sh | bash
	npm install
	npm install forever supervisor -g

