#include <sourcemod>

public Action MainMenuAction(int client, int args) 
{
    Menu menu = new Menu(MainMenuHandler);

    char title[128];

    Format(title, sizeof title, "[Blocky] %s", BlocksNames[CurrentBlockIndex[client]]);
    menu.SetTitle(title);

    menu.AddItem("", "Select Block");
    menu.AddItem("", "Place Block");

    menu.Display(client, 0);

    return Plugin_Handled;
}

public int MainMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action) 
    {
        case MenuAction_Select: HandleMainMenuSelect(param1, param2);
        case MenuAction_Cancel: PrintToServer("Client %d's menu was cancelled. Reason: %d.", param1, param2);
        case MenuAction_End: delete menu;
    }
}

public void HandleMainMenuSelect(int param1, int param2)
{
    BlockyBlockMethods blockyBlockMethods;

    switch(param2) 
    {
        case 0: SelectBlockMenuAction(param1, 0);
        case 1:
        {
            blockyBlockMethods.PlaceBlock(param1);
            MainMenuAction(param1, 0);
        }
    }
}