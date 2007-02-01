xslt=xsltproc $1 $2 > $3
tidy=tidy
host=coltrane

default: resume.html
	open $^

%.html: %.xml resume.xsl tidy.conf
	$(call xslt,resume.xsl,$<,$@)
	$(tidy) -config tidy.conf $@ || true

upload: resume.html resume.css
	scp $^ $(host):public_html/resume/
	open http://cs.ucsb.edu/~sgk/resume

tidy:
	rm -f *~

clean:
	rm -f *.html

.PHONY: default upload tidy clean
