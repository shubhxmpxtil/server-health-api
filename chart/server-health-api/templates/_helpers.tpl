{{- define "sha.name" -}}
server-health-api
{{- end }}

{{- define "sha.fullname" -}}
{{ .Release.Name }}
{{- end }}

{{- define "sha.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sha.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "sha.labels" -}}
{{ include "sha.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
