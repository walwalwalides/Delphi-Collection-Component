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
 {$I Mixer.inc}
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
//  RegisterComponentEditor( TComMixer, TComMixerEditor);
//  RegisterComponentEditor(TComLedmixer, TComMixerLibraryEditor);
//  RegisterComponentEditor(TComTimermixer, TComMixerLibraryEditor);
//  RegisterComponentEditor(TComComboMixer, TComMixerLibraryEditor);
//  RegisterPropertyEditor(TypeInfo(TMixer), TCustomComMixer, 'Port', TComMixerPortProperty);
//
//
//  RegisterPropertiesInCategory('MIXER COM',TComMixer, ['BaudRate', 'StopBits',
//    'DataBits', 'Port', 'EventChar', 'Connected', 'DiscardNull', 'Events',
//    'FlowControl', 'Timeouts', 'Parity', 'Buffer', 'OnAfterOpen', 'OnBeforeOpen',
//    'OnAfterClose', 'OnBeforeClose', 'OnRxChar', 'OnTxEmpty', 'OnCTSChange',
//    'OnRLSDChange', 'OnDSRChange', 'OnError', 'OnRing', 'OnRxBuf', 'OnRxFlag',
//    'OnRx80Full', 'OnBreak']);
//
//    RegisterPropertiesInCategory('MIXER LED',TComLedmixer, ['StrSend', 'MixGreen',
//    'MixRed', 'MixBlue', 'ComPort', 'OnSelect', 'Visible', 'Enabled']);

end;

end.
