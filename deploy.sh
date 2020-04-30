# Build images, tag each one, push to docker hub

docker build -t michaelparaskakis/multi-client:latest -t mparaskakis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t michaelparaskakis/multi-server:latest -t mparaskakis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t michaelparaskakis/multi-worker:latest -t mparaskakis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push michaelparaskakis/multi-client:latest
docker push michaelparaskakis/multi-server:latest
docker push michaelparaskakis/multi-worker:latest

docker push michaelparaskakis/multi-client:$SHA
docker push michaelparaskakis/multi-server:$SHA
docker push michaelparaskakis/multi-worker:$SHA

# Apply all configs in k8s folder

kubectl apply -f k8s

# Imperatively set latest images on each deployment

kubectl set image deployments/client-deployment client=michaelparaskakis/multi-client:$SHA
kubectl set image deployments/server-deployment server=michaelparaskakis/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=michaelparaskakis/multi-worker:$SHA

