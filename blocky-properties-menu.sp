#include <sourcemod>

public Action PropertiesMenuAction(int client, int args) 
{
    Panel panel = new Panel();

    panel.SetTitle("[Blocky] Block Properties");
    panel.DrawItem("Rotation");

    char transparencyItem[32];
    Format(transparencyItem, sizeof transparencyItem, "Trasnaprency: %d", CurrentBlockTrasparency[client]);
    panel.DrawItem(transparencyItem);

    panel.DrawText("\n ");
    panel.CurrentKey = 8;
    panel.DrawItem("Back");
    panel.DrawItem("Exit");

    panel.Send(client, PropertiesMenuHandler, 0);

    delete panel;

    return Plugin_Handled;
}

public int PropertiesMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action) 
    {
        case MenuAction_Select: HandlePropertiesMenuSelect(param1, param2);
        case MenuAction_Cancel: PrintToServer("Client %d's menu was cancelled. Reason: %d.", param1, param2);
    }
}

public void HandlePropertiesMenuSelect(int param1, int param2)
{
    switch(param2) 
    {
        case 1: PropertiesRotationMenuAction(param1, 0);
        case 2:
        {
            ExpectInput(param1, Transparency, 0);
            PrintToChat(param1, "[Blocky] Provide value in the chat.");
            PropertiesMenuAction(param1, 0);
        }
        case 8: MainMenuAction(param1, 0);
    }
}