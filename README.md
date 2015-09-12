# Redmine Bundle UAT - check the compatible of redmine with plugins

## en_US

[current version 0.2](https://github.com/silverbulleters/redmine-bundle-uat/releases/tag/0.2)
[сurrent work version - develop branch](https://github.com/silverbulleters/redmine-bundle-uat/tree/develop)

~~~
TODO
~~~

## ru_RU

[стабильная версия 0.2](https://github.com/silverbulleters/redmine-bundle-uat/releases/tag/0.2)
[активно разрабатываемая версия - ветка develop](https://github.com/silverbulleters/redmine-bundle-uat/tree/develop)

Так сложилось что на текущий момент существует множество плагинов и множество их авторов. Одновременно с этим существует команда ядра Redmine. 
В целом можно сказать что обе эти команды преследуют разные цели - одна адаптирует Redmine для целей управления своими проектами, другая же последовательно и не торопясь повышает стабильность ядра 

Отдельно стоит сказать, что при необходимости использовать Redmine в реальной работе (в production) пользователи всегда устанавливают плагины от сторонних разработчиков.
Использовать Redmine без плагинов - почти не принято и почти никогда не делается

В связи с чем необходимо выполнять проверку и тестирование полного bundl'а (савокупного приложения и его настроек) - со всеми плагинами
А также формирование стабильного пакета скриптов для установки плагинов в production через docker контейнер https://github.com/sameersbn/docker-redmine

### Установка

~~~
TODO
~~~


```
git clone
vagrant up

```

### Обновление 

* из исходников

```
git pull 
vagrant provision 
```

* из репозитория образов

~~~
TODO
~~~

### Отладка

[Подключение RubyMine к отлаживаемому приложению](https://www.jetbrains.com/ruby/help/remote-debugging.html)

~~~
TODO
~~~

### Тестируемые плагины

#### Добавление новых плагинов к тестированию


```
git submodule add <url> ./redmine-plugins/plugin-name
vagrant provision
```

#### Запуск тестов на совместимость

Состоит из двух пунктов

* обновление образа для тестирования
* запуск тестов

```
vagrant provision 
vagrant ssh 
cd /vagrant/redmine-core/ 
bundle exec rake test -v 
phantomjs --webdriver 4444 
bundle exec rake test:ui -v
```

### Формирование файла поставки для production

* в качествет production образа используется docker образ https://github.com/sameersbn/docker-redmine
* он использует установку плагинов через скрипты расширения

~~~
TODO - добавить скрипты для формирования файлов pre-install.sh, post-install.sh и init.sh для плагинов для образа docker
~~~

~~~
Заметки на полях:

* не все плагины находятся в git репозиториях - в таком случае используется скрипт для установки redmine-plugins.sh
* не все плагины разрабатываются первоначальными авторами, поэтому необходимо использовать свои или чужие форки для попытки тестирования полного приложения
~~~