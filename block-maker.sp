#include <sourcemod>
#include <sdktools_functions>
#include <sdktools_engine>
#include "block.sp"

public Plugin PluginInformation =
{
    name = "Blocky",
    author = "kyriuch",
    description = "Block maker plugin for CS:GO",
    version = "1.0",
    url = "http://www.sourcemod.net"
}

public void OnMapStart() {
    Block block;
    block.PrepareDownloadsTable();
}

public void OnPluginStart() 
{
    RegConsoleCmd("place_block", PlaceBlockAction);
}

public Action PlaceBlockAction(int client, int args) 
{
    float blockPosition[3];

    Block block;
    block.FindAndSetBlockPosition(client, blockPosition);
    int entIndex = block.PlaceBlockAtPositionWithModel(blockPosition, "models/blockbuilder/awp.mdl");
    PrintToChat(client, "Ent spawned %d", entIndex);

    return Plugin_Handled;
}