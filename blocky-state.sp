#include <clients>

int CurrentBlockIndex[MAXPLAYERS + 1];
float CurrentBlockRotation[MAXPLAYERS + 1][3];
int CurrentBlockTrasparency[MAXPLAYERS + 1];
bool HasNoclip[MAXPLAYERS + 1];
bool IsImmortal[MAXPLAYERS + 1];

bool ExpectingInput[MAXPLAYERS + 1];
int ExpectingProperty[MAXPLAYERS + 1];
int ComponentToChange[MAXPLAYERS + 1];

enum
{
    Rotation,
    Transparency
}

public void ResetClientState(int client) 
{
    CurrentBlockIndex[client] = 0;
    CurrentBlockRotation[client][0] = 0.0;
    CurrentBlockRotation[client][1] = 0.0;
    CurrentBlockRotation[client][2] = 0.0;
    CurrentBlockTrasparency[client] = 250;
    ExpectingInput[client] = false;
    HasNoclip[client] = false;
    IsImmortal[client] = false;
}

public void CheckImmortalityAndNoclip() 
{
    for(int i = 1; i <= MAXPLAYERS; i++) 
    {
        if(IsClientConnected(i))
        {
            SetRightImmortalityState(i);
            SetRightNoclipState(i);
        }
    }
}

public void SetRightImmortalityState(int client)
{
    switch(IsImmortal[client])
    {
        case true: SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
        case false: SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
    }
}

public void SetRightNoclipState(int client)
{
    switch(HasNoclip[client])
    {
        case true: SetEntityMoveType(client, MOVETYPE_NOCLIP);
        case false: SetEntityMoveType(client, MOVETYPE_WALK);
    }
}