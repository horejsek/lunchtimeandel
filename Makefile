
CLOSURE_LIBRARY=libs/closure-library/
CLOSURE_COMPILER=libs/closure-compiler.jar
SOY_COMPILER=libs/closure-templates/SoyToJsSrcCompiler.jar
SOY_MSG_EXTRACTOR=libs/closure-templates/SoyMsgExtractor.jar

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

compile: compile-coffeescript compile-templates compile-javascript
compile-coffeescript:
	coffee -cb ./
compile-templates:
	java -jar $(SOY_COMPILER) \
	    --shouldProvideRequireSoyNamespaces \
	    --shouldGenerateGoogMsgDefs \
	    --bidiGlobalDir 1 \
	    --outputPathFormat javascripts/template.js \
	    --srcs javascripts/template.soy
	java -jar libs/XtbGenerator.jar \
	    --lang cs \
	    --translations_file javascripts/messages.xtb \
	    --xtb_output_file javascripts/messages.xtb \
	    --js javascripts/template.js
compile-javascript:
	python $(CLOSURE_LIBRARY)/closure/bin/calcdeps.py \
	    --compiler_jar $(CLOSURE_COMPILER) \
	    --output_mode compiled \
	    --path $(CLOSURE_LIBRARY) \
	    --path="libs/closure-templates/soyutils_usegoog.js" \
	    --path="javascripts/template.js" \
	    --input="javascripts/restaurant.js" \
	    --input="javascripts/choicehelp.js" \
	    --input="javascripts/restaurants.js" \
	    --input="javascripts/search.js" \
	    --input="javascripts/api.js" \
	    --compiler_flags="--translations_file=javascripts/messages.xtb" \
	    --compiler_flags="--externs=javascripts/externs/googlemapsv3.js" \
	    --compiler_flags="--warning_level=VERBOSE" \
	    --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" \
	    > public/app.min.js;

watch:
	coffee --watch -cb ./

install-dependencies:
	apt-get install mongodb curl openjdk-7-jre
	curl https://npmjs.org/install.sh | bash
	npm install
	npm install forever supervisor -g

