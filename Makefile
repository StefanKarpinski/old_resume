xslt=xsltproc $1 $2 > $3
tidy=tidy
host=linus

default: resume.html

%.html: %.xml resume.css resume.xsl tidy.conf
	$(call xslt,resume.xsl,$<,$@)
	$(tidy) -config tidy.conf $@ || true

upload: resume.html
	scp $^ $(host):public_html/resume/
	open http://cs.ucsb.edu/~sgk/resume

tidy:
	rm -f *~

clean:
	rm -f *.html

.PHONY: default upload tidy clean
