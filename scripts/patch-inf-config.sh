# Script to enable Modelcars
# Fetch the current storageInitializer configuration
config=$(kubectl get configmap inferenceservice-config -n redhat-ods-applications -o jsonpath='{.data.storageInitializer}')
echo $config
# Enable modelcars.. Do NOT set the uidModelcar setting on RHOAI
newValue=$(echo $config | jq -c '. + {"enableModelcar": true}')

# Create a temporary directory for the patch file
cat <<EOT > patch.txt
[{
  "op": "replace",
  "path": "/data/storageInitializer",
  "value": '$newValue'
}]
EOT

## Apply the patch to the ConfigMap
kubectl patch configmap -n redhat-ods-applications inferenceservice-config --type=json --patch-file=patch.txt
##
### Restart the KServe controller to apply changes
kubectl delete pod -n redhat-ods-applications -l control-plane=kserve-controller-manager
