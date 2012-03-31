unit list_unit;

interface

type
  TData = Integer;
  TPElem = ^TElem;
  TElem = record
    Data : TData;
    PNext : TPElem;
    PPrev : TPElem;
  end;
   TList = record
    PFirst : TPElem;
    PLast : TPElem;
  end;
  TInfo = integer;
  PNode = ^TNode;
  TNode = record
    Info: TInfo;
    Next,
    Pred: PNode;
  end;


procedure AddLast(var aList : TList; const aPElem : TPElem);{��������� �������� � ����� ������}
procedure AddFirst(var aList : TList;const  aPElem : TPElem);{���������� �������� � ������ ������}
procedure ListFree(var aList : TList);{������� ������}
procedure DelByRef(var aList : TList; var aPElem : TPElem) ;{�������� �������� �� ��� ���������}
function FindElem(const aList : TList; const aData : TData) : TPElem;{����� �������� � ������ �� ������, ���� ��� ���������� NIL}
procedure InsB(var aList : TList;const aPBase, aPElem : TPElem);{������� ����� ���������}
function GetByNum(const aList : TList; const aI : Longword):tpelem;{����������� ��������� �� ������� �� ��� ������ � ������. ���� ���, �� Nil}
procedure ShowList(var aList: Tlist);{����� ������}
procedure DelByNum(var aList: Tlist; a: integer); {�������� �������� �� ��� ������}


implementation

{��������� �������� � ����� ������}
procedure AddLast(var aList : TList; const aPElem : TPElem);
begin
  if aPElem = nil then Exit;
  aPElem^.PNext := nil;
  aPElem^.PPrev := nil;
  if aList.PFirst = nil then begin
    aList.PFirst := aPElem;
    aList.PLast := aPElem;
  end
  else begin
    aList.PLast^.PNext := aPElem;
    aPElem^.PPrev := aList.PLast;
    aList.PLast := aPElem;
  end;
end;

{���������� �������� � ������ ������}
procedure AddFirst(var aList : TList;const  aPElem : TPElem);
begin
  if aPElem = nil then Exit;
  aPElem^.PNext := nil;
  aPElem^.PPrev := nil;
  if aList.PFirst = nil then begin
    aList.PFirst := aPElem;
    aList.PLast := aPElem;
  end else begin
    aPElem^.PNext := aList.PFirst;
    aList.PFirst^.PPrev := aPElem;
    aList.PFirst := aPElem;
  end;
end;

{������� ������}
procedure ListFree(var aList : TList);
var
  PNext, PDel : TPElem;
begin
  if aList.PFirst = nil then Exit;
  PNext := aList.PFirst;
  while PNext <> nil do begin
    PDel := PNext;
    PNext := PNext^.PNext;
    Dispose(PDel);
  end;
  aList.PFirst := nil;
  aList.PLast := nil;
end;

{�������� �������� �� ��� ���������}
procedure DelByRef(var aList : TList; var aPElem : TPElem) ;
begin
  if aPElem = nil then Exit;
  if aPElem = aList.PFirst then begin
    aList.PFirst := aPElem^.PNext;
    if aList.PFirst = nil then
      aList.PLast := nil
    else
      aList.PFirst^.PPrev := nil;
  end else if aPElem = aList.PLast then begin
    aList.PLast := aPElem^.PPrev;
    if aList.PLast = nil then
      aList.PFirst := nil
    else
      aList.PLast^.PNext := nil;
  end else begin
    aPElem^.PPrev^.PNext := aPElem^.PNext;
    aPElem^.PNext^.PPrev := aPElem^.PPrev;
  end;
  Dispose(aPElem);
  aPElem := nil;
end;

{����� �������� � ������ �� ������, ���� ��� ���������� NIL}
function FindElem(const aList : TList; const aData : TData) : TPElem;
var
  PNext : TPElem;
begin
  Result := nil;
  PNext := aList.PFirst;
  while PNext <> nil do begin
    if PNext^.Data = aData then begin
      Result := PNext;
      Break;
    end;
    PNext := PNext^.PNext;
  end;
end;

{������� ����� ���������}
procedure InsB(var aList : TList;const aPBase, aPElem : TPElem);
begin
  if aPElem = nil then Exit;
  if (aList.PFirst = nil) or (aPBase = nil) or (aPBase = aList.PFirst) then begin
    AddFirst(aList, aPElem);
  end
  else
  begin
    aPBase^.PNext := aPElem;
    aPBase^.PPrev:=aPElem^.PPrev;
    aPElem^.PPrev:=aPBase;
  end;
end;

{����������� ��������� �� ������� �� ��� ������ � ������. ���� ���, �� Nil}
function GetByNum(const aList : TList; const aI : Longword): tpelem;
var
  i : Longword;
  PElem : TPElem;
begin
  Result := nil;
  i := 1;
  PElem := aList.PFirst;
  while (i <= aI) and (PElem <> nil) do begin
    if i = aI then begin
      Result := PElem;
      Break;
    end;
    Inc(i);
    PElem := PElem^.PNext;
  end;
  Result := PElem;
end;

{����� ������}
procedure ShowList(var aList: Tlist);
var
PElem : TPElem;
begin
  PElem := aList.PFirst;
  while PElem <> nil do
  begin
    writeln(PElem^.Data);
    PElem := PElem^.PNext;
  end;
end;
{�������� �������� �� ��� �������}
procedure DelByNum(var aList: Tlist;  a: integer);
var
PElem: TPElem;
i: integer;
begin
  PElem:=alist.PFirst;
  for i:=1 to (a-1) do
  begin
    PElem:=PElem.PNext;
  end;
  DelByRef(alist,PElem);
end;




end.
