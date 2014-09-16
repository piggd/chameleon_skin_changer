/*
Chameleon - Skin Changer by piggd
Email: dayzpiggd@gmail.com
Website: http://dayzpiggd.enjin.com
Donations Accepted via paypal to danpigg@yahoo.com

Based on Skin_Trader by boyd
http://epochmod.com/forum/index.php?/topic/12378-release-skin-trader-06-buy-any-arma-skin/
*/
#include "dialog\definitions.sqf"
disableSerialization;
//Still working on it
//systemchat format ["<System>: You can preview a skin by DOUBLE clicking on it, you will have 10 seconds before it changes back."];
_total_price = CSCGlobalPrice;
_currency = _total_price select 0;
_price =  _total_price select 1;

_display = findDisplay SKINS_DIALOG;
_unitlist = _display displayCtrl SKINS_UNITLIST;
_queuelist = _display displayCtrl SKINS_QUEUE;

_queuelist ctrlSetText format["Cost %2 %1",_currency,_price];

_weaponstring = "";
{
	_displname = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
	_picture = getText (configFile >> "CfgVehicles" >> _x >> "portrait");
	_weaponstring = format["%1 (%2)",_displname,_x,_picture];
	_unitlist lbAdd _weaponstring;
} foreach CHAMELEON_CLOTHING_LIST;