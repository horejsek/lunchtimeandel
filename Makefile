
CLOSURE_LIBRARY=libs/closure-library/
CLOSURE_COMPILER=libs/closure-compiler.jar
SOY_COMPILER=libs/closure-templates/SoyToJsSrcCompiler.jar
SOY_MSG_EXTRACTOR=libs/closure-templates/SoyMsgExtractor.jar

PORT=3000

FOREVER=/usr/local/bin/forever

all:
	@echo "make run"
	@echo "make run-forever"
	@echo "make test"
	@echo "make compile"
	@echo "make watch"
	@echo "make localdev"

run: compile-coffeescript
	# Make sure that nothing is running on port $(PORT).
	$(eval pid := `lsof -i tcp:$(PORT) | grep LISTEN | cut -d" " -f2`)
	if [ $(pid) ]; then kill $(pid); fi
	cd backend; supervisor lunchtime.js

run-forever: compile-coffeescript
	- cd backend; $(FOREVER) stop lunchtime.js
	cd backend; $(FOREVER) start lunchtime.js

test:
	mocha tests

compile: compile-coffeescript compile-templates compile-javascript
compile-coffeescript:
	coffee -cb ./backend ./frontend ./tests
compile-templates:
	java -jar $(SOY_COMPILER) \
	    --shouldProvideRequireSoyNamespaces \
	    --shouldGenerateGoogMsgDefs \
	    --bidiGlobalDir 1 \
	    --outputPathFormat frontend/templates/template.js \
	    --srcs frontend/templates/template.soy
	java -jar libs/XtbGenerator.jar \
	    --lang cs \
	    --translations_file frontend/templates/messages.xtb \
	    --xtb_output_file frontend/templates/messages.xtb \
	    --js frontend/templates/template.js
compile-javascript:
	python $(CLOSURE_LIBRARY)/closure/bin/calcdeps.py \
	    --compiler_jar $(CLOSURE_COMPILER) \
	    --output_mode compiled \
	    --path $(CLOSURE_LIBRARY) \
	    --path="libs/closure-templates/soyutils_usegoog.js" \
	    --path="frontend/templates/template.js" \
	    --input="frontend/scrolling.js" \
	    --input="frontend/restaurant.js" \
	    --input="frontend/choicehelp.js" \
	    --input="frontend/restaurants.js" \
	    --input="frontend/search.js" \
	    --input="frontend/api.js" \
	    --compiler_flags="--translations_file=frontend/templates/messages.xtb" \
	    --compiler_flags="--externs=frontend/externs/googlemapsv3.js" \
	    --compiler_flags="--warning_level=VERBOSE" \
	    --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" \
	    > public/app.min.js;

watch:
	coffee --watch -cb ./backend ./frontend ./tests &
	sleep 1
	mocha tests --watch

install-dependencies:
	apt-get install mongodb curl openjdk-7-jre
	curl https://npmjs.org/install.sh | bash
	npm install
	npm install forever supervisor mocha -g
