docker build -t ankitsuthar/multi-client:latest -t ankitsuthar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ankitsuthar/multi-server:latest -t ankitsuthar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ankitsuthar/multi-worker:latest -t ankitsuthar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ankitsuthar/multi-client:latest
docker push ankitsuthar/multi-server:latest
docker push ankitsuthar/multi-worker:latest

docker push ankitsuthar/multi-client:$SHA
docker push ankitsuthar/multi-server:$SHA
docker push ankitsuthar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ankitsuthar/multi-client:$SHA
kubectl set image deployments/server-deployment server=ankitsuthar/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ankitsuthar/multi-worker:$SHA