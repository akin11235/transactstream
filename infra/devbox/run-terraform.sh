
# Look for .env in current directory first, then parent directories
#!/bin/bash

# Function to find .env file by walking up the directory tree
find_env_file() {
    local dir="$PWD"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/.env" ]; then
            echo "$dir/.env"
            return 0
        fi
        dir=$(dirname "$dir")
    done
    return 1
}

# Look for .env file
env_file=$(find_env_file)
if [ -n "$env_file" ]; then
    set -a && source "$env_file" && set +a
    echo "Loaded environment variables from $env_file"
else
    echo "Warning: .env file not found in project hierarchy"
fi

terraform "$@"