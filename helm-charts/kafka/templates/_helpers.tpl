{{- define "kafka.name" -}}
{{- $kafkaBaseName := .Values.kafkaBaseName | default .Chart.Name -}}
{{- if contains $kafkaBaseName .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $kafkaBaseName .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "kafka.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kafka.name" . }}
{{- end }}

{{- define "kafka.labels" -}}
{{ include "kafka.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
