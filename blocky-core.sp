#include <sourcemod>

#include "blocky-state.sp"
#include "blocky-blocks-data.sp"
#include "blocky-global.sp"
#include "blocky-block-methods.sp"

#include "blocky-menu.sp"
#include "blocky-main-menu.sp"
#include "blocky-select-block-menu.sp"
#include "blocky-properties-menu.sp"
#include "blocky-properties-rotation-menu.sp"

public Plugin PluginInformation =
{
    name = "Blocky",
    author = "kyriuch",
    description = "Block maker plugin for CS:GO",
    version = "1.0",
    url = "http://www.sourcemod.net"
}

public void OnMapStart() {
    BlockyBlockMethods blockyBlockMethod;

    blockyBlockMethod.PrepareDownloadsTableAndPrecacheModels();
    InitBlockEntitiesList();
}

public void OnPluginStart() 
{
    BlockyMenu blockyMenu;

    blockyMenu.RegisterMenus();

    HookEvent("round_start", RoundStartAction, EventHookMode_Pre);
    HookEvent("round_end", RoundEndAction, EventHookMode_Pre);
}

public void OnClientConnected(int client)
{
    ResetClientState(client);
}

public Action RoundStartAction(Event event, const char[] name, bool dontBroadcast)
{
    CheckImmortalityAndNoclip();
}

public Action RoundEndAction(Event event, const char[] name, bool dontBroadcast)
{
}