# Mkdocs

## Introduction

### What is it

Mkdocs is a documentation generator for projects, which converts markdown to html.

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

    ??? example "Per-page table of contents"

        See the contents of the current page in the right sidebar.

    ??? example "Code and text annotations"

        ``` bash
        Click the plus sign --> # (1)!
        ```

        1. This is an explanation text

    ??? example "[Expandable text blocks](https://facelessuser.github.io/pymdown-extensions/extensions/blocks/plugins/details/)"

        That's what this box is!

## How to use it

=== "Docker"

    1. Build the image

        ```bash
        docker-compose build
        ```

    1. Start the container

        ```bash
        docker-compose up
        ```

    1. Open a browser to `http://localhost:8001/` to see the documentation locally

    1. Modify the files in the docs directory. The site will auto update when the files are saved.

    1. Quit

        ++ctrl+c++ to quit the local server and stop the container

=== "Local install (pip)"

    ### Local Install (pip)

    python should be version 3

    1. Install mkdocs

        ``` bash
        pip install -r requirements.txt
        ```

    1. Start the local server

        ```bash
        mkdocs serve -a localhost:8001
        ```

    1. Open a browser to `http://localhost:8001/` to see the documentation locally

    1. Modify the files in the docs directory. The site will auto update when the files are saved.

    1. Quit

        ++ctrl+c++ to quit mkdocs

=== "Local install (poetry)"

    ### Local Install (poetry)

    python poetry must be installed in the local system

    1. Install mkdocs

        ```bash
        poetry install
        ```

    1. Start the local server

        ```bash
        poetry shell
        mkdocs serve -a localhost:8001
        ```

    1. Open a browser to `http://localhost:8001/` to see the documentation locally

    1. Modify the files in the docs directory. The site will auto update when the files are saved.

    1. Quit

        ++ctrl+c++ to quit mkdocs

        ```bash
        exit  # (1)!
        ```

        1. to close poetry shell environment

??? info "How we set it up"

    ## Setup from scratch

    Here's the recommended setup, from our experience setting it up.

    ### Project directory

    ```bash
    mkdir mkdocs-notes && cd $_
    git init
    git commit —allow-empty -m”Initial commit”
    ```

    ### Poetry project
    ```bash
    poetry init —name notes —description “Notes on various subject” —author “Fang Yi Liu”
    # use python version 3.11.1
    # don’t define dependencies
    git commit -m”create project for notes”
    ```

    ### Mkdocs package
    ```bash
    poetry shell # this goes into the poetry virtual environment
    poetry add mkdocs —group docs
    # group replaces dev dependencies
    git add pyproject.toml poetry.lock
    git ci -m”add mkdocs package”
    ```

    ### Mkdocs project
    ```bash
    mkdocs new . # creates mkdocs project in current directory
    git add -A # add all untracked files
    git ci -m”create mkdocs project”
    ```

    ### Local dev server

    ```bash
    mkdocs serve —dev-addr 0.0.0.0:8001 # (1)!
    ```

    1. Start the dev server locally on any address on port 8001.
    This is useful for development from a different local network computer, where the default localhost won’t work

    ### Material theme
    ```bash
    poetry add mkdocs-material
    cat "theme: material" >> mkdocs.yml
    git ci -a -m"setup material theme for mkdocs"
    ```

    ### ~~Multirepo~~ (not yet working)
    ```bash
    poetry add mkdocs-multirepo-plugin
    # add the plugin in mkdocs.yml
    # import the other repos in mkdocs.yml
    ```

    ### Export requirements

    We need to export the requirements whenever we add a new package, so that the docker setup and pip users can know to use it.

    ```bash
    # (1)!
    poetry export -f requirements.txt --without-hashes > requirements.txt --with docs
    ```

    1. This is also contained in a script `export_requirements.sh` in the scripts directory

    ### Deployment to Github Pages

    We closely followed [this guide](https://squidfunk.github.io/mkdocs-material/publishing-your-site/).
    This setup creates a gh-pages branch to store the latest docs. Make the necessary configurations in the Github repo settings as necessary under Pages.

    ### Docker setup

    We modified the dockerfile and docker-compose files from People Depot to install and serve mkdocs locally.
    The files are `docker-compose.yml` and `Dockerfile`.
