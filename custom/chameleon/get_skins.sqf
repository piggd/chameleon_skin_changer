/*
Chameleon - Skin Changer by piggd
Email: dayzpiggd@gmail.com
Website: http://dayzpiggd.enjin.com
Donations Accepted via paypal to danpigg@yahoo.com

Based on Skin_Trader by boyd
http://epochmod.com/forum/index.php?/topic/12378-release-skin-trader-06-buy-any-arma-skin/
*/
if(not local player) exitWith{};
#include "dialog\definitions.sqf"
disableSerialization;
private ["_cnt","_total_currency","_currency","_price","_canAfford","_trade_total","_total_currency","_trade_total","_return_change","_trade_total","_trade_total","_skin","_unitBag","_bagType","_bagMagazines","_bagWeapons","_array1","_array2","_backup_humanity","_hasGPS","_hasCompass","_hasRadio","_hasWatch","_hasMap","_hasNVG","_sel"];

if(DZE_ActionInProgress) exitWith { cutText ["Buy Skin already in progress!", "PLAIN DOWN"]; };
DZE_ActionInProgress = true;

_display = findDisplay SKINS_DIALOG;
_listbox = _display displayCtrl SKINS_UNITLIST;
_sel = lbCurSel _listbox; if(_sel < 0) exitWith{};

_unittype = CHAMELEON_CLOTHING_LIST select _sel;
_typename = lbtext [SKINS_UNITLIST,_sel];

_hasGPS = false;
_hasCompass = false;
_hasRadio = false;
_hasWatch = false;
_hasMap = false;
_hasNVG = false;
_total_price = CSCFreePrice;
_currency = _total_price select 0;
_price =  _total_price select 1;

_canAfford = true;
if (!CSCFreeSkins && !(_unittype in CSCFreeSkinList)) then {
	_canAfford = false;
	_total_price = CSCGlobalPrice;
	if (_unittype in CSCSpecialSkinList1) then {_total_price = CSCSpecialPrice1};
	if (_unittype in CSCSpecialSkinList2) then {_total_price = CSCSpecialPrice2};
	if (_unittype in CSCSpecialSkinList3) then {_total_price = CSCSpecialPrice3};
	if (_unittype in CSCSpecialSkinList4) then {_total_price = CSCSpecialPrice4};
	_currency = _total_price select 0;
	_price =  _total_price select 1;
	_trade_total = [[_currency,_price]] call epoch_itemCost;
	_total_currency = call epoch_totalCurrency;
	_return_change = _total_currency - _trade_total; 
	if (_return_change >= 0) then {
		_canAfford = [[[_currency,_price]],0] call epoch_returnChange;
	};
};
if (_canAfford) then {
	_backup_humanity = player getVariable["humanity",0];
	systemChat (format ["You paid %2 %1.",_currency,_price]);
	_skin = _this select 0;
	_unitBag = unitBackpack player;
	_bagType = typeOf _unitBag;
	_bagWeapons = getWeaponCargo _unitBag;
	_bagMagazines = getMagazineCargo _unitBag;
	removeBackpack (vehicle player);
	if (player hasWeapon "ItemCompass") then {_hasCompass = true;};
	if (player hasWeapon "ItemRadio") then {_hasRadio = true;};
	if (player hasWeapon "ItemGPS") then {_hasGPS = true;};
	if (player hasWeapon "ItemWatch") then {_hasWatch = true;};
	if (player hasWeapon "ItemMap") then {_hasMap = true;};				
	if (player hasWeapon "NVGoggles") then {_hasNVG = true;};				
	player playActionNow "Medic";
	sleep 7;
	CloseDialog 0;
	sleep 1;
	[dayz_playerUID,dayz_characterID,_unittype] spawn player_humanityMorph;
	sleep 0.2;
	if (!_hasCompass) then {player removeWeapon "ItemCompass";};
	if (!_hasRadio) then {player removeWeapon "ItemRadio";};
	if (!_hasGPS) then {player removeWeapon "ItemGPS";};	
	if (!_hasWatch) then {player removeWeapon "ItemWatch";};
	if (!_hasMap) then {player removeWeapon "ItemMap";};
	if (!_hasNVG) then {player removeWeapon "NVGoggles";};
	vehicle player switchCamera 'EXTERNAL';
	sleep 2;
	if (!_hasCompass) then {player removeWeapon "ItemCompass";};
	if (!_hasRadio) then {player removeWeapon "ItemRadio";};
	if (!_hasGPS) then {player removeWeapon "ItemGPS";};	
	if (!_hasWatch) then {player removeWeapon "ItemWatch";};
	if (!_hasMap) then {player removeWeapon "ItemMap";};
	if (!_hasNVG) then {player removeWeapon "NVGoggles";};
	if(_bagType == "CZ_VestPouch_EP1" || _bagType == "DZ_LargeGunBag_EP1" || _bagType == "DZ_ALICE_Pack_EP1" || _bagType == "DZ_Assault_Pack_EP1" || _bagType == "DZ_Backpack_EP1" || _bagType == "DZ_British_ACU" || _bagType == "DZ_CivilBackpack_EP1" || _bagType == "DZ_Czech_Vest_Pouch" || _bagType == "DZ_Patrol_Pack_EP1" || _bagType == "DZ_TK_Assault_Pack_EP1" || _bagType == "DZ_GunBag_EP1" || _bagType == "DZ_CompactPack_EP1" || _bagType == "DZ_TerminalPack_EP1") then	{
		(vehicle player) addBackpack _bagType;
		sleep 0.1;
		_array1 = _bagWeapons select 0;
		_array2 = _bagWeapons select 1;
		_cnt = 0;
		{
			(unitBackpack player) addWeaponCargo [(_array1 select _cnt),(_array2 select _cnt)];
			_cnt = _cnt + 1;
		}forEach _array1;
		_array1 = _bagMagazines select 0;
		_array2 = _bagMagazines select 1;
		_cnt = 0;
		{
			(unitBackpack player) addMagazineCargo [(_array1 select _cnt),(_array2 select _cnt)];
			_cnt = _cnt + 1;
		}forEach _array1;
	};
	player setVariable["humanity",_backup_humanity,true];
}else{
	systemChat (format ["Insufficient Funds! Need %2 %1.",_currency,_price]);
};
DZE_ActionInProgress = false;
