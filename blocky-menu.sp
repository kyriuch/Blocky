#include <sourcemod>

methodmap BlockyMenu {
    public void RegisterMenus() {
        RegConsoleCmd("blocky", MainMenuAction);
        RegConsoleCmd("blocky-select-block", SelectBlockMenuAction);
    }
}