{ ============================================
  Software Name : 	Mixer Libary
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit MixerReg;
 {$I Mixer.inc}
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
  TComMixerLibraryEditor = class(TComponentEditor)
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
{$IFDEF DELPHI_5}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
{$ENDIF}
  end;

  // TComMixer component editor
  TComMixerEditor = class(TComMixerLibraryEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
{$IFDEF DELPHI_5}
    procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
{$ENDIF}
    procedure Edit; override;
  end;




  // TComMixer.Port property editor
  TComMixerPortProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;



procedure Register;

implementation


uses
  Mixer, MixerCtl, SetupMixer, MixerAbout,
  Forms, Dialogs, Graphics;

(*****************************************
 * TMixerLibraryEditor editor              *
 *****************************************)

procedure TComMixerLibraryEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowAbout;
end;

function TComMixerLibraryEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Mixer Library version ' + CPortLibraryVersion;
end;

function TComMixerLibraryEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF DELPHI_5}
procedure TComMixerLibraryEditor.PrepareItem(Index: Integer;
  const AItem: TMenuItem);
begin
  if Index = 0 then
    AItem.Bitmap.LoadFromResourceName(HInstance, 'MixerLIB');
end;
{$ENDIF}

(*****************************************
 * TComMixerEditor editor                 *
 *****************************************)

procedure TComMixerEditor.Edit;
begin
  (Component as TCustomComMixer).ShowSetupDialog;
  Designer.Modified;
end;

procedure TComMixerEditor.ExecuteVerb(Index: Integer);
begin
  inherited ExecuteVerb(Index);
  if Index = 1 then
    Edit;
end;

{$IFDEF DELPHI_5}
procedure TComMixerEditor.PrepareItem(Index: Integer;
  const AItem: TMenuItem);
begin
  if Index = 1 then
    AItem.Default := True;
  inherited PrepareItem(Index, AItem);
end;
{$ENDIF}

function TComMixerEditor.GetVerb(Index: Integer): string;
begin
  Result := inherited GetVerb(Index);
  if Index = 1 then
    Result := 'Port settings';
end;

function TComMixerEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;






(*****************************************
 * TComMixerPortProperty editor               *
 *****************************************)

function TComMixerPortProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paSortList, paValueList];
end;

procedure TComMixerPortProperty.GetValues(Proc: TGetStrProc);
var
  List: TStringList;
  I: Integer;
begin
  List := TStringList.Create;
  EnumComPorts(List);
  for I := 0 to List.Count - 1 do
    Proc(List[I]);
  List.Free;
end;




procedure Register;
begin
  RegisterComponents('Mixer Libary', [TComMixer, TComComboMixer, TComLedmixer,TComTimerMixer]);
  RegisterComponentEditor( TComMixer, TComMixerEditor);
  RegisterComponentEditor(TComLedmixer, TComMixerLibraryEditor);
  RegisterComponentEditor(TComTimermixer, TComMixerLibraryEditor);
  RegisterComponentEditor(TComComboMixer, TComMixerLibraryEditor);
  RegisterPropertyEditor(TypeInfo(TMixer), TCustomComMixer, 'Port', TComMixerPortProperty);


  RegisterPropertiesInCategory('MIXER COM',TComMixer, ['BaudRate', 'StopBits',
    'DataBits', 'Port', 'EventChar', 'Connected', 'DiscardNull', 'Events',
    'FlowControl', 'Timeouts', 'Parity', 'Buffer', 'OnAfterOpen', 'OnBeforeOpen',
    'OnAfterClose', 'OnBeforeClose', 'OnRxChar', 'OnTxEmpty', 'OnCTSChange',
    'OnRLSDChange', 'OnDSRChange', 'OnError', 'OnRing', 'OnRxBuf', 'OnRxFlag',
    'OnRx80Full', 'OnBreak']);

    RegisterPropertiesInCategory('MIXER LED',TComLedmixer, ['StrSend', 'MixGreen',
    'MixRed', 'MixBlue', 'ComPort', 'OnSelect', 'Visible', 'Enabled']);

end;

end.
