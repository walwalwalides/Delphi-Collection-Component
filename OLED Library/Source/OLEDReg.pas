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

type
  // default ComMixer Library component editor
  TOLEDLibraryEditor = class(TComponentEditor)
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
{$IFDEF DELPHI_5}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
{$ENDIF}
  end;





procedure Register;

implementation


uses
  UOLEDPanel,UOLEDControls, OLEDAbout,
  Forms, Dialogs, Graphics;

(*****************************************
 * TMixerLibraryEditor editor              *
 *****************************************)

procedure TOLEDLibraryEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowAbout;
end;

function TOLEDLibraryEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Mixer Library version ' + OLEDLibraryVersion;
end;

function TOLEDLibraryEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF DELPHI_5}
procedure TOLEDLibraryEditor.PrepareItem(Index: Integer;
  const AItem: TMenuItem);
begin
  if Index = 0 then
    AItem.Bitmap.LoadFromResourceName(HInstance, 'OLEDLIB');
end;
{$ENDIF}




procedure Register;
begin
  RegisterComponents('OLED Library', [TOLEDPanel,TOLEDPotentiometer]);
  RegisterComponentEditor(TOLEDPanel, TOLEDLibraryEditor);
  RegisterComponentEditor(TOLEDPotentiometer, TOLEDLibraryEditor);
end;

end.
