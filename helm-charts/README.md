# Helm Charts

To run provided charts locally you will need to install [minikube](https://minikube.sigs.k8s.io/docs/start/) and [Helm](https://helm.sh/docs/intro/install/).

1. Start minkube:
    ```bash
    minikube start
    ```

1. Deploy single-noded Kafka cluster:
    ```bash
    helm upgrade --install kafka-dummy kafka
    ```
   Note that `kafka` Helm chart presented here is for demonstration purposes only.
   It does not provide any persistent data storage!

1. Deploy your first Vektonn release `r1`:
    ```bash
    helm upgrade --install vektonn-r1 vektonn
    ```

1. Verify that everything is up and running:
    ```bash
    minikube kubectl get all
    ```
    ```
    NAME                                       READY   STATUS    RESTARTS   AGE
    pod/kafka-dummy-5fb7b9d899-97pkc           1/1     Running   0          36s
    pod/vektonn-index-shard-766db64645-m75zr   1/1     Running   0          7s
    pod/vektonn-index-shard-766db64645-vck22   1/1     Running   0          7s
    pod/vektonn-r1-api-5bfd6b5fcb-65cjp        1/1     Running   0          7s

    NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    service/kafka-broker          ClusterIP   None            <none>        9092/TCP       36s
    service/vektonn-index-shard   ClusterIP   10.99.136.170   <none>        8082/TCP       7s
    service/vektonn-r1-api        NodePort    10.104.24.141   <none>        80:30080/TCP   7s

    NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/kafka-dummy           1/1     1            1           36s
    deployment.apps/vektonn-index-shard   2/2     2            2           7s
    deployment.apps/vektonn-r1-api        1/1     1            1           7s

    NAME                                             DESIRED   CURRENT   READY   AGE
    replicaset.apps/kafka-dummy-5fb7b9d899           1         1         1       36s
    replicaset.apps/vektonn-index-shard-766db64645   2         2         2       7s
    replicaset.apps/vektonn-r1-api-5bfd6b5fcb        1         1         1       7s
    ```

1. Provide access to Vektonn API service from host machine:
    ```bash
    minikube service --url vektonn-r1-api
    ```
    ```
    * Starting tunnel for service vektonn-r1-api.
    |-----------|----------------|-------------|------------------------|
    | NAMESPACE |      NAME      | TARGET PORT |          URL           |
    |-----------|----------------|-------------|------------------------|
    | default   | vektonn-r1-api |             | http://127.0.0.1:59241 |
    |-----------|----------------|-------------|------------------------|
    ```

1. Verify that Vektonn API service is respsonding:
    ```bash
    curl -v -X POST http://localhost:59241/api/v1/search/QuickStart.Index/1.0 \
    --header 'Content-Type: application/json' \
    --data @- <<BODY
    {
      "k": 3,
      "queryVectors": [
        {
          "isSparse": false,
          "coordinates": [0.0, 0.0]
        }
      ]
    }
    BODY
    ```
    ```
    * Connected to localhost (::1) port 59241 (#0)
    > POST /api/v1/search/QuickStart.Index/1.0 HTTP/1.1
    > Host: localhost:59241
    > User-Agent: curl/7.75.0
    > Accept: */*
    > Content-Type: application/json
    > Content-Length: 98
    >
    } [98 bytes data]
    < HTTP/1.1 200 OK
    < Content-Type: application/json; charset=utf-8
    < Transfer-Encoding: chunked
    <
    { [90 bytes data]
    [{"queryVector":{"isSparse":false,"coordinates":[0,0]},"nearestDataPoints":[]}]
    * Connection #0 to host localhost left intact
    ```
