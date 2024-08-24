init() {
    level thread command_listener();
    level.systemName = "[^:H2M-CMD^7] ";
    level.adminList = ["YOUR XUID"];
}
isInArray(array, value)
{
    for (i = 0; i < array.size; i++)
    {
        if (array[i] == value)
        {
            return true;
        }
    }
    return false;
}

tell_sender(var_1){
    executeCommand("tellraw t "+level.systemName+ var_1);
}
announce(txt){
    executeCommand("sayraw "+level.systemName + txt);
}

listCommands(player) {
    commands = [
        "!test",
        "!test-admin",
        "!kick [player]",
        "!ban [player]",
        "!warn [player]",
        "!tp [player1] [player2]",
        "!kill [player]",
        "!switch [player]",
        "!exec [command]",
        "!help [cmd]"
    ];

    commandList = "Available Commands: ";
    for(i = 0; i < commands.size; i++) {
        if((commandList.size + commands[i].size + 2) > 100) {  // Check if adding another command would exceed the limit
            tell_sender(commandList);
            commandList = "";  // Reset for the next batch
        }
        commandList += commands[i] + ", ";
    }
    if(commandList != "") {  // Send any remaining commands
        tell_sender(commandList);
    }
}

commandHelp(player, cmd) {
    helpText = "";

    switch(cmd) {
        case "!test":
            helpText = "!test - Test command, returns 'Test OK!'.";
            break;
        case "!test-admin":
            helpText = "!test-admin - Admin-only command, returns 'Test Admin OK!' if the user is an admin.";
            break;
        case "!kick":
            helpText = "!kick [player] - Kicks the specified player from the server.";
            break;
        case "!ban":
            helpText = "!ban [player] - Bans the specified player from the server.";
            break;
        case "!warn":
            helpText = "!warn [player] - Warns the specified player.";
            break;
        case "!tp":
            helpText = "!tp [player1] [player2] - Teleports player1 to player2.";
            break;
        case "!kill":
            helpText = "!kill [player] - Kills the specified player.";
            break;
        case "!switch":
            helpText = "!switch [player] - Switches the specified player's team.";
            break;
        case "!exec":
            helpText = "!exec [command] - Executes a server command.";
            break;
        case "!help":
            helpText = "!help [cmd] - Shows help for the specified command.";
            break;
        default:
            helpText = "No help available for " + cmd;
            break;
    }
    
    tell_sender(helpText);
}

command_listener(){
    admins = ["67f8de6e1e9a11a8"];
    self endon("disconnect");
    
    while (true){
        self waittill("say", player, message);
        if (getsubstr(message, 0, 1) == "!"){

            args = strTok(message, " ");  // Split message into arguments
            
            switch(args[0]){
                case "!test":
                    tell_sender("Test OK!");
                    break;
                    
                case "!test-admin":
                    if(isInArray(admins, player.xuid)){
                        tell_sender("Test Admin OK!");
                    } else {
                        tell_sender("not enough permissions");
                    }
                    break;
                    
                case "!kick":
                    if(isInArray(admins, player.xuid)){
                        if(args.size >= 2){
                            targetPlayer = getPlayerByName(args[1]);
                            if(targetPlayer != undefined){
                                kickPlayer(targetPlayer);
                                announce("Kicked player " + targetPlayer.name);

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
                    
                case "!ban":
                    if(isInArray(admins, player.xuid)){
                        if(args.size >= 2){
                            targetPlayer = getPlayerByName(args[1]);
                            if(targetPlayer != undefined){
                                banPlayer(targetPlayer);
                                announce("Banned player " + targetPlayer.name);
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
                    
                case "!warn":
                    if(isInArray(admins, player.xuid)){
                        if(args.size >= 2){
                            targetPlayer = getPlayerByName(args[1]);
                            if(targetPlayer != undefined){
                                warnPlayer(targetPlayer);
                                announce("Warned player " + targetPlayer.name);
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
                    
                case "!tp":
                    if(isInArray(admins, player.xuid)){
                        if(args.size >= 3){
                            targetPlayer1 = getPlayerByName(args[1]);
                            targetPlayer2 = getPlayerByName(args[2]);
                            if(targetPlayer1 != undefined && targetPlayer2 != undefined){
                                teleportPlayer(targetPlayer1, targetPlayer2);
                                tell_sender("Teleported " + targetPlayer1.name + " to " + targetPlayer2.name);
                            } else {
                                tell_sender("One or both players not found");
                            }
                        } else {
                            tell_sender("Please specify two player names");
                        }
                    } else {
                        tell_sender("not enough permissions");
                    }
                    break;
                    
                case "!kill":
                    if(isInArray(admins, player.xuid)){
                        if(args.size >= 2){
                            targetPlayer = getPlayerByName(args[1]);
                            if(targetPlayer != undefined){
                                killPlayer(targetPlayer);
                                tell_sender("Killed player " + targetPlayer.name);
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
                    
                case "!switch":
                    if(isInArray(admins, player.xuid)){
                        if(args.size >= 2){
                            targetPlayer = getPlayerByName(args[1]);
                            if(targetPlayer != undefined){
                                switchTeam(targetPlayer);
                                announce("Switched team of player " + targetPlayer.name);
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

                case "!exec":
                   if(isInArray(admins, player.xuid)){
                        if(args.size >= 2){
                            command = "";
                            for(i = 1; i < args.size; i++){
                                command += args[i];
                                if (i < args.size - 1) {
                                    command += " ";  // Add space between arguments
                                }
                            }
                            executeCommand(command);
                            tell_sender("Executed command: " + command);
                        } else {
                            tell_sender("Please specify a command to execute");
                        }
                    } else {
                        tell_sender("not enough permissions");
                    }
                    break;

                case "!commands":
                    listCommands(player);
                    break;

                case "!help":
                    if(args.size >= 2) {
                        commandHelp(player, args[1]);
                    } else {
                        tell_sender("Please specify a command for help.");
                    }
                    break;
                    
                default:
                    tell_sender("Unknown Command");
                    break;
            }
        }
    }
}

getPlayerByName(name) {
    foreach (player in level.players) {
        if (player.name == name) {
            return player;
        }
    }
    return undefined;
}

kickPlayer(player) {
    kick(player getentitynumber(), "Kicked by an admin.");
}

banPlayer(player) {
    // Add player to ban list (implement your ban logic here)
    kick(player getentitynumber(), "Banned by an admin.");
}

warnPlayer(player) {
    player iPrintlnBold("^1Warning: ^7You have been warned by an admin.");
}

teleportPlayer(player1, player2) {
    player1 setOrigin(player2.origin);
}

killPlayer(player) {
    player suicide();
}

switchTeam(player) {
    player.team = player.team == "axis" ? "allies" : "axis";
    player suicide();
}
