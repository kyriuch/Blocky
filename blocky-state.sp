int CurrentBlockIndex[MAXPLAYERS + 1];
float CurrentBlockRotation[MAXPLAYERS + 1][3];

bool ExpectingInput[MAXPLAYERS + 1];
int ExpectingProperty[MAXPLAYERS + 1];
int ComponentToChange[MAXPLAYERS + 1];

enum
{
    Rotation
}