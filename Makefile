PROJECT = qdio
MD   = $(PROJECT).md
TAR  = $(PROJECT).tgz
HTML = $(PROJECT).html
CSS = github.css

MD_HTML = /usr/local/bin/github-markdown
MD_CSS  = github-markdown-css

all:
	node $(MD_HTML) $(MD) > $(HTML)
	@sed -i '1i\
<html>\
  <head>\
    <link rel="stylesheet" type="text/css" href="./$(CSS)"/>\
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
	sudo npm install -g github-markdown $(MD_CSS)

clean:
	rm -rf $(TAR) $(HTML) $(CSS)
