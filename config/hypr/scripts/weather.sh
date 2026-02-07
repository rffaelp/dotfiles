#!/bin/bash

# Configurações
CITY="Campo_Grande,Sao_Paulo"
UNIT="m" # m para métrico (Celsius)

# Cores Catppuccin Mocha
COLOR_SUN="#f9e2af"
COLOR_CLOUD="#6c7086"
COLOR_RAIN="#74c7ec"
COLOR_SNOW="#FFFFFF"
COLOR_THUNDER="#d3b987"
COLOR_WHITE="#cdd6f4"

# Busca os dados (Clima e Temperatura)
# Usamos o formato v2 do wttr que é mais fácil de limpar
#weather_data=$(curl -s "wttr.in/$CITY?format=%c+%t")
weather_data=$(curl --http1.1 -4 -s -A "Mozilla/5.0" "https://wttr.in/$CITY?format=%c+%t" \
  || curl --http1.1 -4 -s -A "Mozilla/5.0" "https://wttr.in/$CITY?format=%t")



if [ $? -ne 0 ] || [ -z "$weather_data" ]; then
    echo "{\"text\": \"\", \"tooltip\": \"Sem conexão\"}"
    exit 0
fi

# Separa o ícone da temperatura
ICON=$(echo $weather_data | awk '{print $1}')
TEMP=$(echo $weather_data | awk '{print $2}' | sed 's/+//;s/°C//')

# Define a cor do ícone baseado no símbolo que o wttr envia
case $ICON in
    "☀️"|"🌞") ICON_COLOR=$COLOR_SUN ;;
    "☁️"|"⛅"|"🌥️"|"🌦️") ICON_COLOR=$COLOR_CLOUD ;;
    "🌧️"|"⛈️"|"🌨️") ICON_COLOR=$COLOR_RAIN ;;
    "⚡") ICON_COLOR=$COLOR_THUNDER ;;
    *) ICON_COLOR=$COLOR_WHITE ;;
esac

# Output para Waybar
echo "{ \"text\": \"<span color='$ICON_COLOR'>$ICON</span> $TEMP°C\", \"tooltip\": \"Clima em São Paulo\", \"class\": \"weather\" }"