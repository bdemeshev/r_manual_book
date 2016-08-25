all: preclean pdf_noclean html epub mobi

preclean:
	export LC_ALL=en_US.UTF-8
	export LC_CTYPE=en_US.UTF-8
	rm -rf `biber --cache`
	-rm r_manual.run.xml
	-rm r_manual.Rmd

html:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")'
	cp -fvr images _book/
	cp -fvr css/style.css _book/

epub:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::epub_book")'

mobi: _book/r_manual.epub
	Rscript -e 'bookdown::kindlegen("_book/r_manual.epub")'

pdf:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")'

pdf_noclean:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book", clean=FALSE)'

site:
	Rscript -e 'rmarkdown::render_site(encoding = "UTF-8")'
	# should test

install:
	Rscript -e 'devtools::install_github("bdemeshev/r_manual_book")'
	# what the hell?

deploy:
	Rscript -e 'bookdown::publish_book(render="local", account="bdemeshev")'
	# what the hell?

clean:
	Rscript -e "bookdown::clean_book(TRUE)"
	rm -fvr *.log

cleaner:
	make clean
	rm -frv *.aux *.out *.toc # Latex output
