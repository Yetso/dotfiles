#!/usr/bin/env bash

# Launch pavucontrol
pavucontrol &
PID=$!

# Give it a moment to start
sleep 0.5

# Function to get the currently active window class
get_active_window_class() {
    hyprctl activewindow | grep 'Class:' | awk '{print $2}'
}

# Main loop: check focus
while kill -0 $PID 2>/dev/null; do
    ACTIVE_CLASS=$(get_active_window_class)

    if [[ "$ACTIVE_CLASS" != "org.pulseaudio.pavucontrol" ]]; then
        # If the active window is not pavucontrol, close it
        kill $PID
        break
    fi

    sleep 0.5  # check 5 times per second
done
