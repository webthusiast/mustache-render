bin/render.js: render.js | bin
	echo '#!/usr/bin/env node' | cat - $< > $@

render.js: render.coffee
	coffee -c $<

bin:
	mkdir -p $@
