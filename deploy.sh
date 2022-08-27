docker build -t jaroush/multi-client-k8s:latest -t jaroush/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t jaroush/multi-server-k8s-pgfix:latest -t jaroush/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t jaroush/multi-worker-k8s:latest -t jaroush/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push jaroush/multi-client-k8s:latest
docker push jaroush/multi-server-k8s-pgfix:latest
docker push jaroush/multi-worker-k8s:latest

docker push jaroush/multi-client-k8s:$SHA
docker push jaroush/multi-server-k8s-pgfix:$SHA
docker push jaroush/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jaroush/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=jaroush/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=jaroush/multi-worker-k8s:$SHA