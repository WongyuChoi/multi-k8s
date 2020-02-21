docker build -t wchoiahri/multi-client:latest -t wchoiahri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wchoiahri/multi-server:latest -t wchoiahri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wchoiahri/multi-worker:latest -t wchoiahri/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wchoiahri/multi-client:latest
docker push wchoiahri/multi-server:latest
docker push wchoiahri/multi-worker:latest
docker push wchoiahri/multi-client:$SHA
docker push wchoiahri/multi-server:$SHA
docker push wchoiahri/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wchoiahri/multi-server:$SHA
kubectl set image deployments/client-deployment client=wchoiahri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wchoiahri/multi-worker:$SHA