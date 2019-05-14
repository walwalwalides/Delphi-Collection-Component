unit uCalendarText;

interface

uses
  SysUtils,
  DateUtils;

type
  Win1252String = type AnsiString(65001);

  TCalendarLanguage = (CalEnglish, CalFrench, CalArabic);

  TCalendar = class(TObject)
  private

    FDate: TDateTime;
    FDay, FMonth, FYear: Word;
    FDayString: Array [1 .. 7] OF String[8];
    FMonthString: Array [1 .. 12] OF String[9];
  public
    constructor Create(Alanguage: TCalendarLanguage);
    function MBCString(const s: UnicodeString; CodePage: Word): RawByteString;
    Function GetDay(): String;
    Function GetMonth(): Word;
    Function GetYear(): Word;

    Function GetDayString(): String;
    Function GetMonthYearString(): String;
  end;

implementation

// {$IFDEF UNICODE}

function TCalendar.MBCString(const s: UnicodeString; CodePage: Word): RawByteString;
var
  enc: TEncoding;
  bytes: TBytes;
begin
  enc := TEncoding.GetEncoding(CodePage);
  try
    bytes := enc.GetBytes(s);
    SetLength(Result, Length(bytes));
    Move(Pointer(bytes)^, Pointer(Result)^, Length(bytes));
    SetCodePage(Result, CodePage, False);
  finally
    enc.Free;
  end;
end;

constructor TCalendar.Create(Alanguage: TCalendarLanguage);
var
tmpansi:AnsiString;
begin
  FDate := Date;
  DecodeDate(FDate, FYear, FMonth, FDay);

  case Alanguage of

    CalEnglish:
      Begin
        FDayString[1] := 'Sunday';
        FDayString[2] := 'Monday';
        FDayString[3] := 'Tuesday';
        FDayString[4] := 'Wednesday';
        FDayString[5] := 'Thursday';
        FDayString[6] := 'Friday';
        FDayString[7] := 'Saturday';

        FMonthString[1] := 'January';
        FMonthString[2] := 'February';
        FMonthString[3] := 'Mars';
        FMonthString[4] := 'Avril';
        FMonthString[5] := 'May';
        FMonthString[6] := 'June';
        FMonthString[7] := 'July';
        FMonthString[8] := 'August';
        FMonthString[9] := 'September';
        FMonthString[10] := 'October';
        FMonthString[11] := 'November';
        FMonthString[12] := 'December';
      End;

    CalFrench:
      Begin
        FDayString[1] := 'Dimanche';
        FDayString[2] := 'Lundi';
        FDayString[3] := 'Mardi';
        FDayString[4] := 'Mercredi';
        FDayString[5] := 'Jeudi';
        FDayString[6] := 'Vendredi';
        FDayString[7] := 'Samedi';

        FMonthString[1] := 'Janvier';
        FMonthString[2] := 'Février';
        FMonthString[3] := 'Mars';
        FMonthString[4] := 'Avril';
        FMonthString[5] := 'Mai';
        FMonthString[6] := 'Juin';
        FMonthString[7] := 'Juillet';
        FMonthString[8] := 'Août';
        FMonthString[9] := 'Septembre';
        FMonthString[10] := 'Octobre';
        FMonthString[11] := 'Nouvembre';
        FMonthString[12] := 'Décembre';
      End;

    CalArabic:
      Begin
        FDayString[1] :=MBCString( 'الأحد',65001);
        FDayString[2] := MBCString('الاثنين',65001);
        FDayString[3] := MBCString('الثلاثاء',65001);
        FDayString[4] := MBCString('الأربعاء',65001);
        FDayString[5] := MBCString('الخميس',65001);
        FDayString[6] := MBCString('الجمعة',65001);
        FDayString[7] := MBCString('السبت',65001);

        FMonthString[1] := MBCString(' ْيَنَاي',65001);
        FMonthString[2] := MBCString(' ْفَبرايِ',65001);
        FMonthString[3] := MBCString('مارس',65001);
        FMonthString[4] := MBCString('ابريل',65001);
        FMonthString[5] := MBCString('مَايُو', 65001);
        FMonthString[6] := MBCString('يونيو',65001);
        FMonthString[7] := MBCString('يوليو',65001);
        FMonthString[8] := MBCString('أغسطس',65001);
        FMonthString[9] := MBCString('سبتمبر',65001);
        FMonthString[10] :=MBCString( 'أكتوبر',65001);
        FMonthString[11] := MBCString('نونبر ',65001);
        FMonthString[12] :=MBCString( 'ديسمبر',65001);

      End;
  end;

End;

Function TCalendar.GetDay(): String;
Begin
  Result := IntToStr(FDay);
End;

Function TCalendar.GetMonth(): Word;
Begin
  Result := FMonth;
End;

Function TCalendar.GetYear(): Word;
Begin
  Result := FYear;
End;

Function TCalendar.GetDayString(): String;
Begin
  Result := FDayString[SysUtils.DayOfWeek(FDate)];
End;

Function TCalendar.GetMonthYearString(): String;
Begin
  Result := FMonthString[GetMonth] + ' ' + IntToStr(GetYear);
End;

end.
