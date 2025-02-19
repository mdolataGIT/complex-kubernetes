docker build -t maciej55/multi-client-k8s:latest -t maciej55/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t maciej55/multi-server-k8s:latest -t maciej55/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t maciej55/multi-worker-k8s:latest -t maciej55/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push maciej55/multi-client-k8s:latest
docker push maciej55/multi-server-k8s:latest
docker push maciej55/multi-worker-k8s:latest

docker push maciej55/multi-client-k8s:$SHA
docker push maciej55/multi-server-k8s:$SHA
docker push maciej55/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maciej55/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=maciej55/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=maciej55/multi-worker-k8s:$SHA