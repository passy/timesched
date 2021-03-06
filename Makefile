all: compress

compress: lib/generated/data.js
	uglifyjs \
		lib/jquery.js \
		lib/jquery-ui.js \
		lib/angular.js \
		lib/bootstrap/js/bootstrap.js \
		lib/sortable.js \
		lib/slider.js \
		lib/ui-bootstrap.js \
		lib/ui-bootstrap-tpls.js \
		lib/moment.js \
		lib/moment-timezone.js \
		lib/typeahead.js \
			> lib/generated/compressed.js
	uglifyjs \
		lib/generated/data.js \
			> lib/generated/compressed-data.js

download-timezone-info:
	wget https://raw.github.com/moment/moment-timezone/develop/moment-timezone.json -O data/timezones.json

lib/generated/data.js: data/*.json
	python data/convert.py

upload:
	rm -rf _deploy
	mkdir _deploy
	cp timesched.html _deploy/index.html
	cp -R lib _deploy
	cp -R static _deploy
	rsync -a _deploy/ pocoo.org:/var/www/timesched.pocoo.org/
	rm -rf _deploy

.PHONY: compress download-timezone-info upload
