# Granite Modelcar on Red Hat OpenShift AI

### Configure OpenShift AI
First, enable modelcars for OpenShift AI by patching the inferenceservice-config in the redhat-ods-applications namespace.  `data.storageInitializer` json should set enableModelcars to true.  A script has been included in [scripts/enable-modelcars.sh](scripts/enable-modelcars.sh) to do this.
```bash
make enable-modelcars
```

### Build the modelcar
Create them image with the model in the appropriate directory structure. For Granite and vLLM, downloading the model directly to the models directory is sufficient. 
```bash
make build
```

### Push the modelcar
Push the image to Quay.io.
```bash
make push
```

### Deploy the inference service  
Creates a project, serving runtime, and inference service on OpenShift AI.
```bash
make deploy
```