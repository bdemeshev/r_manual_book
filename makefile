all: pdf epub html

html:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook")'
	# cp -fvr images _book/

epub:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::epub_book")'

pdf:
	Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")'

md:
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
