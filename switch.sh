#!/bin/bash

# --- CONFIGURACIÓN DE VARIABLES ---
# Para ver el cambio en GitHub Actions, puedes editar estas 3 líneas:
export APP_TARGET_IP="192.168.1.20"
export APP_TARGET_PORT="8080"
export DEPLOYMENT_COLOR="Verde"

echo "Iniciando despliegue de entorno: $DEPLOYMENT_COLOR"

# 1. Procesar plantilla
envsubst '${APP_TARGET_IP} ${APP_TARGET_PORT} ${DEPLOYMENT_COLOR}' < nginx.conf.template | sudo tee /etc/nginx/conf.d/default.conf > /dev/null

# 2. Validar y Recargar (Adaptado para Cloud Shell y VM normal)
if sudo nginx -t; then
    sudo rm -f /etc/nginx/sites-enabled/default
    sudo nginx -s reload || sudo nginx
    echo "Despliegue exitoso: $DEPLOYMENT_COLOR"
else
    echo "Error en la configuración de Nginx"
    exit 1
fi
