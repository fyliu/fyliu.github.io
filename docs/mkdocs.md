# Mkdocs

## Installation

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
