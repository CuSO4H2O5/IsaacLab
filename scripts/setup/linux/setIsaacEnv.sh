# Isaac Sim root directory
export ISAAC_BUILD_DIR="_build/linux-x86_64/release"
export ISAACSIM_PATH="${ISAAC_SIM_DIR}/${ISAAC_BUILD_DIR}"

echo "Beginning setup..."

if [ $# -eq 0 ]; then
    echo "No arguments provided."
else
    for arg in "$@"; do
        if [ "$arg" = "--rb" ] || [ "$arg" = "--rebuild" ]; then
            rm -rf "$ISAACSIM_PATH"
            echo "Isaac Sim build directory removed."
        fi
    done
fi

if [ ! -d "$ISAACSIM_PATH" ]; then
    echo "Error: Isaac Sim build directory not found at $ISAACSIM_PATH"
    echo "Building..."
    bash ${ISAAC_SIM_DIR}/build.sh
fi

# Isaac Sim python executable
export ISAACSIM_PYTHON_EXE="${ISAACSIM_PATH}/python.sh"
ln -s ${ISAACSIM_PATH} _isaac_sim

# generate a conda environment named env_isaaclab
./isaaclab.sh --conda

if command -v conda >/dev/null 2>&1; then
    echo "conda initialized"
else
    echo "conda uninitialized, initializing..."
    conda init --all
    echo "Please restart your terminal or run 'source ~/.bashrc' to apply conda changes."
fi

# activate the conda environment
conda activate env_isaaclab

# install all dependencies
sudo apt install cmake build-essential
./isaaclab.sh --install