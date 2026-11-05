// Nusa Mokka: macOS-inspired menu bar and centered dock.
// Uses only Plasma's built-in widgets. Optional search is added when installed.

function addIfAvailable(panel, widgetType) {
    if (knownWidgetTypes.indexOf(widgetType) !== -1) {
        return panel.addWidget(widgetType);
    }
    print("Nusa layout: widget not installed, skipped " + widgetType);
    return null;
}

// Flat, full-width top menu bar.
var menuBar = new Panel;
menuBar.location = "top";
menuBar.floating = false;
menuBar.height = 36;
menuBar.lengthMode = "fill";
menuBar.alignment = "left";
menuBar.hiding = "dodgewindows";

addIfAvailable(menuBar, "org.kde.plasma.kickoff");
addIfAvailable(menuBar, "org.kde.plasma.panelspacer");
addIfAvailable(menuBar, "org.kde.plasma.lock_logout");
addIfAvailable(menuBar, "org.kde.plasma.search");
addIfAvailable(menuBar, "org.kde.plasma.volume");
addIfAvailable(menuBar, "org.kde.plasma.mediacontroller");

var clock = addIfAvailable(menuBar, "org.kde.plasma.digitalclock");
if (clock) {
    clock.currentConfigGroup = ["Appearance"];
    clock.writeConfig("showDate", true);
    clock.writeConfig("dateFormat", "custom");
    clock.writeConfig("customDateFormat", "ddd MMM d");
    clock.writeConfig("dateDisplayFormat", 1);
    clock.writeConfig("use24hFormat", 0);
    clock.writeConfig("showSeconds", 0);
}

// Bottom dock.
var dock = new Panel;
dock.location = "bottom";
dock.height = 56;
dock.lengthMode = "fit";
dock.alignment = "center";
dock.hiding = "dodgewindows";
dock.floating = true;

addIfAvailable(dock, "org.kde.plasma.kickoff");
addIfAvailable(dock, "org.kde.plasma.taskmanager");
addIfAvailable(dock, "org.kde.plasma.trash");
