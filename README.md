# GSC Command Script for Call of Duty

This repository contains a GSC script designed to add custom admin commands to a Call of Duty server. The script allows administrators to manage the server through various commands such as kicking, banning, warning players, and more. The script also includes a help system to list available commands and provide information about each one.

## Features

- **Admin Commands**: Includes commands to kick, ban, warn, teleport, kill players, and more.
- **Help System**: Players can use the `!commands` command to list all available commands and `!help [command]` to get details on a specific command.
- **Easy Configuration**: The script is easily customizable to add or modify commands.

## Available Commands

- `!test` - Simple test command to check if the script is working.
- `!test-admin` - Checks if the player is an admin.
- `!kick [player]` - Kicks the specified player from the server.
- `!ban [player]` - Bans the specified player from the server.
- `!warn [player]` - Issues a warning to the specified player.
- `!tp [player1] [player2]` - Teleports `player1` to `player2`.
- `!kill [player]` - Kills the specified player.
- `!switch [player]` - Switches the specified player's team.
- `!exec [command]` - Executes a server command.
- `!commands` - Lists all available commands.
- `!help [command]` - Provides details about the specified command.

## Installation

1. Clone this repository or download the script file.
2. Place the script in your server's GSC directory, typically under `user_scripts/mp/`.
3. Edit the script to configure your admin XUIDs in the `admins` array.
4. Include the script in your server's main GSC script by adding `level thread your_script_name::init();`.
5. Start your server. The script will be automatically loaded and ready to use.

## Configuration

### Adding Admins

To add more admins, simply add their XUIDs to the `admins` array:

```gsc
admins = ["your_xuid", "another_admin_xuid", "another_admin_xuid"];
```
## Customizing System Name

You can customize the system name that appears in messages by modifying the level.systemName variable:
```gsc
level.systemName = "[^:Your-Custom-Name^7] ";
```

## Extending the Script

To add new commands, follow these steps:

1. Define the command in the switch(args[0]) statement in the command_listener function.
2. Add the corresponding function to handle the command logic.
3. If the command requires parameters, process them using the args array.
4. Update the listCommands and commandHelp functions to include the new command.

### Example: Adding a !mute Command
1. Add the command to the listener:
```gsc
case "!mute":
    if(isInArray(admins, player.xuid)){
        if(args.size >= 2){
            targetPlayer = getPlayerByName(args[1]);
            if(targetPlayer != undefined){
                mutePlayer(targetPlayer);
                announce("Muted player " + targetPlayer.name);
            } else {
                tell_sender("Player not found");
            }
        } else {
            tell_sender("Please specify a player name");
        }
    } else {
        tell_sender("not enough permissions");
    }
    break;
```
2. Create the mutePlayer function:
```gsc
mutePlayer(player) {
    player.muted = true;
    player iPrintlnBold("You have been muted by an admin.");
}
```
3. Update listCommands and commandHelp:
```
// In listCommands
"!mute [player]",

// In commandHelp
case "!mute":
    helpText = "!mute [player] - Mutes the specified player.";
    break;
```
## Usage

To use the commands, simply type them in the in-game chat. Only players with XUIDs listed in the admins array will be able to execute admin commands.

### Example:

- To kick a player: !kick playerName
- To get help on a command: !help !kick
