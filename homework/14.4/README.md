## Найдите полный хеш и комментарий коммита, хеш которого начинается на `aefea`.

```console
git log --pretty=oneline -n 1 aefea
```
Получаем:
```
aefead2207ef7e2aa5dc81a34aedf0cad4c32545 Update CHANGELOG.md
```

## Ответьте на вопросы.

### Какому тегу соответствует коммит `85024d3`?

```console
git describe 85024d3
```
Получаем:
```
v0.12.23
```

### Сколько родителей у коммита `b8d720`? Напишите их хеши.

```console
git log --pretty=%P -n 1 b8d720
```
либо
```console
git show b8d720^@
```
В любом случае получаем двух родителей:
```
56cd7859e05c36c06b56d013b55a252d0bb7e158 
9ea88f22fc6269854151c571162c5bcf958bee2b
```

### Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами  v0.12.23 и v0.12.24.

Если нужны коммиты включительно:

```console
git log --pretty=oneline v0.12.23^..v0.12.24
```

Получаем:
```
33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release
85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23) v0.12.23release
```

Либо, если нужны исключительно промежуточные коммиты:

```console
git log --pretty=oneline v0.12.23..v0.12.24 --invert-grep --grep=v0.12.24
```

### Найдите коммит, в котором была создана функция `func providerSource`, её определение в коде выглядит так: `func providerSource(...)` (вместо троеточия перечислены аргументы).

```console
git log --pretty=oneline -S "func providerSource("
```

Получаем:
```
8c928e83589d90a031f811fae52a81be7153e82f main: Consult local directories as potential mirrors of providers
```

### Найдите все коммиты, в которых была изменена функция `globalPluginDirs`.

Для начала находим файл, где функция сейчас используется, а затем ищем по нему и по функции изменения:
```cosnole
grep -R "func globalPluginDirs"
git log --pretty=oneline --no-patch -L :globalPluginDirs:plugins.go
```

Получаем:
```
78b12205587fe839f10d946ea3fdc06719decb05 Remove config.go and update things using its aliases
52dbf94834cb970b510f2fba853a5b49ad9b1a46 keep .terraform.d/plugins for discovery
41ab0aef7a0fe030e84018973a64135b11abcd70 Add missing OS_ARCH dir to global plugin paths
66ebff90cdfaa6938f26f908c7ebad8d547fea17 move some more plugin search path logic to command
8364383c359a6b738a436d1b7745ccdce178df47 Push plugin discovery down into command package
```

### Кто автор функции `synchronizedWriters`? 

```console
git log --reverse -S 'func synchronizedWriters' --pretty=format:"%an" | head -1
```
Получаем:
```
Martin Atkins
```