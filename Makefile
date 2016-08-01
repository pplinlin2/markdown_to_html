OUT = output
PROJECT = qdio
MD   = $(PROJECT).md
TAR  = $(OUT)/$(PROJECT).tgz
HTML = $(OUT)/$(PROJECT).html
CSS  = $(OUT)/$(PROJECT).css

PANDOC = pandoc
MD_CSS = github-markdown-css

all:
	@test -d $(OUT) || mkdir $(OUT)
	$(PANDOC) $(MD) -f markdown_github -t html -o $(HTML)
	@sed -i '1i\
<html>\
  <head>\
    <link rel="stylesheet" type="text/css" href="$(PROJECT).css"/>\
    <style>\
      .markdown-body {\
        box-sizing: border-box;\
        min-width: 200px;\
        max-width: 1200px;\
        margin: 0 auto;\
        padding: 45px;\
      }\
    </style>\
  </head>\
<body class="markdown-body">' $(HTML)
	@echo '</body></html>' >> $(HTML)
	test -f $(CSS) || $(MD_CSS) > $(CSS)
	tar -czf $(TAR) $(HTML) $(CSS)

install:
	sudo apt-get install $(PANDOC)
	sudo npm install -g $(MD_CSS)

clean:
	rm -rf $(OUT)
