#include <sourcemod>

methodmap BlockyMenu {
    public void RegisterMenus() {
        RegConsoleCmd("blocky", MainMenuAction);
    }
}

public void ExpectInput(int client, int expectingProperty, int componentToChange) 
{
    ExpectingInput[client] = true;
    ExpectingProperty[client] = expectingProperty;
    ComponentToChange[client] = componentToChange;
}

public Action OnClientSayCommand(int client, const char[] command, const char[] arg)
{
	if (ExpectingInput[client])	// Oczekujemy na input
	{
		switch (ExpectingProperty[client])
		{
			case Rotation: ChangeRotation(client, arg);
			case Transparency: ChangeTransparency(client, arg);
		}

		ExpectingInput[client] = false;

		return Plugin_Handled;
	}

	return Plugin_Continue;
}

public void ChangeRotation(int client, const char[] arg)
{
    float newValue = StringToFloat(arg);
    CurrentBlockRotation[client][ComponentToChange[client]] = newValue;
    PropertiesRotationMenuAction(client, 0);
}

public void ChangeTransparency(int client, const char[] arg)
{
	int newValue = StringToInt(arg);

	if(newValue < 0 || newValue > 255)
	{
		PrintToChat(client, "[Blocky] Value must be between 0 and 255.");

		return;
	}

	CurrentBlockTrasparency[client] = newValue;
	PropertiesMenuAction(client, 0);
}