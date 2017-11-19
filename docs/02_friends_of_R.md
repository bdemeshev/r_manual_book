




# Друзья R {#friends_of_R}

Если ты используешь R, то ты поймёшь, что есть куча других полезных программ!

## Рабочий процесс {#workflow}

...


## Контроль версий {#version_control}

...


## Латех {#latex}


...

## Маркдаун {#markdown}

...

## Воспроизводимые исследования {#reproducible_research}

...

## Написание своего пакета {#own_package}

...

## Вычисления в облаке {#cloud_computing}

...

## Презентации {#presentations}

...

## Про эту книжку {#this_book}


Разбить на большее количество глав!!!

Что-то убрать? чтобы была ещё одна книжка? :)


Общие принципы:

1. Неформальный стиль, на "ты"

2. Больше картинок. Лицензия?

3. Больше гипер-ссылок.

4. Буква `ё` обязательна.


Пакет `bookdown` с помощью которого написана эта книжка ещё немного сыроват. В процессе работы я обнаружил, что:

1. Порой помогает удаление промежуточных файлов и компиляция заново.

2. После неанглоязычного названия главы обязательно должна идти метка `{#label}`.

3. Каждый `.Rmd` файл содержит только одну главу. Глава обозначается заголовком первого уровня `#`.

4. Сослаться на главу или подраздел можно с помощью `\@ref(label)`. 

5. Сослаться на источник литературы можно с помощью `[@reference]`

6. Автодобавление пакетов



глючит на `"M"uller`

6. Для создания `MOBI` книг:

Под macos:

Поставить менеджер пакетов [Homebrewer](http://brew.sh/).


```bash
brew update
brew cask install calibre
brew cask install kindlegen
```

В предисловии

```bash
bookdown::kindlegen:
  epub: _book/r_manual.epub
```

ругается


или

```bash
bookdown::calibre:
  input: _book/r_manual.epub
  output: _book/r_manual.mobi 
```

ругается

Если надо изобразить yaml в чанке кода, пока пишу, что он bash


7. заставляем травис работать

Создаём новый токен на [github](https://github.com/settings/tokens): кликнуть по иконке пользователя, далее settings - token - generate new token.


```bash
sudo gem install travis
travis encrypt GITHUB_TOKEN=[token from githum]
```

Именно переменная `GITHUB_TOKEN` должна использоваться для того, чтобы обращаться к гитхабу, т.е. клонируется ветка gh-pages командой

```bash
git clone -b gh-pages https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git book-output
```
Переменная `TRAVIS_REPO_SLUG` будет сама определена сервисом Travis и будет равна названию репозитория.


Добавляем получившуюся закодированную строку в `.travis.yml`. Забавно, что похоже используется рандомный ключ для шифрования и поэтому зашифрованная строка каждый раз выходит разной.

Можно не шифровать её, а добавить в travis-ci.org/user/repo/settings 





Для быстрой компиляции добавляем в `.travis.yml` указание, что мы будем использовать готовые бинарные пакеты R:

```bash
r_binary_packages:
  - ggplot2
  - dplyr
  - rio
```
Для того, чтобы эти опции не были проигнорированы `.travis.yml` должен содержать строку `sudo: required`.

Если бинарный пакет слишком старый или вообще отсутствует, можно проинсталлировать его обычным образом, для этого добавляем строки


```bash
r_packages:
  - devtools
  - rio
```

8. Красный шрифт

по мотивам [http://stackoverflow.com/questions/29067541](http://stackoverflow.com/questions/29067541)


```r
colFmt <- function(x, color) {
  outputFormat <- opts_knit$get("rmarkdown.pandoc.to")
  if (outputFormat == "latex") {
    result <- paste0("\\textcolor{", color, "}{", x, "}")
  } else if (outputFormat %in% c("html", "epub")) {
    result <- paste0("<font color='", color, "'>", x, "</font>")
  } else {
    result <- x
  }
  return(result)
}
```



Then you can use it inline like this: <font color='red'>MY RED TEXT</font>

9. Файл `_output.yaml` это просто `output:` кусок из `yaml`-части файла `index.Rmd`. Поэтому можно внести `_output.yaml` обратно в `index.Rmd`, чтобы все настройки были в одном месте. 

Формально `_output.yaml` действует на все `.Rmd` документы в папке, но что там будет кроме учебника в целом. Разве что отдельные главы компилировать :)



