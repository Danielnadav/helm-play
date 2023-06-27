{{/*
Expand the name of the chart.
*/}}
{{- define "nginx1.name" -}}
{{- default .Release.Name}}
{{- end }}


{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- default .Chart.Name}}
{{- end }}