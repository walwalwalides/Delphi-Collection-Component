{ ============================================
  Software Name : 	TContactReader
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2019                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit uReaderContact;

interface

uses classes, SysUtils;

type
  TContactItem = class
    JobType : String;
    Birthday : TDateTime;
    Age : String;
    ID : string;
    Telefon : string;
    Description : string;
  end;

  TContactReader = class(TComponent)
  public
    ContactID : String;
    BranchID : string;
    AccountID : string;
    AccountType : string;
    DateStart : string;
    DateEnd : string;
    FinalBalance : String;
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    function Import: boolean;
    function Get(iIndex: integer): TContactItem;
    function Count: integer;
  private
    FContactFile : string;
    FListItems : TList;
    procedure Clear;
    procedure Delete( iIndex: integer );
    function Add: TContactItem;
    function InfLine ( sLine : string ): string;
    function FindString ( sSubString, sString : string ): boolean;
  protected
  published
    property ContactFile: string read FContactFile write FContactFile;
  end;



implementation

constructor TContactReader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FListItems := TList.Create;
end;

destructor TContactReader.Destroy;
begin
  FListItems.Free;
  inherited Destroy;
end;

procedure TContactReader.Delete( iIndex: integer );
begin
  TContactItem(FListItems.Items[iIndex]).Free;
  FListItems.Delete( iIndex );
end;

procedure TContactReader.Clear;
begin
  while FListItems.Count > 0 do
    Delete(0);
  FListItems.Clear;
end;

function TContactReader.Count: integer;
begin
  Result := FListItems.Count;
end;

function TContactReader.Get(iIndex: integer): TContactItem;
begin
  Result := TContactItem(FListItems.Items[iIndex]);
end;

function TContactReader.Import: boolean;
var
  oFile : TStringList;
  i : integer;
  bCLIB : boolean;
  oItem : TContactItem;
  sLine : string;
begin
  Clear;
  DateStart:= ''; 
  DateEnd:= '';
  bCLIB := false;
  if not FileExists(FContactFile) then
    raise Exception.Create('File not found!');
  oFile := TStringList.Create;
  oFile.LoadFromFile(FContactFile);
  i := 0;

  while i < oFile.Count do
  begin
    sLine := oFile.Strings[i];
    if  FindString('<CLIB>', sLine) then
      bCLIB := true;

    if bCLIB then
    begin


      if FindString('<ContactID>', sLine) then ContactID := InfLine(sLine);

      if FindString('<BRANCHID>', sLine) then BranchID := InfLine(sLine);


      if FindString('<ACCTID>', sLine) then AccountID := InfLine(sLine);


      if FindString('<ACCTTYPE>', sLine) then AccountType := InfLine(sLine);


      if FindString('<DTSTART>',sLine) then
      begin
            if Trim(sLine) <> '' then
                DateStart:= DateToStr(EncodeDate(StrToIntDef(copy(InfLine(sLine),1,4), 0),
                                                          StrToIntDef(copy(InfLine(sLine),5,2), 0),
                                                          StrToIntDef(copy(InfLine(sLine),7,2), 0)));
      end;
      if FindString('<DTEND>',sLine) then
      begin
            if Trim(sLine) <> '' then
                DateEnd:=  DateToStr(EncodeDate(StrToIntDef(copy(InfLine(sLine),1,4), 0),
                                                                StrToIntDef(copy(InfLine(sLine),5,2), 0),
                                                                StrToIntDef(copy(InfLine(sLine),7,2), 0)));
      end;

      if FindString('<FOREND>', sLine)  then
         FinalBalance := InfLine(sLine);


      if FindString('<ITEMS>', sLine) then
      begin
        oItem := Add;
        while not FindString('</ITEMS>', sLine) do
        begin
          Inc(i);
          sLine := oFile.Strings[i];

          if FindString('<JobType>', sLine) then
          begin
             if (InfLine(sLine) = '0') or (InfLine(sLine) = 'CREDIT') then
                oItem.JobType := 'Engineering'
             else
             if (InfLine(sLine) = '1') or (InfLine(sLine) = 'DEBIT') then
                oItem.JobType := 'Project Manager'
             else oItem.JobType := 'OTHER';
          end;

          if FindString('<BIRTHDAY>', sLine) then
             oItem.Birthday := EncodeDate(StrToIntDef(copy(InfLine(sLine),1,4), 0),
                                         StrToIntDef(copy(InfLine(sLine),5,2), 0),
                                         StrToIntDef(copy(InfLine(sLine),7,2), 0));

          if FindString('<ID>', sLine) then
             oItem.ID := InfLine(sLine);

          if FindString('<TELEFON>', sLine)  then
             oItem.Telefon := InfLine(sLine);

          if FindString('<DESCRIPTION>', sLine) then
             oItem.Description := InfLine(sLine);

          if FindString('<AGE>', sLine) then
             oItem.Age := InfLine(sLine);
        end;
      end;

    end;
    Inc(i);
  end;
  Result := bCLIB;
end;

function TContactReader.InfLine ( sLine : string ): string;
var
   iTemp : integer;
begin
  Result := '';
  sLine := Trim(sLine);
  if FindString('>', sLine) then
  begin
    sLine := Trim(sLine);
    iTemp := Pos('>', sLine);
    if pos('</', sLine) > 0 then
      Result := copy(sLine, iTemp+1, pos('</', sLine)-iTemp-1)
    else
      Result := copy(sLine, iTemp+1, length(sLine));
  end;
end;

function TContactReader.Add: TContactItem;
var
  oItem : TContactItem;
begin
  oItem := TContactItem.Create;
  FListItems.Add(oItem);
  Result := oItem;
end;

function TContactReader.FindString ( sSubString, sString : string ): boolean;
begin
  Result := Pos(UpperCase(sSubString), UpperCase(sString)) > 0;
end;



end.
