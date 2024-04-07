# helm-template

Template chart to use for creating universal deployments. This helm template is for personal use only. No guarantees or support will be provided. If you have questions, either open these at issues of repository herewith or send me a private message.

## Helm chart deployment
```bash
helm repo add --username <registry user name> --password <registry user password> helm-template <helm registry>
helm repo update
helm install <deployment name> helm-template/helm-template -f <custom values file>
```
Custom manifest file is essential, because the the chart is meant to be as a template chart.

## Delete deployment
```bash
helm delete <deployment name>
```
## Update deployment
```bash
helm upgrade <deployment nmae> helm-template/helm-template -f <custom manifest file>
```

## Parameters

### Global parameters

Global parameters to use in Helm chart herewith and the subcharts.

| Name                  | Description                        | Value |
| --------------------- | ---------------------------------- | ----- |
| `global.storageClass` | Global Storage Class configuration | `""`  |

### Image parameters

| Name               | Description                                                                                                     | Value           |
| ------------------ | --------------------------------------------------------------------------------------------------------------- | --------------- |
| `image.repository` | Image registry name                                                                                             | `REGISTRY_NAME` |
| `image.tag`        | Image tag                                                                                                       | `TAG`           |
| `image.pullPolicy` | Image pull policy                                                                                               | `IfNotPresent`  |
| `imagePullSecrets` | Secret name or names to pull images from private registry.                                                      | `[]`            |
| `imageCredentials` | Parameters to create a registry secret. See [Image file registry secret creation](#image-file-secrets-creation) | `{}`            |

### Deployment parameters

| Name                         | Description                                                                                                                            | Value  |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Enables service account creation                                                                                                       | `true` |
| `serviceAccount.annotations` | Service account annotations                                                                                                            | `{}`   |
| `serviceAccount.name`        | Service account name. If name is not defined, but service account to be created, the name will be choosen by service account template. | `""`   |

### Service access parameters

| Name                              | Description                                                                                                       | Value       |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------- |
| `service.type`                    | Service type                                                                                                      | `ClusterIP` |
| `service.port`                    | Service port                                                                                                      | `80`        |
| `ingress.enabled`                 | Ingress enabled (`true`/`false`)                                                                                  | `false`     |
| `ingress.className`               | Ingress class name                                                                                                | `nginx`     |
| `ingress.annotations`             | Ingress annotations                                                                                               | `{}`        |
| `ingress.hosts`                   | ingress access host(s) name(s)                                                                                    | `[]`        |
| `ingress.hosts.host`              | Ingress host name                                                                                                 | `""`        |
| `ingress.hosts.paths`             | Ingress path description                                                                                          | `[]`        |
| `ingress.hosts.paths.path`        | Ingress path                                                                                                      | `/`         |
| `ingress.hosts.paths.pathType`    | Ingress path type (`ImplementationSpecific`, `Prefix`, `Exact`)                                                   | `""`        |
| `ingress.hosts.paths.serviceName` | Service name, where ingress points to                                                                             | `""`        |
| `ingress.hosts.paths.serviceName` | Service port                                                                                                      | `""`        |
| `ingress.tls`                     | TLS certificate description(s)                                                                                    | `[]`        |
| `ingress.tls.secretName`          | TLS certificate secret name                                                                                       | `""`        |
| `ingress.tls.hosts`               | TLS certificate host name                                                                                         | `""`        |
| `envVars`                         | Environment variables which will be created in container [Environment variables](#environment-variables) section. | `{}`        |

### Service parameters

| Name                                      | Description                                                                                                                                             | Value   |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `configMap`                               | Service configuration file description. Please see [Configuration file in ConfigMap](#configuration-file-in-configmap) section.                         | `{}`    |
| `secrets`                                 | Service secret environment variables or parameters description. Please see [Secrets](#secrets) section.                                                 | `{}`    |
| `envConfigMapVars`                        | Environment variables from ConfigMap object. Please see [Environment variables from ConfigMap object](#environment-variables-from-configmap) section.   | `{}`    |
| `envSecretVars`                           | Environment variables from Kubernetes Secret object. Please see [Environment variables from Secret object](#environment-variables-from-secrets) section | `{}`    |
| `envFromSecret`                           | Set environment variables from secrets. The secrets have to be described in list.                                                                       | `[]`    |
| `envFromConfigMap`                        | Set environment variables from configmap. The configmap names have to be described in list.                                                             | `[]`    |
| `volumes`                                 | Mounting configuration file as a file in container. Please see [Mounting configuration file](#mounting-configuration-file) section                      | `{}`    |
| `startupProbe.enabled`                    | Enable startup probe (`true`/`false`)                                                                                                                   | `false` |
| `startupProbe.initialDelaySeconds`        | Startup probe delay in seconds                                                                                                                          | `10`    |
| `startupProbe.periodSeconds`              | Startup probe period in seconds                                                                                                                         | `10`    |
| `startupProbe.timeoutSeconds`             | Startup probe timeout in seconds                                                                                                                        | `5`     |
| `startupProbe.failureThreshold`           | Startup probe failure level in seconds                                                                                                                  | `3`     |
| `startupProbe.successThreshold`           | Startup probe success level in seconds                                                                                                                  | `1`     |
| `startupProbe.httpGet.path`               | Startup probe HTTP service endpoint                                                                                                                     | `/`     |
| `startupProbe.httpGet.port`               | Startup probe HTTP service endpoint port                                                                                                                | `http`  |
| `livenessProbe.enabled`                   | Enable liveness probe (`true`/`false`)                                                                                                                  | `false` |
| `livenessProbe.initialDelaySeconds`       | Liveness probe delay in seconds                                                                                                                         | `10`    |
| `livenessProbe.periodSeconds`             | Liveness probe period in seconds                                                                                                                        | `10`    |
| `livenessProbe.timeoutSeconds`            | Liveness probe timeout in seconds                                                                                                                       | `5`     |
| `livenessProbe.failureThreshold`          | Liveness probe failure level in seconds                                                                                                                 | `3`     |
| `livenessProbe.successThreshold`          | Liveness probe success level in seconds                                                                                                                 | `1`     |
| `livenessProbe.httpGet.path`              | Liveness probe HTTP service endpoint                                                                                                                    | `/`     |
| `livenessProbe.httpGet.port`              | Liveness probe HTTP service endpoint port                                                                                                               | `http`  |
| `readinessProbe.enabled`                  | Enable readiness probe (`true`/`false`)                                                                                                                 | `false` |
| `readinessProbe.initialDelaySeconds`      | Readiness probe delay in seconds                                                                                                                        | `10`    |
| `readinessProbe.periodSeconds`            | Readiness probe period in seconds                                                                                                                       | `10`    |
| `readinessProbe.timeoutSeconds`           | Readiness probe timeout in seconds                                                                                                                      | `5`     |
| `readinessProbe.failureThreshold`         | Readiness probe failure level in seconds                                                                                                                | `3`     |
| `readinessProbe.successThreshold`         | Readiness probe success level in seconds                                                                                                                | `1`     |
| `readinessProbe.httpGet.path`             | Readiness probe HTTP service endpoint                                                                                                                   | `/`     |
| `readinessProbe.httpGet.port`             | Readiness probe HTTP service endpoint port                                                                                                              | `http`  |
| `autoscaling.enabled`                     | Enablea autoscaling (`true`/`false`)                                                                                                                    | `false` |
| `autoscaling.minReplicas`                 | Minimum number of kubernetes Pod objects                                                                                                                | `1`     |
| `autoscaling.maxReplicas`                 | Maximum number of kubernetes Pod objects                                                                                                                | `100`   |
| `autoscaling.cpuUtilizationPercentage`    | CPU utilisation description in %                                                                                                                        | `80`    |
| `autoscaling.memoryUtilizationPercentage` | Memory utilisation description in %                                                                                                                     | `80`    |

### Postgressql parameters

Bitnami Postgresql deployment [helm chart'i](https://github.com/bitnami/charts/tree/main/bitnami/postgresql).
Postgresql parameters description can be found [here](https://github.com/bitnami/charts/tree/main/bitnami/postgresql#parameters).

| Name                 | Description                            | Value   |
| -------------------- | -------------------------------------- | ------- |
| `postgresql.enabled` | Postgresql deployment (`true`/`false`) | `false` |

### RabbitMQ parameters

Bitnami RabbitMQ [helm chart'i](https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq).
RabbitMQ parameters description can be found [here](https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq#parameters).

| Name               | Description                         | Value   |
| ------------------ | ----------------------------------- | ------- |
| `rabbitmq.enabled` | RabbitMQ paigaldus (`true`/`false`) | `false` |

## Image file secrets creation

Chart herewith can also create image pull secrets. You need to create secrets name under the `imagePullSecrets` parameter and create create secret objetm under `imageCredentials` parameter. The object name will be used as secrets name. In example:

```yaml
imagePullSecrets:
  - name: my-registry-secret

imageCreentials:
  my-registry-secret:
    registry: docker.io
    username: myuser
    password: mysecretpassword
    email: someone@host.com
```
There can be more than one secrets objects. Every object will be used as idependent secret object. **NB!** Secret object name has to be created only with small caps, but can contain `-` (hyphen). However, the secret name cannot start or end with a hyphen.

## Environment variables

To have environment variables in the container, you can describe these in the values file as per example herewith below:
```yaml
envVars:
  ENV_VAR1: value1
  ENV_VAR2: value2
```

## Configuration file in ConfigMap
ConfigMap can be used to define set of environment variables or application configuration file. Here is an example of configuration file:

```yaml
configMap:
  data:
    config.js: |
      window.VITE_API_GW_BASEURL = 'https:/host-api.example.com';
      window.VITE_API_GW_PORT = '443';
```
There will be created ConfigMap object with fullName and the contents of the configuration data is described in `data` field. 

## Secrets

To run application you might need to provide secret keys or passwords for the application either as environment variables or configuration file. These secret properties can be stored in Kubernetes Secrets objects. Here is an example of such secret object creation:

```yaml
secrets:
  secretfile:
    data:
      api.key: |-
        ahmaekaereeNgoo5ahkaikaexuwiegh0aiyeer9pief9aifeicheingeikielohn
```


## Environment variables from ConfigMap
If there is ConfigMap object alerady available, you can define these as follows: 
```yaml
envConfigMapVars:
  variablename:
    configMapName: nameOfTheConfigmap
    configMapKey: KeyInConfigmap
```
You can define more than one variable name.

## Environment variables from Secrets
You can also use existing Secrets object which contains set of environment variables:
```yaml
envSecretVars:
  variablename:
    secretName: nameOfTheConfigmap
    secretKey: KeyInConfigmap
```
You can have more than one environment variable name.

## Mounting configuration file

If application configuration is described in ConfigMap object, it can be mounted to container so that application can read the configuration data from file. 

```yaml
volumes:
  config:
    enabled: true
    type: custom
    mountPath: /usr/share/nginx/html/config.js
    subPath: config.js
    volumeSpec:
      configMap:
        name: myconfigmap
        defaultMode: 420
        optional: false
```
* `config` - configuration name that will be mounted
* `config.enabled` - wether configuration file will be used or not (`true`/`false`)
* `config.type` - when mounting configuration file, use type as `custom`. It is possible to define also pvc configuration
* `config.mountPath` - configuration file location in container directory tree
* `config.subPath` - configuration file will be shown as a name in the container file system
* `config.volumeSpec.configMap.name` - ConfigMap name that contains the configuration data
* `config.volumeSpec.configMap.deaultMode` - mounted configuration file default permissions
* `config.volumeSpec.configMap.optional` - `true` enables to start container when configuration file mount will not succeed. `false` will not enable to start container, when configuration file mounting will not succeed