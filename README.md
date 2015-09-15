# Redmine Bundle UAT - test compatibility of Redmine and plugins

[![Join the chat at https://gitter.im/silverbulleters/redmine-bundle-uat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/silverbulleters/redmine-bundle-uat?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](http://ci.silverbulleters.org/buildStatus/icon?job=Redmine-Bundle-UAT)](http://ci.silverbulleters.org/job/Redmine-Bundle-UAT/)


## English

* [current stable version 0.2.1](https://github.com/silverbulleters/redmine-bundle-uat/releases/tag/0.2.1)
* [сurrent work version - develop branch](https://github.com/silverbulleters/redmine-bundle-uat/tree/develop)

In Redmine Community there is a redmine-core developed by its team, and many of third-party plugins developed by its authors. And these two group of developers have different goals. While plugins authors needs to develop new feauteres as soon as possible, Redmine core developers slow down development in order to get stable and safe core.

In REAL production there is NO Redmine without plugins. Thats why we need to tests plugins with redmine core.

So we should check and test full bundle of Redmine (application + plugins + settings) and create start script for docker composite application based on https://github.com/sameersbn/docker-redmine

### Installation

* install vagrant from [official site](https://www.vagrantup.com/downloads.html)
* clone this repo in your project directory using following commands

```Shell
 git clone https://github.com/silverbulleters/redmine-bundle-uat.git
 cd redmine-bundle-uat
 ```

When you want to contribute to the project you should switch to develop branch

```Shell
git checkout develop
```

then activate the bundle

```Shell
git submodule init && git submodule update
```

and then you need to start your UAT box

```Shell
vagrant up
```

and make sure then all tests passed and no tests failed

```Shell
vagrant ssh -c "/vagrant/tools/run-tests.sh"
```

### Update vagrant box

If the box image was updated or new plugins were added to bundle then you need to update the box

```Shell
cd redmine-bundle-uat
git pull 
vagrant provision
git submodule init && git submodule update
```

And run tests like it described above

```Shell
vagrant ssh -c "/vagrant/tools/run-tests.sh"
```

### Plugins testing

### Add new plugin to test them

plugins that you want to test should be installed as git submodules, e.g. command should look like this

```Shell
cd redmine-bundle-uat
git submodule add <plugin-clone-url> ./plugins/<plugin-dir-like-it-register-in-init-file>
```

### Create deploying scripts

* in production we use docker composite from https://github.com/sameersbn/docker-redmine
* that project use script to install plugins

~~~
TODO - add generator for pre-install.sh, post-install.sh и init.sh for plugins in docker
~~~

### Notes

* You may debug your Redmine through remote debug [like this (RubyMine Jetbrains example)](https://www.jetbrains.com/ruby/help/remote-debugging.html)
* Not all plugins use DVCS for its code, that's why we need script redmine-plugins.sh to get it from web
* Some plugins are commercial and need to be set in .gitignore after wget from web

## Русский

* [стабильная версия 0.2.1](https://github.com/silverbulleters/redmine-bundle-uat/releases/tag/0.2.1)
* [активно разрабатываемая версия - ветка develop](https://github.com/silverbulleters/redmine-bundle-uat/tree/develop)

Так сложилось что на текущий момент существует множество плагинов и множество их авторов. Одновременно с этим существует команда ядра Redmine.В целом можно сказать что обе эти команды преследуют разные цели - одна адаптирует Redmine для целей управления своими проектами, другая же последовательно и не торопясь повышает стабильность ядра 

Отдельно стоит сказать, что при необходимости использовать Redmine в реальной работе (в production) пользователи всегда устанавливают плагины от сторонних разработчиков. Использовать Redmine без плагинов - почти не принято и почти никогда не делается

В связи с чем необходимо выполнять проверку и тестирование полного bundl'а (совокупного приложения и его настроек) - со всеми плагинами. А также формирование стабильного пакета скриптов для установки плагинов в production через docker контейнер https://github.com/sameersbn/docker-redmine

### Установка

* установить vagrant с [официального сайта](https://www.vagrantup.com/downloads.html)
* скачать исходники к себе на компьютер с помощью следующих команд

```Shell
 git clone https://github.com/silverbulleters/redmine-bundle-uat.git
 cd redmine-bundle-uat
 ```

Если вы хотите быть активным участником и дорабатывать bundle тогда переключитесь на версию для разработки

```Shell
git checkout develop
```

теперь активируем наше приложение с плагинами и необходимыми утилитами

```Shell
git submodule init && git submodule update
```

и можно запустить установку вашей виртуальнй машины для проверки Redmine

```Shell
vagrant up
```

ну и конечно самое главное, убедитесь что все тесты проходят и нет ошибок

```Shell
vagrant ssh -c "/vagrant/tools/run-tests.sh"
```

### Обновление 

если произошли изенения в образе, вам необходимо произвести обновление и настройку новой версии с помощью следующих команд

```Shell
cd redmine-bundle-uat
git pull 
vagrant provision
git submodule init && git submodule update
```

И запустить тесты как это было описано выше

```Shell
vagrant ssh -c "/vagrant/tools/run-tests.sh"
```

### Тестируемые плагины

#### Добавление новых плагинов к тестированию

плагины для тестирования добавлены в виде git подмодулей. Для подключения используйте примерную команду

```Shell
cd redmine-bundle-uat
git submodule add <plugin-clone-url> ./plugins/<plugin-dir-like-it-register-in-init-file>
```

### Формирование файла поставки для production

* в качествет production образа используется docker образ https://github.com/sameersbn/docker-redmine
* он использует установку плагинов через скрипты расширения

~~~
TODO - добавить скрипты для формирования файлов pre-install.sh, post-install.sh и init.sh для плагинов для образа docker
~~~

### Заметки

* Вы можете использовать удаленную отладку [по примеру продукта RubyMine от JetBrains)](https://www.jetbrains.com/ruby/help/remote-debugging.html)
* не все плагины используют систему контроля версий для хранения своих релизов, поэтому необходимо скачивать плагины напрямую из Web
* некоторые плагины являются коммерческими и необходимо добавить их в список игнорирования

