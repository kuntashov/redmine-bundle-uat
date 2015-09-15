# Redmine Bundle UAT - check the compatible of Redmine with plugins

[![Join the chat at https://gitter.im/silverbulleters/redmine-bundle-uat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/silverbulleters/redmine-bundle-uat?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## English

* [current stable version 0.2.1](https://github.com/silverbulleters/redmine-bundle-uat/releases/tag/0.2.1)
* [сurrent work version - develop branch](https://github.com/silverbulleters/redmine-bundle-uat/tree/develop)

In Redmine Community there is a redmine-core and its team, and many of plugins with there authors. And there is a problem - redmine core developer(s) need to check stablility of the core, but the plugins authors need to develop new feature as soon as possible.

In REAL production where is NO Redmine without plugins. Thats why we need to tests plugins with redmine core.

Thats why we need to check and tests full bundle or Redmine (application + plugins + settings) and create starts script for docker composite application based on https://github.com/sameersbn/docker-redmine

### Behavior on the first try:

* install vagrant from [official site](https://www.vagrantup.com/downloads.html)
* clone the repo in your project directory

```Shell
 git clone https://github.com/silverbulleters/redmine-bundle-uat.git
 cd redmine-bundle-uat
 ```

if you what to be a active collaborator then switch to develop version

```Shell
git checkout develop
```

now activate the bundle

```Shell
git submodule init && git submodule update
```

and now you need to start your UAT box

```Shell
vagrant up
```

and check what the tests is *green* and not fails

```Shell
vagrant ssh -c "/vagrant/tools/run-tests.sh"
```

### Update vagrant box

if there is a change in the box, or new plugins there add to bundle you need to be update the box

```Shell
cd redmine-bundle-uat
git pull 
vagrant provision
git submodule init && git submodule update
```

And check the test like it described in first try

```Shell
vagrant ssh -c "/vagrant/tools/run-tests.sh"
```

### Plugins testing

### Add new plugin for tests

plugins what you want to testing must add like git submodules, example command must look like this

```Shell
cd redmine-bundle-uat
git submodule add <plugin-clone-url> ./plugins/<plugin-dir-like-it-register-in-init-file>
```

### Create deploy scripts

* in production we use docker composite from https://github.com/sameersbn/docker-redmine
* that project use scrip[t for install plugins

~~~
TODO - add generator for pre-install.sh, post-install.sh и init.sh for plugins in docker
~~~

### Notes

* You may debug your Redmine through remote debug [like this (RubyMine Jetbrains example)](https://www.jetbrains.com/ruby/help/remote-debugging.html)
* Not all plugins use DCVS to hosting there code, thats why we nee script redmine-plugins.sh to get it from web
* Some plugins ar commercial and need to be set in .gitignore after wget from web

## Русский

* [стабильная версия 0.2.1](https://github.com/silverbulleters/redmine-bundle-uat/releases/tag/0.2.1)
* [активно разрабатываемая версия - ветка develop](https://github.com/silverbulleters/redmine-bundle-uat/tree/develop)

Так сложилось что на текущий момент существует множество плагинов и множество их авторов. Одновременно с этим существует команда ядра Redmine.В целом можно сказать что обе эти команды преследуют разные цели - одна адаптирует Redmine для целей управления своими проектами, другая же последовательно и не торопясь повышает стабильность ядра 

Отдельно стоит сказать, что при необходимости использовать Redmine в реальной работе (в production) пользователи всегда устанавливают плагины от сторонних разработчиков. Использовать Redmine без плагинов - почти не принято и почти никогда не делается

В связи с чем необходимо выполнять проверку и тестирование полного bundl'а (савокупного приложения и его настроек) - со всеми плагинами. А также формирование стабильного пакета скриптов для установки плагинов в production через docker контейнер https://github.com/sameersbn/docker-redmine

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

теперь актвируем наше приложение с плагинами и необходимыми утилитами

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

плагины для тестирования добавлены в виде git подмодулейб для подключения используйте примерную команду

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
* не все плагины используют систему контроля версия для хранения своих релизов, поэтому необходимо скачивать плагины напрямую из Web
* некоторые плагины являются коммерческии и необходимо добавить их в список игнорирования

