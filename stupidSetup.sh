export http_proxy=http://10.101.10.6:7890
export https_proxy=http://10.101.10.6:7890

# Isaac Sim root directory
export ISAAC_LIB_DIR=$(pwd)
export ISAAC_SIM_DIR="${ISAAC_LIB_DIR}/IsaacSim"

source ./scripts/setup/linux/setIsaacEnv.sh