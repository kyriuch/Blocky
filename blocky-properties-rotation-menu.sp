#include <sourcemod>

public Action PropertiesRotationMenuAction(int client, int args) 
{
    Menu menu = new Menu(PropertiesRotationMenuHandler);

    menu.SetTitle("[Blocky] Block Rotation");

    for(int i = 0; i < sizeof CurrentBlockRotation[]; i++) 
    {
        char menuItem[8];
        Format(menuItem, sizeof menuItem, "%f", CurrentBlockRotation[client][i]);
        menu.AddItem("", menuItem);
    }

    menu.Display(client, 0);

    return Plugin_Handled;
}

public int PropertiesRotationMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action) 
    {
        case MenuAction_Select: HandlePropertiesRotationMenuSelect(param1, param2);
        case MenuAction_Cancel: PrintToServer("Client %d's menu was cancelled. Reason: %d.", param1, param2);
        case MenuAction_End: delete menu;
    }
}

public void HandlePropertiesRotationMenuSelect(int param1, int param2)
{
    ExpectInput(param1, Rotation, param2);
    PropertiesRotationMenuAction(param1, 0);
}