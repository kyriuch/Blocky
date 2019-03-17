#include <sdktools_stringtables>
#include <sdktools_functions>
#include <entity_prop_stocks>
#include <sdktools_entinput>
#include <halflife>

char blocks[][] = {
    "models/blockbuilder/awp",
};

char materials[][] = {
    "materials/models/blockbuilder/awp"
}

public void AddFileWithAnExtension(char[] fileName, char[] extension) {
    char wholeName[128];

    Format(wholeName, sizeof(wholeName), "%s%s", fileName, extension);

    AddFileToDownloadsTable(wholeName);
}

methodmap BlocksMethods {

    public void FindAndSetBlockPosition(int client, float blockPosition[3]) {
        float clientEyesDirection[3], direction[3];

        GetClientEyeAngles(client, clientEyesDirection);
        GetAngleVectors(clientEyesDirection, direction, NULL_VECTOR, NULL_VECTOR);
        GetClientEyePosition(client, blockPosition);

        for(int i = 0; i < 3; i++) {
            blockPosition[i] += direction[i] * 100.0;
        }
    }

    public int PlaceBlockAtPositionWithModel(float position[3], char[] modelName) {
        float blockAngle[3] = {0.0, 0.0, 0.0};
        
        int entIndex = CreateEntityByName("prop_physics_override");
        PrintToChatAll("%d", entIndex);
        DispatchKeyValue(entIndex, "model", modelName);
        TeleportEntity(entIndex, position, blockAngle, NULL_VECTOR);
        DispatchSpawn(entIndex);
        SetEntityMoveType(entIndex, MOVETYPE_NONE);
        SetEntityRenderMode(entIndex, RENDER_TRANSCOLOR);
        SetEntityRenderColor(entIndex, 255, 255, 255, 150);
        AcceptEntityInput(entIndex, "disablemotion");

        return entIndex;
    }

    public void PrepareDownloadsTable() {
        for(int i = 0; i < sizeof(blocks); i++) {
            AddFileWithAnExtension(blocks[i], ".mdl");
            AddFileWithAnExtension(blocks[i], ".dx80.vtx");
            AddFileWithAnExtension(blocks[i], ".dx90.vtx");
            AddFileWithAnExtension(blocks[i], ".phy");
            AddFileWithAnExtension(blocks[i], ".sw.vtx");
            AddFileWithAnExtension(blocks[i], ".vvd");
            char buffer[128];
            Format(buffer, sizeof(buffer), "%s.mdl", blocks[i]);
            PrecacheModel(buffer);
        }

        for(int i = 0; i < sizeof(materials); i++) {
            AddFileWithAnExtension(materials[i], ".vtf");
            AddFileWithAnExtension(materials[i], ".vmt");
        }
    }
}