unit circle_lists  ;


interface
uses
  SysUtils;

type

listptr = ^ListEl;
tdata = integer;
    //Элемент (ячейка) списка
  ListEl = record
    info: tdata;   //Некоторые данные
    Prev: Listptr;  //Предыдущий элемент
    Next: Listptr;  //Следующий элемент
  end;

procedure initlist(var p:listptr);
function listisempty(p:listptr):boolean;
procedure indexdel(var h:listptr; i:integer);
procedure insertto(var p:listptr; a:tdata; n:integer);
procedure showlist(h:listptr);

implementation


var
  g:listptr;
  i,n,a:integer;

procedure initlist(var p:listptr);
begin
  New(p);
  p:=nil;
end;

function listisempty(p:listptr):boolean;
begin
  result:=p=nil;
end;

procedure indexdel(var h:listptr; i:integer);
var
  q,k: listptr;
  j: integer;
begin
  q:=h;
  if not listisempty(q) then
  for j:=1 to i-1 do
    q:=q^.next
  else
  begin
    writeln('List is smaller then this index( ',i,' )');
    readln;
    exit;
  end;
  k:=q;
  q:=q^.next^.next;
  q^.prev:=k;
  k:=q;
  q:=q^.Prev;
  q^.Next:=k;

end;

procedure insertto(var p:listptr; a:tdata; n:integer);
var
  q,k: listptr;
  i:integer;
begin

  if listisempty(p) then
  begin
    New(q);
    q^.info:=a;
    q^.next:=q;
    q^.Prev:=q;
    p:=q;
  end

  else

  if (p^.Next=p)and(p^.Prev=p) then
    begin
      new(q);
      new(k);
      New(k^.prev);
      New(k^.next);
      q:=p;
      New(q^.prev);
      New(q^.next);
      k^.info:=a;
      q^.Prev:=k;
      q^.Next:=k;
      k^.Next:=q;
      k^.Prev:=q;
      p:=q;
    end
  else
    begin
      new(q);
      new(k);
      q:=p;
      for i:= 1 to n do
        q:=q^.Next;
      k^.info:=a;
      k^.Prev:=q;
      q:=q^.Next;
      k^.next:=q;
      q^.Prev:=k;
      q:=q^.Prev^.Prev;
      q^.next:=k;
      p:=q;
    end;


end;

procedure showlist(h:listptr);
var
  q:listptr;
  m:boolean;
begin
  m:=listisempty(h);
  if not(m) then
  begin
    q:=h;
    q:=q^.Next;
    writeln(q^.info);
  while q<>h do
  begin
    q:=q^.Next;
    writeln(q^.info);

  end;
  end
  else
  writeln('list is empty');

end;
end.
 