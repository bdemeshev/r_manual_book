---
title: "Учебник по языку R для начинающих"
author: "Борис Демешев"
date: '2017-08-25'
output:
  bookdown::gitbook:
    config:
      download: [["r_manual.pdf", "PDF"], ["r_manual.epub", "EPUB"], ["r_manual.mobi", "MOBI"]]
      edit:
        link: https://github.com/bdemeshev/r_manual_book/issues
      fontsettings:
        family: sans
        size: 2
        theme: white
      search: yes
      sharing:
        all:
        - facebook
        - google
        - twitter
        - weibo
        - instapaper
        - vk
        facebook: yes
        google: no
        instapper: no
        twitter: no
        vk: yes
        weibo: no
      toc:
        after: |
          <li><a href="https://github.com/rstudio/bookdown"   target="blank">Создано с использованием пакета bookdown</a></li>
        before: |
          <li><a href="./">Учебник по языку R для начинающих</a></li>
        collapse: section
        scroll_highlight: yes
      toolbar:
        position: fixed
    css: style.css
  bookdown::html_chapters:
    includes:
      in_header: style.css
  bookdown::pdf_book:
    citation_package: biblatex
    includes:
      in_header: preamble.tex
    keep_tex: yes
    latex_engine: xelatex
  bookdown::epub_book: default
  bookdown::kindlegen:
    epub: docs/r_manual.epub
description: Учебник по языку R и не только :)
documentclass: book
fontsize: 11pt
github-repo: bdemeshev/r_manual_book
lang: ru-RU
link-citations: yes
mainfont: "Linux Libertine O"
monofont: "Linux Libertine O"
sansfont: "Linux Libertine O"
otherlangs: en-GB
bibliography:
- book.bib
- packages.bib
site: bookdown::bookdown_site
biblio-style: alphabetic
---

# О книге {-}

Сейчас живут три кита анализа данных и научных вычислений --- Julia, Python и R. Эта книга про одного из китов!




Данная версия книги скомпилирована для html.




