
# Create YAML file for Deployment,Service & service monitor (refer app_depl.yaml)

kubectl apply -f app_depl.yaml
kubectl get deployment
kubectl get svc
kubectl get servicemonitor



kubectl get crd

kubectl get prometheuses.monitoring.coreos.com -o yaml



#################################################

## Adding Rules

# Create Yaml for Rules

kubectl apply -f rules.yaml

kubectl get prometheusrule

######################################################

## Alertmanager Config Rules

helm show values prometheus-community/kube-prometheus-stack > values.yaml

# Update "alertmanagerConfigSelector" refer values.yaml
# https://www.squadcast.com/blog/prometheus-sample-alert-rules

helm upgrade prometheus prometheus-community/kube-prometheus-stack -f values.yaml 

kubectl get alertmanagers.monitoring.coreos.com -o yaml  #check values whether upgraded or not

# Create alert.yaml

kubectl apply -f alert.yaml
kubectl get alertmanagerConfig
kubectl get services
kubectl port-forward service/alertmanager-operated 9093

