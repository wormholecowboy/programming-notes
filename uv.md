# UV
```bash

# 📦 Package Management
uv init
uv init project-name-folder
uv add openai fastapi
uv add --dev openai fastapi
uv add -r requirements.txt
uv remove openai

# 🚀 Run
uv run hello.py

# create new venv and install exact deps
uv sync
uv sync --no-dev

# install Python version
uv python install 3.11
uv python install 3.11 3.12 3.13  # Multiple at once
# Pin project to specific version
uv python pin 3.12  # Creates .python-version
# List available versions on sys
uv python list

#  Tools
uv tool install black
uv run pytest
uv run black .
uv run uvicorn app:app

# Updating
`uv lock --upgrade` update all direct deps to latest
`uv lock --upgrade --all` does all deps
`uv add <package> --upgrade`



# 🧪 Virtual Environment Management
# Using the run command creates venv automatically
# Create a new virtual environment in a directory
uv venv <dir>
uv venv --python=python3.11 <dir>

# ✅ NOTE: You do NOT need to activate the venv manually!
# uv run and uv pip automatically use the .venv





# If you still wanna use pip for some reason
# Install a package
uv pip install <package>
uv pip install -r requirements.txt
uv pip uninstall <package>
uv pip freeze

# 🔁 Dependency Syncing
# Sync the environment to match uv.lock exactly
uv pip sync
# Add a new dependency (updates pyproject.toml + uv.lock)
uv pip add <package>
uv pip remove <package>

# 🧼 Cache and Info
# Clean the uv package cache
uv cache clean
# Show info about a package
uv pip show <package>
uv tree
# Validate locked dependencies
uv pip check

# 🧠 Tip: Define custom scripts in pyproject.toml
# [tool.uv.scripts]
# start = "python script.py"
# Then run:
uv run start
```

