import Gtk from "gi://Gtk?version=3.0";
import Gdk from "gi://Gdk";
// Use native GLib library which is guaranteed to exist on any Linux system with GTK
import GLib from "gi://GLib";

const SUPERModKey = 64

// 1. Fetch Hyprland binds cleanly using native GLib channels
const getHyprBinds = () => {
    try {
        // Spawns a synchronous shell process and captures standard output
        const [success, stdout, stderr, exitStatus] = GLib.spawn_command_line_sync('hyprctl binds -j');
        
        if (!success) {
            console.error("Failed to execute hyprctl command");
            return [];
        }
        
        // Convert the raw byte array output from GLib into a readable string
        const outputString = new TextDecoder().decode(stdout);
        return JSON.parse(outputString);
    } catch (e) {
        console.error("Failed to parse hyprctl binds:", e);
        return [];
    }
};

const binds = getHyprBinds();

// 2. Define standard physical layout map (60% layout example)
const KEYBOARD_ROWS = [
    ["Escape", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "PrtSc"],
    ["`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "BackSpace"],
    ["Tab", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[", "]", "\\"],
    ["Caps_Lock", "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'", "Return"],
    ["Shift_L", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/", "Shift_R"],
    ["Control_L", "Super_L", "Alt_L", "space", "Alt_R", "Super_R", "Control_R"]
];

const findBind = (keyLabel) => {
    const target = keyLabel.toLowerCase();
    
    // 1. Filter ALL binds to find entries that match this specific physical key cap
    const matchingKeys = binds.filter(b => {
        const bKey = b.key.toLowerCase();
        if (target === "`" && bKey === "") return true;
        // if (target === "space" && bKey === "") return true;
        return bKey === target;
    });

    // 2. Out of those matching physical keys, look for the ONE that matches our exact modmask
    return matchingKeys.find(b => b.modmask === SUPERModKey);
};

// 3. UI Component for an Individual Key using Native GTK3
const KeyCap = (keyLabel) => {
    const bind = findBind(keyLabel);
    const hasBind = !!bind;

    const button = new Gtk.Button({
        label: keyLabel,
        visible: true,
    });

    const context = button.get_style_context();
    context.add_class("key-cap");
    context.add_class(hasBind ? "active-bind" : "empty-key");

    if (hasBind) {
        // Fallback to the dispatcher action text if no description exists in the Lua block
        const hintText = bind.description || `${bind.dispatcher}: ${bind.arg || 'None'}`;
        button.set_tooltip_text(hintText);
        
        button.connect("clicked", () => {
            if (bind.dispatcher === "exec") {
                GLib.spawn_command_line_async(bind.arg);
            }
        });
    } else {
        button.set_tooltip_text("No binding configuration");
    }

    return button;
};

// 4. Group KeyCaps into horizontal rows
const KeyboardRow = (rowKeys) => {
    const box = new Gtk.Box({
        orientation: Gtk.Orientation.HORIZONTAL,
        spacing: 4,
        visible: true,
    });
    
    box.set_halign(Gtk.Align.CENTER);

    rowKeys.forEach(key => {
        box.pack_start(KeyCap(key), false, false, 0);
    });

    return box;
};

// 5. Assemble rows into a full layout panel
const KeyboardLayout = () => {
    const box = new Gtk.Box({
        orientation: Gtk.Orientation.VERTICAL,
        spacing: 4,
        visible: true,
    });

    KEYBOARD_ROWS.forEach(row => {
        box.pack_start(KeyboardRow(row), false, false, 0);
    });

    return box;
};

// 6. Wrap layout into a GTK Window container
const createKeyboardWindow = () => {
    const win = new Gtk.Window({
        type: Gtk.WindowType.TOPLEVEL,
        title: "Active Hyprland Keybindings Map",
        name: "hypr-keybind-board",
    });

    win.connect("destroy", () => Gtk.main_quit());

    const mainBox = new Gtk.Box({
        orientation: Gtk.Orientation.VERTICAL,
        spacing: 18,
        visible: true,
    });
    
    const context = mainBox.get_style_context();
    context.add_class("window-bg");

    const titleLabel = new Gtk.Label({
        label: "Active Hyprland Keybindings Map",
        visible: true
    });
    const titleContext = titleLabel.get_style_context();
    titleContext.add_class("window-title");

    mainBox.pack_start(titleLabel, false, false, 0);
    mainBox.pack_start(KeyboardLayout(), true, true, 0);

    win.add(mainBox);
    win.set_position(Gtk.WindowPosition.CENTER);
    win.show_all();
    return win;
};

// Start the core GTK application loop FIRST so the Gdk.Screen connection activates
Gtk.init(null);

// Load CSS Styling natively in GTK3 NOW that the screen display is ready
const cssProvider = new Gtk.CssProvider();
cssProvider.load_from_path(`${import.meta.dirname}/style.css`);
Gtk.StyleContext.add_provider_for_screen(
    Gdk.Screen.get_default(),
    cssProvider,
    Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
);

// Spawn the window container and start the engine
createKeyboardWindow();
Gtk.main();