# Mkdocs

## Introduction

### What is it

Mkdocs is a documentation generator for projects which converts markdown to html.

### Why we use it

It creates documentation that's pleasing to read and easy to maintain.

???+ info "Here's a list of features we use"

    ??? example "Dead link checker"

        Github wiki doesn't check for broken links.

    ??? example "Search function"

        Github wiki is not searcheable.

    ??? example "[Tabbed blocks](https://facelessuser.github.io/pymdown-extensions/extensions/tabbed/)"

        === "Linux"

            linux-specific content

        === "Mac"

            mac-specific content

    ??? example "Site table of contents"

        See the contents of the site in the left sidebar.

    ??? example "Auto per-page table of contents"

        See the contents of the current page in the right sidebar.

    ??? example "Code and text annotations"

        ``` bash
        poetry install  # (1)!
        ```

        1. assumes poetry is installed locally

    ??? example "[Expandable text blocks](https://facelessuser.github.io/pymdown-extensions/extensions/blocks/plugins/details/)"

        That's what this is!

## How to use it

### Local install

#### Prerequisite

python poetry must be installed in the local system

#### Install mkdocs

``` bash
poetry install  # (1)!
```

1. assumes poetry is installed locally

### Work with docs

``` bash
poetry shell
mkdocs serve -a localhost:8001
ctrl-c # (1)!
exit  # (2)!
```

1. to quit mkdocs
2. to close poetry shell environment

## Setup from scratch

Here's the recommended setup, from our experience with it.

### Project directory

```
mkdir mkdocs-notes && cd $_
git init
git commit —allow-empty -m”Initial commit”
```

### Poetry project
```
poetry init —name notes —description “Notes on various subject” —author “Fang Yi Liu”
# use python version 3.11.1
# don’t define dependencies
git commit -m”create project for notes”
```

### Mkdocs package
```
poetry shell # this goes into the poetry virtual environment
poetry add mkdocs —group docs
# group replaces dev dependencies
git add pyproject.toml poetry.lock
git ci -m”add mkdocs package”
```

### Mkdocs project
```
mkdocs new . # creates mkdocs project in current directory
git add -A # add all untracked files
git ci -m”create mkdocs project”
```

### Dev server
```
mkdocs serve —dev-addr 0.0.0.0:8001 # start the dev server locally on any address on port 8001. This is useful for development from a different local network computer, where the default localhost won’t work
```

### Material theme
```
poetry add mkdocs-material
cat "theme: material" >> mkdocs.yml
git ci -a -m"setup material theme for mkdocs"
```

### Multirepo
```
poetry add mkdocs-multirepo-plugin
# add the plugin in mkdocs.yml
# import the other repos in mkdocs.yml
```

### Export requirements

We need to export the requirements whenever we add a new package, so that the docker setup can know to use it.

```bash
poetry export -f requirements.txt --without-hashes > requirements.txt --with docs # (1)!
```

1. This is also contained in a script `export_requirements.sh` in the scripts directory
