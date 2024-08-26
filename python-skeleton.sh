#!/usr/bin/env bash
set -o errexit

NEW_ENV=0
CREATE_ENV=0

# Make sure we're in the script's directory
SCRIPT_PATH=$(dirname "$0")

# Add to the PYTHONPATH here if you need local libraries
#export PYTHONPATH="${PYTHONPATH}:/some/extra/path"

# Argument parsing
if [[ $# -gt 0 ]] && [[ "$1" == "--environment" ]]; then
    CREATE_ENV=1
    echo 'Removing old environment.'
    rm -rf "${SCRIPT_PATH}/venv"
    shift
fi
if [[ $# -gt 0 ]] && [[ "$1" == "--debug" ]]; then
    echo '+ Debug mode'
    set -o xtrace
fi

echo "<SCRIPT_PATH:${SCRIPT_PATH}>"

# Confirm if an environment is set up
if [[ ! -d 'venv' ]]; then
    NEW_ENV=1
fi

if [[ $NEW_ENV -eq 1 ]] || [[ $CREATE_ENV -eq 1 ]]; then

    echo -n 'Creating environment... '

    # Create the virtual environment
    python3 -m venv "${SCRIPT_PATH}/venv"

    echo 'done.'

    # shellcheck disable=SC1091
    source venv/bin/activate

    # Install dependancies
    if [[ -f './dependencies' ]]; then

        # Upgrade pip
        pip install --upgrade pip

        # Install wheel
        pip install wheel

        # Install the other dependencies
        while read -r dep; do
            pip install "$dep"
        done < './dependencies'
    fi

    deactivate

    if [[ $CREATE_ENV -eq 1 ]]; then
        echo 'Environment created.'
        exit 0
    fi

fi

# shellcheck disable=SC1091
source venv/bin/activate

# Execute the Python script
python3 "$(basename "$0" '.sh').py" "$@"

deactivate
