#!/bin/bash

city=Batumi
cachedir=~/.cache/rbn
cachefile=${0##*/}-$1

if [ ! -d $cachedir ]; then
    mkdir -p $cachedir
fi

if [ ! -f $cachedir/$cachefile ]; then
    touch $cachedir/$cachefile
fi

# Save current IFS
SAVEIFS=$IFS
# Change IFS to new line.
IFS=$'\n'

cacheage=$(($(date +%s) - $(stat -c '%Y' "$cachedir/$cachefile")))
if [ $cacheage -gt 1740 ] || [ ! -s $cachedir/$cachefile ]; then
  weather_json=$(curl -s "https://en.wttr.in/$city?format=j1")
  echo $weather_json > "$cachedir/$cachefile"
else
  weather_json=($(cat $cachedir/$cachefile))
fi


temp=$(echo "$weather_json" | jq -r '.current_condition[0].temp_C')
feel_temp=$(echo "$weather_json" | jq -r '.current_condition[0].FeelsLikeC')
condition_str=$(echo "$weather_json" | jq -r '.current_condition[0].weatherDesc[0].value')
humidity=$(echo "$weather_json" | jq -r '.current_condition[0].humidity')
wind=$(echo "$weather_json" | jq -r '.current_condition[0].windspeedKmph')
wind_dir=$(echo "$weather_json" | jq -r '.current_condition[0].winddir16Point')

# Restore IFSClear
IFS=$SAVEIFS

# https://fontawesome.com/icons?s=solid&c=weather
case $(echo $condition_str | tr '[:upper:]' '[:lower:]') in
"clear" | "sunny")
    condition=""
    ;;
"partly cloudy")
    condition="󰖕"
    ;;
"cloudy")
    condition=""
    ;;
"overcast")
    condition=""
    ;;
"fog" | "freezing fog")
    condition=""
    ;;
"patchy rain possible" | "patchy light drizzle" | "light drizzle" | "patchy light rain" | "light rain" | "light rain shower" | "mist" | "rain")
    condition="󰼳"
    ;;
"moderate rain at times" | "moderate rain" | "heavy rain at times" | "heavy rain" | "moderate or heavy rain shower" | "torrential rain shower" | "rain shower")
    condition=""
    ;;
"patchy snow possible" | "patchy sleet possible" | "patchy freezing drizzle possible" | "freezing drizzle" | "heavy freezing drizzle" | "light freezing rain" | "moderate or heavy freezing rain" | "light sleet" | "ice pellets" | "light sleet showers" | "moderate or heavy sleet showers")
    condition="󰼴"
    ;;
"blowing snow" | "moderate or heavy sleet" | "patchy light snow" | "light snow" | "light snow showers")
    condition="󰙿"
    ;;
"blizzard" | "patchy moderate snow" | "moderate snow" | "patchy heavy snow" | "heavy snow" | "moderate or heavy snow with thunder" | "moderate or heavy snow showers")
    condition=""
    ;;
"thundery outbreaks possible" | "patchy light rain with thunder" | "moderate or heavy rain with thunder" | "patchy light snow with thunder")
    condition=""
    ;;
*)
    condition=""
    #echo -e "{\"text\":\""$condition"\", \"alt\":\""${weather[0]}"\", \"tooltip\":\""${weather[0]}: $temperature ${weather[1]}"\"}"
    ;;
esac

#echo $temp $condition

temperature="$temp($feel_temp)°C \nHumidity:$humidity% \nWind:$wind->$wind_dir"
temp_short="$temp($feel_temp)°C"

# Example logic for dynamic coloring
if [ "$temp" -le 0 ]; then
    temp_color="#7aa2f7" # Cold Blue
elif [ "$temp" -gt 25 ]; then
    temp_color="#f7768e" # Hot Red
else
    temp_color="#9ece6a" # Nice Green
fi

# Construct the tooltip with Pango markup
tooltip="<span color='$temp_color'>$city: $temp($feel_temp)°C</span>
<span color='#e0af68'>Humidity: $humidity%</span>
<span color='#bb9af7'>Wind: $wind->$wind_dir</span>"

color_temp="<span color='$temp_color'>$temp($feel_temp)°C $condition</span>"

jq -n -c \
  --arg text "$color_temp" \
  --arg alt "$condition_str" \
  --arg tooltip "$tooltip" \
  '{text: $text, alt: $alt,  tooltip: $tooltip}'

#  --arg text "$temp_short $condition" \

cached_weather=" $temperature  \n$condition $condition_str"

echo -e $cached_weather >  ~/.cache/.weather_cache
