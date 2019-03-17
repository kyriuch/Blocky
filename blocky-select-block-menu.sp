#include <sourcemod>

public Action SelectBlockMenuAction(int client, int args) 
{
    Menu menu = new Menu(SelectBlockMenuHandler);

    menu.SetTitle("[Blocky] Select Block");

    for(int i = 0; i < sizeof BlocksNames; i++)
    {
        menu.AddItem(MODELS_DIR, BlocksNames[i]);
    }

    menu.Display(client, 0);

    return Plugin_Handled;
}

public int SelectBlockMenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action) 
    {
        case MenuAction_Select: HandleSelectBlockMenuSelect(param1, param2);
        case MenuAction_Cancel: PrintToServer("Client %d's menu was cancelled. Reason: %d.", param1, param2);
        case MenuAction_End: delete menu;
    }
}

public void HandleSelectBlockMenuSelect(int param1, int param2)
{
    if(param1 >= 0 && param1 <= MAXPLAYERS)
        CurrentBlockIndex[param1] = param2;

    MainMenuAction(param1, 0);
}