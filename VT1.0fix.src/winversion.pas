{
This is part of Vortex Tracker II project
(c)2000-2026 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://ay.strangled.net/
}

unit WinVersion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Dialogs, LCLIntf, LCLType, lazutf8,
  {$IFDEF Windows}
  Windows,
  {$ENDIF Windows}
  Types;

procedure CheckStringFitting(handle: THandle; var s: string; w: integer);
function GetProcessFileName: string;
{$IFNDEF Windows}
procedure NonWin;
{$ENDIF Windows}

implementation

{$IFNDEF Windows}
uses
  Languages;
{$ENDIF Windows}

procedure CheckStringFitting(handle: THandle; var s: string; w: integer);
var
  sz: TSize;
  len, nch: integer;
begin
  len := Length(s); //в байтах - вроде фича LCL, а не баг
  if not LCLIntf.GetTextExtentExPoint(handle, PChar(s), len, w, @nch, nil, Sz) then exit;
  len := UTF8Length(s);
  if nch < len then s := UTF8Copy(s, 1, nch - 3) + '...';
end;

function GetProcessFileName: string;
begin
  Result := ParamStr{UTF8}(0);
end;

{$IFNDEF Windows}
procedure NonWin;
begin
  MessageDlg(Mes_WinVersion, mtInformation, [mbOK], 0);
end;
{$ENDIF Windows}

end.
