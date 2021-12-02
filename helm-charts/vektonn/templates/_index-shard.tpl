{{- define "vektonn.indexShard" -}}
{{- $indexShardValues := index .Values.vektonnIndexShards .indexShardName -}}
{{- $indexShardValues := $indexShardValues | required (printf ".Values.vektonnIndexShards.%s section is missing!" .indexShardName) -}}
{{- $mergedContext := mergeOverwrite . (dict "indexShardValues" $indexShardValues) -}}
---
{{ include "vektonn.indexShard.deployment" $mergedContext }}
---
{{ include "vektonn.indexShard.service" $mergedContext }}
{{- end -}}
