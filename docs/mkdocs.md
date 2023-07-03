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

## Hackforla project template

### Usage

When we create a new project from the template, mkdocs should already be usable.

#### Components

1. Starter docs to guide the creation of new pages.
1. Github workflow setup to auto-deploy the documentation.
1. Docker setup to run mkdocs locally without having to do the multi-step setup
1. [optional] A docs branch which allows someone to make edits to files in the docs directory and a daily automation will merge in the changes to the main branch.

??? "How we set it up"

    ##### Docker image

    There's a docker image that contains the standard mkdocs setup we use at Hack for LA. It contains all the plugins that some project is using. If your project requires other ones, Either request one to be added to the image or create your own dockerfile for installing


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
    poetry init —name docs —description “Project Documentation” # (1)!
    # use a modern stable python like version 3.11.1
    # don’t define dependencies interactively
    git commit -m”create project for documentation”
    ```

    1. We chose poetry because it performs multiple useful functions such as creating the virtual environment and dependency management. It will be easy to update to the latest versions of dependencies.

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
