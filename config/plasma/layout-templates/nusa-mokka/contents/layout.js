// Nusa Mokka: macOS-inspired menu bar and centered dock.
// Uses only Plasma's built-in widgets. Optional search is added when installed.

function addIfAvailable(panel, widgetType) {
    if (knownWidgetTypes.indexOf(widgetType) !== -1) {
        return panel.addWidget(widgetType);
    }
    print("Nusa layout: widget not installed, skipped " + widgetType);
    return null;
}

// Top menu bar.
var menuBar = new Panel;
menuBar.location = "top";
menuBar.height = 36;
menuBar.lengthMode = "fill";
menuBar.alignment = "center";
menuBar.hiding = "none";

addIfAvailable(menuBar, "org.kde.plasma.kickoff");
addIfAvailable(menuBar, "org.kde.plasma.panelspacer");
addIfAvailable(menuBar, "org.kde.plasma.lock_logout");
addIfAvailable(menuBar, "org.kde.plasma.digitalclock");
addIfAvailable(menuBar, "org.kde.plasma.search");
addIfAvailable(menuBar, "org.kde.plasma.volume");
addIfAvailable(menuBar, "org.kde.plasma.mediacontroller");

// Bottom dock.
var dock = new Panel;
dock.location = "bottom";
dock.height = 56;
dock.lengthMode = "fit";
dock.alignment = "center";
dock.hiding = "dodgewindows";

addIfAvailable(dock, "org.kde.plasma.kickoff");
addIfAvailable(dock, "org.kde.plasma.taskmanager");
addIfAvailable(dock, "org.kde.plasma.panelspacer");
addIfAvailable(dock, "org.kde.plasma.trash");
