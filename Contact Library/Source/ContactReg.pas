{ ============================================
  Software Name : 	Contact Library
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit ContactReg;
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
  TContactLibraryEditor = class(TComponentEditor)
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
  MailContactLabel, ContactAbout,uCalendarPicture,uContactArrayButton,
  Forms, Dialogs, Graphics;

(*****************************************
 * TMixerLibraryEditor editor              *
 *****************************************)

procedure TContactLibraryEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowAbout;
end;

function TContactLibraryEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Contact Library version ' + ContactLibraryVersion;
end;

function TContactLibraryEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF DELPHI_5}
procedure TContactLibraryEditor.PrepareItem(Index: Integer;
  const AItem: TMenuItem);
begin
  if Index = 0 then
    AItem.Bitmap.LoadFromResourceName(HInstance, 'ContactLIB');
end;
{$ENDIF}




procedure Register;
begin
  RegisterComponents('Contact Library', [TMailContactLabel,TCalendarpicture,TContactArrayBtn]);
  RegisterComponentEditor(TMailContactLabel, TContactLibraryEditor);
  RegisterComponentEditor(TCalendarpicture, TContactLibraryEditor);
   RegisterComponentEditor(TContactArrayBtn, TContactLibraryEditor);

end;

end.
