{ ============================================
  Software Name : 	OLED Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit OLEDReg;
 {$I OLED.inc}
interface

uses
{$IFDEF DELPHI_6_OR_HIGHER}
  DesignIntf, DesignEditors, DesignMenus, PropertyCategories,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Classes, Menus;


procedure Register;

implementation


uses
  UOLEDPanel,UOLEDControls, OLEDAbout,
  Forms, Dialogs, Graphics;


procedure Register;
begin
  RegisterComponents('OLED Library', [TOLEDPanel,TOLEDPotentiometer]);
//  RegisterComponentEditor( T,T );
//  RegisterPropertiesInCategory('OLED Library')

end;

end.
