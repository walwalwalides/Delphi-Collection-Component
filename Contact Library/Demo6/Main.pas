unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, MIDASLIb, uReaderContact;

type
  TfrmMain = class(TForm)
    lbledtPath: TLabeledEdit;
    btnExecute: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    btnLoad: TButton;
    OpDlg: TOpenDialog;
    ContactReader1: TContactReader;
    procedure btnExecuteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure lbledtPathChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnLoadClick(Sender: TObject);
begin
  if OpDlg.Execute then
  begin
    lbledtPath.Text := OpDlg.FileName;
  end

end;

procedure TfrmMain.btnExecuteClick(Sender: TObject);
var
  i: Integer;
begin

  try
    ContactReader1.ContactFile := ExpandFileName(lbledtPath.Text);
    if not(ContactReader1.Import) then
      raise Exception.Create(Format('Import file %s with errors!', [ContactReader1.ContactFile]));

    for i := 0 to ContactReader1.Count - 1 do
      ClientDataSet1.InsertRecord([i, ContactReader1.Get(i).ID, ContactReader1.Get(i).JobType, ContactReader1.Get(i).Birthday, ContactReader1.Get(i).Telefon,
        ContactReader1.Get(i).Age, ContactReader1.Get(i).Description]);
  finally
    ContactReader1.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
const
  STR_SIZE = 20;
begin
  OpDlg.Filter := 'Contact library files (*.clib)|*.CLIB';

  ClientDataSet1.FieldDefs.Add('INDEX', ftString, STR_SIZE);
  ClientDataSet1.FieldDefs.Add('ID', ftString, STR_SIZE);
  ClientDataSet1.FieldDefs.Add('JobType', ftString, STR_SIZE);
  ClientDataSet1.FieldDefs.Add('BIRTHDAY', ftDate);
  ClientDataSet1.FieldDefs.Add('TELEFON', ftString, STR_SIZE);
  ClientDataSet1.FieldDefs.Add('AGE', ftString, STR_SIZE);
  ClientDataSet1.FieldDefs.Add('DESCRIPTION', ftString, STR_SIZE);
  ClientDataSet1.CreateDataSet;
end;

procedure TfrmMain.lbledtPathChange(Sender: TObject);
begin
if (lbledtPath.Text<>'') then
btnExecute.Enabled:=True else btnExecute.Enabled:=False
end;

end.
