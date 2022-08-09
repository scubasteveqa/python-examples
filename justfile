default:
    just --list

# https://github.com/rnorth/gh-combine-prs
# use combine-prs extension to bump all requirements files
dependabot:
    gh combine-prs --query "author:app/dependabot"

# set up virtual environment in working directory
bootstrap:
    if test ! -e {{invocation_directory()}}/.venv; then python  -m venv  {{invocation_directory()}}/.venv; fi
    {{invocation_directory()}}/.venv/bin/python -m pip install --upgrade pip wheel setuptools
    if test -f {{invocation_directory()}}/requirements.txt; \
        then \
         {{invocation_directory()}}/.venv/bin/python -m pip install -r {{invocation_directory()}}/requirements.txt; \
    fi

# remove virtual environment from working directory
clean:
    rm -rf {{invocation_directory()}}/.venv