{{- define "vektonn.indexShard.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ .indexShardName }}
  labels:
    {{- include "vektonn.indexShard.labels" . | nindent 4 }}
spec:
  type: ClusterIP
  selector:
    {{- include "vektonn.indexShard.selectorLabels" . | nindent 4 }}
  ports:
  - name: http
    port: {{ .Values.vektonnIndexShards.httpPort }}
    targetPort: {{ .Values.vektonnIndexShards.httpPort }}
{{- end -}}
