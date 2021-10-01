#!/usr/bin/env bash

set -u

N=20
CORES=r
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
    PORT_START=12000
    echo "!! LA disabled !!"
  else
    EXPERIMENT_NAME="la_basic"
    PORT_START=11000
    echo "!! LA enabled !!"
  fi

  run_start=$(date +%s)

  until ./revolve.py \
    --simulator-cmd gzserver \
    --run $i \
    --experiment-name $EXPERIMENT_NAME \
    --manager $MANAGER_PATH \
    --n-cores $CORES \
    --port-start $PORT_START \
    --evaluation-time $EVALUATION_TIME; do
    sleep 1;
  done

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
