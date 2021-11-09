docker build -t lucaslazzaris/multi-client:lastest -t lucaslazzaris/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucaslazzaris/multi-server:lastest -t lucaslazzaris/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucaslazzaris/multi-worker:lastest -t lucaslazzaris/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lucaslazzaris/multi-client:latest
docker push lucaslazzaris/multi-server:latest
docker push lucaslazzaris/multi-worker:latest

docker push lucaslazzaris/multi-client:$SHA
docker push lucaslazzaris/multi-server:$SHA
docker push lucaslazzaris/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lucaslazzaris/multi-client:$SHA
kubectl set image deployments/server-deployment server=lucaslazzaris/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lucaslazzaris/multi-worker:$SHA 