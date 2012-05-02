all: reqs

reqs: Requirements.markdown
	pandoc Requirements.markdown -o Requirements.html

clean:
	rm -f *.html
