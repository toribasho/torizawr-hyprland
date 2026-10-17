#!/usr/bin/env python3
import asyncio
import os
import socket
import obsws_python as obs

# Configuration
OBS_HOST = "localhost"
OBS_PORT = 4455
OBS_PASSWORD = "obspass"

# Map your workspaces to your OBS scene names
WORKSPACE_SCENE_MAP = {
    "3":  "HuntEmDown",
    "4":  "Zingal",
    "5":  "Linker",
    "13": "Futabuki"
}

async def handle_workspace_change(workspace_id):
    scene_name = WORKSPACE_SCENE_MAP.get(str(workspace_id))
    if scene_name:
        try:
            client = obs.ReqClient(host=OBS_HOST, port=OBS_PORT, password=OBS_PASSWORD)
            client.set_current_program_scene(scene_name)
            print(f"Switched OBS scene to: {scene_name}")
        except Exception as e:
            print(f"Failed to switch OBS scene: {e}")

async def listen_hyprland():
    xdg_runtime = os.getenv("XDG_RUNTIME_DIR")
    signature = os.getenv("HYPRLAND_INSTANCE_SIGNATURE")
    socket_path = f"{xdg_runtime}/hypr/{signature}/.socket2.sock"

    reader, _ = await asyncio.open_unix_connection(socket_path)
    
    while True:
        line = await reader.readline()
        if not line:
            break
        
        event = line.decode("utf-8").strip()
        if event.startswith("workspace>>"):
            ws_id = event.split(">>")[1]
            await handle_workspace_change(ws_id)

if __name__ == "__main__":
    asyncio.run(listen_hyprland())