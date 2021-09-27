#!/usr/bin/env bash

set -u

N=20
EXPERIMENT_NAME="la_basic"
CORES=4
MANAGER_PATH="experiments/EC_students/la_basic.py"
NO_LA="${1:-}"
EVALUATION_TIME=20

set -x

cd ../../

for i in $(seq 1 $N); do
  echo "---------------- RUN $i/$N -----------------"

  if [[ "$NO_LA" = "nola" ]]; then
    echo "!! LA disabled !!"
    export NO_LA
  fi

  ./revolve.py \
    --simulator-cmd gazebo \
    --run $i \
    --experiment-name $EXPERIMENT_NAME \
    --manager $MANAGER_PATH \
    --n-cores $CORES \
    --evaluation-time $EVALUATION_TIME
done
