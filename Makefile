NANOC      = bundle exec nanoc
GUARD      = bundle exec guard
DOWNLOADS := docs caduceus svalinn gungnir fenrir heimdall

SWAGGER = \
    content/docs/codex/swagger.html \
    content/docs/webpa/swagger.html

.DEFAULT_GOAL := build

bundle:
	bundle config build.nokogiri --use-system-libraries
	bundle config set path 'vendor'
	bundle install

docs/CNAME:
	@mkdir -p docs
	echo "xmidt.io" > docs/CNAME
    
clean:
	rm -rf docs \
           downloads \
           repositories \
		   $(SWAGGER) \

clean-all: clean
	rm -rf vendor tmp

build: bundle downloads $(SWAGGER) docs/CNAME
	$(NANOC) -V

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

content/docs/webpa/swagger.html: content/docs/webpa/swagger.yaml
	npx redoc-cli  bundle -o tmp.html --title "WebPA Documentation" $<
	@echo "---"             > $@
	@echo "title: Swagger" >> $@
	@echo "sort_rank: 15"  >> $@
	@echo "---"            >> $@
	cat tmp.html           >> $@
	rm tmp.html

content/docs/codex/swagger.html: content/docs/codex/swagger.yaml
	npx redoc-cli  bundle -o tmp.html --title "Codex Documentation" $<
	@echo "---"             > $@
	@echo "title: Swagger" >> $@
	@echo "sort_rank: 15"  >> $@
	@echo "---"            >> $@
	cat tmp.html           >> $@
	rm tmp.html

.PHONY: build bundle clean clean-all build downloads serve
