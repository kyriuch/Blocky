#include <sourcemod>

public Action PropertiesRotationMenuAction(int client, int args) 
{
    Panel panel = new Panel();

    panel.SetTitle("[Blocky] Block Rotation");

    for(int i = 0; i < sizeof CurrentBlockRotation[]; i++) 
    {
        char panelItem[16];
        Format(panelItem, sizeof panelItem, "%s: %f", ComponentNames[i], CurrentBlockRotation[client][i]);
        panel.DrawItem(panelItem);
    }

    panel.DrawText("\n ");
    panel.CurrentKey = 8;
    panel.DrawItem("Back");
    panel.DrawItem("Exit");

    panel.Send(client, PropertiesRotationMenuHandler, 0);

    delete panel;

    return Plugin_Handled;
}

public int PropertiesRotationMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action) 
    {
        case MenuAction_Select: HandlePropertiesRotationMenuSelect(param1, param2);
        case MenuAction_Cancel: PrintToServer("Client %d's menu was cancelled. Reason: %d.", param1, param2);
    }
}

public void HandlePropertiesRotationMenuSelect(int param1, int param2)
{
    switch(param2)
    {
        case 1, 2, 3:
        {
            ExpectInput(param1, Rotation, param2 - 1);
            PrintToChat(param1, "[Blocky] Provide value in the chat.");
            PropertiesRotationMenuAction(param1, 0);
        }
        case 8: PropertiesMenuAction(param1, 0);
    }
}