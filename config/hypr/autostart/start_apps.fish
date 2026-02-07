#!/usr/bin/env fish

#Abre o Spotify na workspace 2
hyprctl dispatch workspace 2
spotify &


# Volta para workspace 1 (opcional)
hyprctl dispatch workspace 1

