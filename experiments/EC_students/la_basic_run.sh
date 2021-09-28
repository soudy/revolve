#!/usr/bin/env bash

set -u

N=20
EXPERIMENT_NAME="la_basic"
CORES=4
MANAGER_PATH="experiments/EC_students/la_basic.py"
NO_LA="${1:-}"
EVALUATION_TIME=30

set -x

cd ../../

total_start=$(date +%s)

for i in $(seq 1 $N); do
  echo "---------------- RUN $i/$N -----------------"

  if [[ "$NO_LA" = "nola" ]]; then
    EXPERIMENT_NAME="la_basic_nola"
    echo "!! LA disabled !!"
    export NO_LA
  fi

  run_start=$(date +%s)

  ./revolve.py \
    --simulator-cmd gzserver \
    --run $i \
    --experiment-name $EXPERIMENT_NAME \
    --manager $MANAGER_PATH \
    --n-cores $CORES \
    --evaluation-time $EVALUATION_TIME

  run_end=$(date +%s)
  run_time=$((run_end-run_start))
  echo "###########################################"
  echo "RUN DURATION: $((run_time/60)) minutes"
  echo "###########################################"
done

total_end=$(date +%s)
total_time=$((run_end-run_start))
echo "###########################################"
echo "TOTAL DURATION: $((total_time/60)) minutes"
echo "###########################################"
