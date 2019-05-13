{ ============================================
  Software Name : 	Rating Libary
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit FMX.Rating.Register;
 {$I Mixer.inc}
interface

uses
{$IFDEF DELPHI_6_OR_HIGHER}
  DesignIntf, DesignEditors, DesignMenus, PropertyCategories,
{$ELSE}
  DsgnIntf,
{$ENDIF}
  Classes, FMX.Menus;

type
  // Default Rating Library component editor
  TRatingLibraryEditor = class(TComponentEditor)
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
  FMX.shHeart.Rating, RatingAbout,
  Forms, Dialogs, Graphics;

(*****************************************
 * TRatingLibraryEditor editor              *
 *****************************************)

procedure TRatingLibraryEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    ShowAbout;
end;

function TRatingLibraryEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Rating Library version ' + RatingLibraryVersion;
end;

function TRatingLibraryEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF DELPHI_5}
procedure TRatingLibraryEditor.PrepareItem(Index: Integer;
  const AItem: TMenuItem);
begin
  if Index = 0 then
    AItem.Bitmap.LoadFromResourceName(HInstance, 'RatingLIB');
end;
{$ENDIF}





procedure Register;
begin
  RegisterComponents('Rating Libary', [TRatingshHeart]);
  RegisterComponentEditor(TRatingshHeart, TRatingLibraryEditor);
end;

end.
