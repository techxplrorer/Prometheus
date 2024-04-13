Install Helm 
From Apt (Debian/Ubuntu)

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

helm version



##  https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack  #release name - prometheus (any name)


 kubectl get pod
 kubectl get all
 kubectl get configmap
 kubectl get secrets
 kubectl get crd


#Below yaml files helps to understand prometheus stack
 
kubectl get statefulset
kubectl describe statefulset alertmanager-prometheus-kube-prometheus-alertmanager > /home/idris/Prometheus/alert.yaml
kubectl describe statefulset prometheus-prometheus-kube-prometheus-prometheus > /home/idris/Prometheus/prom.yaml

kubectl get deployments
kubectl describe deployment prometheus-kube-prometheus-operator > /home/idris/Prometheus/oper.yaml

kubectl get secret
kubectl get secret prometheus-prometheus-kube-prometheus-prometheus -o yaml > /home/idris/Prometheus/secret.yaml
kubectl get configmap prometheus-prometheus-kube-prometheus-prometheus-rulefiles-0 -o yaml > /home/idris/Prometheus/config.yaml

# can see port no for grafana pods
kubectl logs prometheus-grafana-77d66779f8-m2nlf


#Port-forward Prometheus server
kubectl get pod
prometheus-prometheus-kube-prometheus-prometheus-0       2/2     Running   4 (5d15h ago)   7d5h

kubectl get service
prometheus-kube-prometheus-prometheus     ClusterIP   10.96.3.84      <none>        9090/TCP,8080/TCP            7d5h


kubectl port-forward prometheus-prometheus-kube-prometheus-prometheus-0 9090

#Port-forward Grafana Dashboard

 kubectl get deployment
 kubectl port-forward deployment/prometheus-grafana 3000

 #user : admin
 #password : prom-operator ( check from helm repository github)



 #Deploy mongo-db application in minikube cluster
 kubectl apply -f mongodb-without-exporter.yaml

# MongoDB Exporter (Translator between apps data to prometheus metrics understandable)
# https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-mongodb-exporter

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm show values prometheus-community/prometheus-mongodb-exporter

helm show values prometheus-community/prometheus-mongodb-exporter > exporter_mongodb.yaml
#edit values as per exporter_mongodb.yaml

helm install mongodb-exporter prometheus-community/prometheus-mongodb-exporter -f exporter_mongodb.yaml

#TO see mongodb exporter helm, pod,service & ServiceMonitor
helm ls
kubectl get po
kubectl get svc
kubectl get servicemonitor

kubectl get servicemonitor mongodb-exporter-prometheus-mongodb-exporter -o yaml #(Can check release label)

kubectl port-forward service/mongodb-exporter-prometheus-mongodb-exporter 9216

localhost:9216 #mongodb_exporter metrics
localhost:9090 #prometheus server
localhost:3000 #grafana dashboard
localhost:9030 #alert manager