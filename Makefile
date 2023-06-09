VERSION ?= 0.1.0

clean:
	find dist/* -not -path "dist/userscript*" -prune -exec rm -rf {} \;

change-version:
	sed -i -e "s/\"version\": \".*\"/\"version\": \"$(VERSION)\"/" public/manifest.json
	sed -i -e "s/\"version\": \".*\"/\"version\": \"$(VERSION)\"/" public/manifest.firefox.json
	sed -i -e "s/\"version\": \".*\"/\"version\": \"$(VERSION)\"/" src-tauri/tauri.conf.json
	sed -i -e "s/\"version\": \".*\"/\"version\": \"$(VERSION)\"/" package.json
	sed -i -e "s/\/\/ @version.*/\/\/ @version $(VERSION)/" public/userscript.js
	sed -i.js-e -E 's|openai-translator@[^/]+|openai-translator@v$(VERSION)|g' public/userscript.js

build: clean change-version
	node build.mjs
