#!/usr/bin/python3

from datetime import datetime
import json
import time


meminfo_path = "/proc/meminfo"
meminfo_to_collect = ["MemTotal", "MemFree", "MemAvailable"]
loadavg_path = "/proc/loadavg"
uptime_path = "/proc/uptime"
filename_base = "awesome-monitoring"
log_path = "/var/log"


def fill_with_memory_data(system_data):
    with open(meminfo_path, "r") as meminfo:
        for line in meminfo:
            key, value = line.split(":")
            if key in meminfo_to_collect:
                system_data[key] = value.lstrip().rstrip()

def fill_with_loadavg(system_data):
    with open(loadavg_path, "r") as loadavg:
        system_data["Load Average 1m"], system_data["Load Average 5m"], system_data["Load Average 15m"], _, _ = loadavg.read().split()

def fill_with_uptime(system_data):
    with open(uptime_path, "r") as uptime:
        system_data["Uptime"], _ = uptime.read().split()

def write_system_data(system_data):
    filename = get_filename()
    system_data_string = f" { json.dumps(system_data) }\n"
    
    with open(filename, "a") as log:
        log.write(system_data_string)

def get_filename():
    current_date = datetime.now().strftime("%y-%m-%d")
    return f"{log_path}/{ current_date }-{ filename_base }.log"

if __name__ == "__main__":
    system_data = {"timestamp": int(time.time())}
    
    fill_with_memory_data(system_data)
    fill_with_loadavg(system_data)
    fill_with_uptime(system_data)

    write_system_data(system_data)
