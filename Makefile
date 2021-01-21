NANOC      = bundle exec nanoc
GUARD      = bundle exec guard
DOWNLOADS := docs caduceus svalinn gungnir fenrir heimdall

build: bundle

bundle: compile
	bundle config build.nokogiri --use-system-libraries
	bundle config set path 'vendor'
	bundle install

CNAME:
	echo "xmidt.io" > docs/CNAME

clean:
	rm -rf docs \
           downloads \
           repositories \
           content/docs/codex/swagger.html \

    
clean-all: clean
	rm -rf vendor tmp

compile: downloads swagger CNAME
	$(NANOC)

downloads: $(DOWNLOADS:%=downloads/%/repo.json) $(DOWNLOADS:%=downloads/%/releases.json)

downloads/%/repo.json:
	@mkdir -p $(dir $@)
	@echo "curl -sf -H 'Accept: application/vnd.github.v3+json' <GITHUB_AUTHENTICATION> https://api.github.com/repos/xmidt-org/$* > $@"
	@curl -sf -H 'Accept: application/vnd.github.v3+json' $(GITHUB_AUTHENTICATION) https://api.github.com/repos/xmidt-org/$* > $@

downloads/%/releases.json:
	@mkdir -p $(dir $@)
	@echo "curl -sf -H 'Accept: application/vnd.github.v3+json' <GITHUB_AUTHENTICATION> https://api.github.com/repos/xmidt-org/$*/releases > $@"
	@curl -sf -H 'Accept: application/vnd.github.v3+json' $(GITHUB_AUTHENTICATION) https://api.github.com/repos/xmidt-org/$*/releases > $@

guard:
	$(GUARD)

serve:
	$(NANOC) view

swagger-codex: 
	npx redoc-cli  bundle -o tmp.html --title "Codex Documentation" content/docs/codex/codex.yaml
	echo -e "---\ntitle: Swagger\nsort_rank: 15\n---" > content/docs/codex/swagger.html
	cat tmp.html >> content/docs/codex/swagger.html
	rm tmp.html

swagger: swagger-codex

.PHONY: build bundle clean clean-all compile downloads serve swagger swagger-codex
