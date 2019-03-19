#include <adt_array>
#include <entity>
#include <entity_prop_stocks>

char MODELS_DIR[] = "models/blockbuilder/"
char MATERIALS_DIR[] = "materials/models/blockbuilder/"

char BlocksNames[2][] = 
{
    "Bunnyhop",
    "Awp"
};

char BlocksFiles[2][] =
{
    "bhop",
    "awp",
};


// BLOCKS ON THE MAP

ArrayList blockEntities;

/* 
    Block 0 - ent id
    Block 1 - block id
    Block 2-4 - position
    Block 5-7 - rotation
    Block 8 - transparency
*/

public void InitBlockEntitiesList()
{
    if(blockEntities != null)
    {
        delete blockEntities;
    }

    blockEntities = new ArrayList(1);
}

enum BlockData
{
    EntityId,
    BlockId,
    Float:BlockPosition[3],
    Float:BlockRotation[3],
    BlockTrasnparency
}

public void AddBlockEntity(int blockEntityId, int client)
{
    int transparencyOffset;
    new blockData[BlockData];

    blockData[EntityId] = blockEntityId;
    blockData[BlockId] = CurrentBlockIndex[client];

    GetEntPropVector(blockEntityId, Prop_Data, "m_vecOrigin", blockData[BlockPosition]);
    GetEntPropVector(blockEntityId, Prop_Data, "m_angRotation", blockData[BlockRotation]);

    transparencyOffset = GetEntSendPropOffs(blockEntityId, "m_clrRender");
    blockData[BlockTrasnparency] = GetEntData(blockEntityId, transparencyOffset + 3, 1);
}