# Build images, tag each one, push to docker hub

docker build -t mparaskakis/multi-client:latest -t mparaskakis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mparaskakis/multi-server:latest -t mparaskakis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mparaskakis/multi-worker:latest -t mparaskakis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mparaskakis/multi-client:latest
docker push mparaskakis/multi-server:latest
docker push mparaskakis/multi-worker:latest

docker push mparaskakis/multi-client:$SHA
docker push mparaskakis/multi-server:$SHA
docker push mparaskakis/multi-worker:$SHA

# Apply all configs in k8s folder

kubectl apply -f k8s

# Imperatively set latest images on each deployment

kubectl set image deployments/client-deployment client=mparaskakis/multi-client:$SHA
kubectl set image deployments/server-deployment server=mparaskakis/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mparaskakis/multi-worker:$SHA

