#include <sdktools_stringtables>
#include <sdktools_functions>
#include <entity_prop_stocks>
#include <sdktools_entinput>
#include <halflife>
#include <vector>
#include <sdktools_engine>
#include <smlib>

public void AddFileWithAnExtension(const char[] dir, const char[] fileName, const char[] extension) 
{
    char wholeName[128];

    Format(wholeName, sizeof wholeName, "%s%s%s", dir, fileName, extension);

    AddFileToDownloadsTable(wholeName);
}

public void PrecacheModelFromDir(const char[] dir, const char[] model) 
{
    char wholeName[128];

    Format(wholeName, sizeof wholeName, "%s%s.mdl", dir, model);

    PrecacheModel(wholeName);
}

methodmap BlockyBlockMethods 
{
    public void PlaceBlock(int client)
    {
        float clientEyesDirection[3], placeDirection[3], blockPosition[3];
        
        
        GetClientEyeAngles(client, clientEyesDirection);
        GetAngleVectors(clientEyesDirection, placeDirection, NULL_VECTOR, NULL_VECTOR);
        GetClientEyePosition(client, blockPosition);

        for(int i = 0; i < 3; i++) 
        {
            blockPosition[i] += placeDirection[i] * 150.0;
        }

        int entIndex = CreateEntityByName("prop_physics_override");

        if(!Entity_IsValid(entIndex)) 
        {
            return;
        }
        
        char model[128];
        Format(model, sizeof model, "%s%s.mdl", MODELS_DIR, BlocksFiles[CurrentBlockIndex[client]]);
        SetEntityModel(entIndex, model);

        TeleportEntity(entIndex, blockPosition, CurrentBlockRotation[client], NULL_VECTOR);
        DispatchSpawn(entIndex);
        SetEntityMoveType(entIndex, MOVETYPE_NONE);
        SetEntityRenderMode(entIndex, RENDER_TRANSCOLOR);
        SetEntityRenderColor(entIndex, 255, 255, 255, CurrentBlockTrasparency[client]);
        Entity_DisableMotion(entIndex);
    }

    public void PrepareDownloadsTableAndPrecacheModels() 
    {
        for(int i = 0; i < sizeof BlocksFiles; i++)
        {
            AddFileWithAnExtension(MODELS_DIR, BlocksFiles[i], ".mdl");
            AddFileWithAnExtension(MODELS_DIR, BlocksFiles[i], ".dx80.vtx");
            AddFileWithAnExtension(MODELS_DIR, BlocksFiles[i], ".dx90.vtx");
            AddFileWithAnExtension(MODELS_DIR, BlocksFiles[i], ".phy");
            AddFileWithAnExtension(MODELS_DIR, BlocksFiles[i], ".sw.vtx");
            AddFileWithAnExtension(MODELS_DIR, BlocksFiles[i], ".vvd");
            PrecacheModelFromDir(MODELS_DIR, BlocksFiles[i]);
        }

        for(int i = 0; i < sizeof BlocksFiles; i++) 
        {
            AddFileWithAnExtension(MATERIALS_DIR, BlocksFiles[i], ".vtf");
            AddFileWithAnExtension(MATERIALS_DIR, BlocksFiles[i], ".vmt");
        }
    }
}