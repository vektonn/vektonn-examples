{{- define "vektonn.name" -}}
{{- $vektonnBaseName := .Values.vektonnBaseName | default .Chart.Name -}}
{{- if contains $vektonnBaseName .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $vektonnBaseName .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "vektonn.shared.labels" -}}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "vektonn.api.name" -}}
{{- $vektonnName := include "vektonn.name" . -}}
{{- printf "%s-api" $vektonnName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "vektonn.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vektonn.api.name" . }}
{{- end }}

{{- define "vektonn.api.labels" -}}
{{ include "vektonn.shared.labels" . }}
{{ include "vektonn.api.selectorLabels" . }}
{{- end }}


{{- define "vektonn.indexShard.selectorLabels" -}}
app.kubernetes.io/name: {{ .indexShardName }}
{{- end }}

{{- define "vektonn.indexShard.labels" -}}
{{ include "vektonn.shared.labels" . }}
{{ include "vektonn.indexShard.selectorLabels" . }}
{{- end }}
