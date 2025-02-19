docker build -t maciej55/multi-client:latest -t maciej55/multi-client:$SHA ./client/Dockerfile ./client
docker build -t maciej55/multi-server:latest -t maciej55/multi-server:$SHA ./server/Dockerfile ./server
docker build -t maciej55/multi-worker:latest -t maciej55/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push maciej55/multi-client:latest
docker push maciej55/multi-server:latest
docker push maciej55/multi-worker:latest

docker push maciej55/multi-client:$SHA
docker push maciej55/multi-server:$SHA
docker push maciej55/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=maciej55/multi-server:$SHA
kubectl set image deployments/client-deployment client=maciej55/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maciej55/multi-worker:$SHA