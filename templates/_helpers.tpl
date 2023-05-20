{{/*
Expand the name of the chart.
*/}}
{{- define "webserver1.name" -}}
{{- default .Release.Name}}
{{- end }}


{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- default .Chart.Name}}
{{- end }}