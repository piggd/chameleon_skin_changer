/*
Chameleon - Skin Changer by piggd
Email: dayzpiggd@gmail.com
Website: http://dayzpiggd.enjin.com
Donations Accepted via paypal to danpigg@yahoo.com

Based on Skin_Trader by boyd
http://epochmod.com/forum/index.php?/topic/12378-release-skin-trader-06-buy-any-arma-skin/
*/

Mod Features:

This allows user to purchase skins from a menu.

You can change skins with a backpack.

Humanity is backed up and restored after change.

You can make all skins free.

Or some/none skins free, set a global price and define up to four additional special pricing for 4 sets of skins.

Persistent on logout and login.

Removes radio, gps, map, compass and NVG included in some skins but leaves original equipment if equipped before skin purchase (both at purchase and re-log).

Supports both Epoch (351 skins)  and Overpoch (175 skins) by setting a variable.

 

2014-09-01_00002_zpsd5bf513d.jpg

 

Known Issues:

Even though all skin class names are all unique some of the skins have identical appearances.

You have to change back into an epoch skin to use epoch clothes items again (1st one in male and female list - suggest you leave those free)

 

Testing:

All skins have been tested to insure that the inventory, weapon, and backpack slots work.

Special thanks to my user community for all their hard work in testing, especially iSaeko and Laura. 

I could not have done this without them!

 

Installation:

 

1.   Download the addon from my github by clicking on this link.   (Contains a vanilla epoch chernarus mission.pbo example file).

2.  On the lower left corner click on the button "Download Zip"

3   Create a directory called dayz_code and mission_pbo

4.  Take your mission.pbo file and extract it into the mission_pbo directory

5.  Unzip the zip file you download from my github and move the custom directory into your mission_pbo directory.

6.  Copy C:\Program Files (x86)\Steam\SteamApps\common\ARMA 2 Operation Arrowhead\@DayZ_Epoch\addons\dayz_code.pbo into this new directory (path may vary based on steam installation).

7.  Extract the dayz_code.pbo into the dayz_code directory you created.

8.  if you do not already have a fixes directory create one.

9.  If you do not already have a custom compile then follow these steps otherwise you can skip this step.

    copy dayz_code/init/compiles.sqf  mission_pbo/fixes/compules.sqf

10.  Copy dayz_code/compile/player_switchModel.sqf mission_pbo/fixes/player_switchModel.sqf

11.  Edit your init.sqf file and make the following modifications:

 

from:

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)

to:

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
// ------------------------------------------------------------------------ Chameleon - Skin Changer Start  ------------------------------------------------------------------------
call compile preprocessFileLineNumbers "custom\chameleon\chameleon_init.sqf";	
// ------------------------------------------------------------------------ Chameleon - Skin Changer End  ------------------------------------------------------------------------from:

progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";                //Compile regular functions

to :

progressLoadingScreen 0.4;
// ------------------------------------------------------------------------ Chameleon Skin Changer Start ------------------------------------------------------------------------
//call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";                //Compile regular functions
call compile preprocessFileLineNumbers "fixes\compiles.sqf";                //Compile regular functions
// ------------------------------------------------------------------------ Chameleon Skin Changer End ------------------------------------------------------------------------

from:

    //Lights
    //[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
 
};

to:

** NOTE - If you are using DZE Piggd Banking System this entry will already exist with a different comment.

    //Lights
    //[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf"; 
// ------------------------------------------------------------------------Chameleon Skin Changer Start ------------------------------------------------------------------------
// Activate Player Menu for Tools
    [] execVM "custom\playertools\activate_player_menu.sqf";
// ------------------------------------------------------------------------Chameleon Skin Changer Start ------------------------------------------------------------------------
    
};

12.  Edit your fixes\compiles.sqf file and make the following modifications:

 

from:

    player_switchModel =        compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_switchModel.sqf";

to:

// ------------------------------------------------------------------------ Chameleon Skin Changer Start ------------------------------------------------------------------------
//    player_switchModel =        compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_switchModel.sqf";
    player_switchModel =        compile preprocessFileLineNumbers "fixes\player_switchModel.sqf";
