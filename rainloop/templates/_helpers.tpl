{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rainloop.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rainloop.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if cat .Release.Name | contains "$name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rainloop.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "std.labels" }}
  heritage: {{ .Release.Service }}
  release: {{ .Release.Name }}
  chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
  app: {{ template "rainloop.name" . }}
{{- end }}

{{/*
Give true as default value. Used like this: trim "   "| defaulttrue.
Since trim produces an empty string, the default value true is returned. For
things with a length (strings, slices, maps), len(0) will trigger the default.
For numbers, the value 0 will trigger the default. For booleans, the value is
passed as is. For structs, the default is never returned (there is no clear
empty condition). For everything else, nil value triggers a default.
*/}}
{{- define "defaulttrue" -}}
  {{- if typeIs "bool" . -}}
    {{- . -}}
  {{- else -}}
    {{- default true . -}}
  {{- end -}}
{{- end -}}
