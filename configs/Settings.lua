-- Default Settings and gloabal variables

MainMod = "SUPER"
-- Default
ScriptsDir =  os.getenv("HOME") .. "/.config/hypr/scripts"
ConfigsDir =  os.getenv("HOME") .. "/.config/hypr/configs"
-- User
UserConfigs = os.getenv("HOME") .. "/.config/hypr/UserConfigs"
UserScripts = os.getenv("HOME") .. "/.config/hypr/UserScripts"

FilesManager = "nautilus"
DefaultTerminal = "kitty"

local function get_hostname()
    local file = io.open("/etc/hostname", "r")
    if file then
        -- Read the first line and trim any trailing spaces/newlines
        local name = file:read("*l"):gsub("%s+", "")
        file:close()
        return name
    end
    return "unknown"
end

HostMachine = get_hostname()   -- arch-legion or tiny-arch