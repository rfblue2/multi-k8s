docker build -t rfblue2/multi-client:latest -t rfblue2/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t rfblue2/multi-server:latest -t rfblue2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rfblue2/multi-worker:latest -t rfblue2/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rfblue2/multi-client:latest
docker push rfblue2/multi-server:latest
docker push rfblue2/multi-worker:latest
docker push rfblue2/multi-client:$SHA
docker push rfblue2/multi-server:$SHA
docker push rfblue2/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rfblue2/multi-server:$SHA
kubectl set image deployments/client-deployment client=rfblue2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rfblue2/multi-worker:$SHA