// ------------------------------------------------------------------------ Chameleon Skin Changer End ------------------------------------------------------------------------

13.  Edit your fixes\player_switchModel.sqf file and make the following modifications:

 

from

//private ["_weapons","_backpackWpn","_backpackMag","_currentWpn","_backpackWpnTypes","_backpackWpnQtys","_countr","_class","_position","_dir","_currentAnim","_tagSetting","_playerUID","_countMags","_magazines","_primweapon","_secweapon","_newBackpackType","_muzzles","_oldUnit","_group","_newUnit","_playerObjName","_wpnType","_ismelee"];

to:

// ------------------------------------------------------------------------ Chameleon Skin Changer Start ------------------------------------------------------------------------
//private ["_weapons","_backpackWpn","_backpackMag","_currentWpn","_backpackWpnTypes","_backpackWpnQtys","_countr","_class","_position","_dir","_currentAnim","_tagSetting","_playerUID","_countMags","_magazines","_primweapon","_secweapon","_newBackpackType","_muzzles","_oldUnit","_group","_newUnit","_playerObjName","_wpnType","_ismelee"];
private ["_weapons","_backpackWpn","_backpackMag","_currentWpn","_backpackWpnTypes","_backpackWpnQtys","_countr","_class","_position","_dir","_currentAnim","_tagSetting","_playerUID","_countMags","_magazines","_primweapon","_secweapon","_newBackpackType","_muzzles","_oldUnit","_group","_newUnit","_playerObjName","_wpnType","_ismelee","_hasCompass","_hasRadio","_hasGPS","_hasWatch","_hasMap","_hasNVG"];
// ------------------------------------------------------------------------ Chameleon Skin Changer End ------------------------------------------------------------------------

from:

//BackUp Player Object
_oldUnit = player;

to:

//BackUp Player Object
_oldUnit = player;

// ------------------------------------------------------------------------ Chameleon Duplicate Item Fix Start ------------------------------------------------------------------------
_hasCompass = false;
_hasRadio = false;
_hasGPS = false;
_hasWatch = false;
_hasMap = false;
_hasNVG = false;
if (player hasWeapon "ItemCompass") then {_hasCompass = true;};
if (player hasWeapon "ItemRadio") then {_hasRadio = true;};
if (player hasWeapon "ItemGPS") then {_hasGPS = true;};
if (player hasWeapon "ItemWatch") then {_hasWatch = true;};
if (player hasWeapon "ItemMap") then {_hasMap = true;};                
if (player hasWeapon "NVGoggles") then {_hasNVG = true;};                
// ------------------------------------------------------------------------ Chameleon Duplicate Item Fix End ------------------------------------------------------------------------

from:

if (_ismelee == "true") then {
    call dayz_meleeMagazineCheck;
};

to:

if (_ismelee == "true") then {
    call dayz_meleeMagazineCheck;
};
// ------------------------------------------------------------------------ Chameleon Duplicate Item Fix Start ------------------------------------------------------------------------
if (!_hasCompass) then {_newUnit removeWeapon "ItemCompass";};
if (!_hasRadio) then {_newUnit removeWeapon "ItemRadio";};
if (!_hasGPS) then {_newUnit removeWeapon "ItemGPS";};    
if (!_hasWatch) then {_newUnit removeWeapon "ItemWatch";};
if (!_hasMap) then {_newUnit removeWeapon "ItemMap";};
if (!_hasNVG) then {_newUnit removeWeapon "NVGoggles";};
// ------------------------------------------------------------------------ Chameleon Duplicate Item Fix End ------------------------------------------------------------------------

14.  Edit description.ext add the following lines to the end of the file.

//------------------------------------------------------------------------ Chameleon - Skin Changer Start ----------------------------------------------------------------
#include "custom\chameleon\dialog\common.hpp"
#include "custom\chameleon\dialog\SkinGui.hpp"
//------------------------------------------------------------------------ Chameleon - Skin Changer End-------------------------------------------------------------------

