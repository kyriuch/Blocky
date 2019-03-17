#include <sourcemod>
#include <sdktools_functions>
#include <sdktools_engine>

#include "blocky-blocks-data.sp"
#include "blocky-state.sp"
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
}

public void OnPluginStart() 
{
    BlockyMenu blockyMenu;

    blockyMenu.RegisterMenus();
}