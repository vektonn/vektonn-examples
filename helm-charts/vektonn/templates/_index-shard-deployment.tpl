{{- define "vektonn.indexShard.deployment" -}}
{{- $dockerImageRepositoryAndTag := printf "%s:%s" .Values.vektonnIndexShards.dockerImage .Values.vektonnShared.dockerTag -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .indexShardName }}
  labels:
    {{- include "vektonn.indexShard.labels" . | nindent 4 }}
spec:
  replicas: {{ .indexShardValues.replicaCount }}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
  revisionHistoryLimit: 0
  selector:
    matchLabels:
      {{- include "vektonn.indexShard.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "vektonn.indexShard.selectorLabels" . | nindent 8 }}
    spec:
      containers:
      - name: {{ .indexShardName }}
        image: {{ $dockerImageRepositoryAndTag | quote }}
        imagePullPolicy: IfNotPresent
        resources:
{{ toYaml .indexShardValues.resources | indent 10 }}
        env:
        - name: VEKTONN_KAFKA_BOOTSTRAP_SERVERS
          value: {{ .Values.vektonnShared.kafkaBootstrapServers | quote }}
        - name: VEKTONN_INDEX_NAME
          value: {{ .indexShardValues.indexName | quote }}
        - name: VEKTONN_INDEX_VERSION
          value: {{ .indexShardValues.indexVersion | quote }}
        - name: VEKTONN_INDEX_SHARD_ID
          value: {{ .indexShardValues.indexShardId | quote }}
        ports:
        - name: http
          protocol: TCP
          containerPort: {{ .Values.vektonnIndexShards.httpPort }}
        volumeMounts:
{{- range $path, $_ := .Files.Glob "config/**.yaml" }}
        - name: config-volume
          readOnly: true
          subPath: {{ sha256sum $path }}
          mountPath: {{ printf "/vektonn/%s" $path }}
{{- end }}
      volumes:
      - name: config-volume
        configMap:
          name: {{ include "vektonn.name" . }}
{{- end -}}
