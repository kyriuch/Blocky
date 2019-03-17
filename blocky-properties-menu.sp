#include <sourcemod>

public Action PropertiesMenuAction(int client, int args) 
{
    Menu menu = new Menu(PropertiesMenuHandler);

    menu.SetTitle("[Blocky] Block Properties");

    menu.AddItem("", "Rotation");

    menu.Display(client, 0);

    return Plugin_Handled;
}

public int PropertiesMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action) 
    {
        case MenuAction_Select: HandlePropertiesMenuSelect(param1, param2);
        case MenuAction_Cancel: PrintToServer("Client %d's menu was cancelled. Reason: %d.", param1, param2);
        case MenuAction_End: delete menu;
    }
}

public void HandlePropertiesMenuSelect(int param1, int param2)
{
    switch(param2) 
    {
        case 0: PropertiesRotationMenuAction(param1, 0);
    }
}