**NOTE if you already have texxBoxx installed you only need one common.hpp , comment out the second one by placing a // in front of it.

 

Optional Additional Configuration:

** Enable Overpoch

 

1. Edit custom/chameleon/ chameleon_init.sqf and change the following:

** NOTE: This variable can be placed in the init.sqf or variables.sqf if you prefer.

from:

// *************************************************************************************************************************
// Uncomment the line below to activate Overpoch Skins or add this variable to your init.sqf file. Above your chameleon_init.sql call.
// CSC_WORLD = "overpoch";
// *************************************************************************************************************************

to:

// *************************************************************************************************************************
// Uncomment the line below to activate Overpoch Skins or add this variable to your init.sqf file. Above your chameleon_init.sql call.
 CSC_WORLD = "overpoch";
// *************************************************************************************************************************

** Change Pricing

1. Edit custom/chameleon/ chameleon_init.sqf and change the following:

//CSCFreeSkins = true;
CSCFreeSkins = false;
CSCFreePrice = ["ItemGoldBar",0];

// Regular Skin Price
CSCGlobalPrice = ["ItemGoldBar",4];  // Do not set to 0 unless you have CSCFreeSkins = true;
//CSCGlobalPrice = ["ItemGoldBar10oz",2];  // Do not set to 0 unless you have CSCFreeSkins = true;
//CSCGlobalPrice = ["ItemBriefcase100oz",2];  // Do not set to 0 unless you have CSCFreeSkins = true;

// Special Skin Prices
CSCSpecialPrice1 = ["ItemGoldBar",2]; // Do not set to 0
CSCSpecialPrice2 = ["ItemGoldBar10oz",1]; // Do not set to 0
CSCSpecialPrice3 = ["ItemGoldBar",6]; // Do not set to 0
CSCSpecialPrice4 = ["ItemGoldBar",7]; // Do not set to 0

Change the CSCFreeSkins  to true to make all skins free or adjust individual variables for the prices you want and then add or remove skins from the list array to match.

 

**  DZE Banking System 

If you are using DZE Banking System and have replaced custom/playertools/player_tools_main.sqf you will need to uncomment the following lines.

 

from:

playermenustart = [
    ["",true],
    ["Chameleon Male Skins Menu",[],"", -5,[["expression",format[_EXECscript1,_pathtochameleon + "male_dialog.sqf"]]],"1","1"],
    ["Chameleon Female Skins Menu",[],"", -5,[["expression",format[_EXECscript1,_pathtochameleon + "female_dialog.sqf"]]],"1","1"],
//    ["DZE Piggd Banking System >>", [], "#USER:bankmenu", -5, [["expression", ""]], "1", "1"],            
//    ["Weather/Time Menu (Local Only) >>", [], "#USER:WTMenu", -5, [["expression", ""]], "1", "1"],            
    ["", [], "", -5, [["expression", ""]], "1", "0"],
    ["Main Menu", [20], "#USER:playermenustart", -5, [["expression", ""]], "1", "1"]        
];

to:

playermenustart = [
    ["",true],
    ["Chameleon Male Skins Menu",[],"", -5,[["expression",format[_EXECscript1,_pathtochameleon + "male_dialog.sqf"]]],"1","1"],
    ["Chameleon Female Skins Menu",[],"", -5,[["expression",format[_EXECscript1,_pathtochameleon + "female_dialog.sqf"]]],"1","1"],
    ["DZE Piggd Banking System >>", [], "#USER:bankmenu", -5, [["expression", ""]], "1", "1"],            
//    ["Weather/Time Menu (Local Only) >>", [], "#USER:WTMenu", -5, [["expression", ""]], "1", "1"],            
    ["", [], "", -5, [["expression", ""]], "1", "0"],
    ["Main Menu", [20], "#USER:playermenustart", -5, [["expression", ""]], "1", "1"]        
];

15.  Repack your mission pbo and upload to your sever.

 

Original Framework and Dialog based on from Skin_Trader by boyd

 

Email: dayzpiggd@gmail.com
Website: Piggd Dayz Gaming
Donate to piggd
 