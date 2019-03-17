#include <sourcemod>

public Action MainMenuAction(int client, int args) 
{
    Menu menu = new Menu(MainMenuHandler);

    char title[128];

    Format(title, sizeof title, "[Blocky] %s", BlocksNames[CurrentBlockIndex[client]]);
    menu.SetTitle(title);

    menu.AddItem("", "Select Block");
    menu.AddItem("", "Place Block");
    menu.AddItem("", "Set Properties");
    
    char noclipItem[32], immortalityItem[32];
    Format(noclipItem, sizeof noclipItem, "Noclip: %s", HasNoclip[client] ? "ON" : "OFF");
    Format(immortalityItem, sizeof immortalityItem, "Immortality: %s", IsImmortal[client] ? "ON" : "OFF");
    menu.AddItem("", noclipItem);
    menu.AddItem("", immortalityItem);

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
        case 2: PropertiesMenuAction(param1, 0);
        case 3: ToggleNoclip(param1);
        case 4: ToggleImmortality(param1);
    }
}

public void ToggleNoclip(int client) 
{
    HasNoclip[client] = !HasNoclip[client];

    switch(HasNoclip[client])
    {
        case true: SetEntityMoveType(client, MOVETYPE_NOCLIP);
        case false: SetEntityMoveType(client, MOVETYPE_WALK);
    }

    MainMenuAction(client, 0);
}

public void ToggleImmortality(int client) 
{
    IsImmortal[client] = !IsImmortal[client];

    switch(IsImmortal[client])
    {
        case true: SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
        case false: SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
    }

    MainMenuAction(client, 0);
}