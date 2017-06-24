unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Imaging.pngimage;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    FileListBox1: TFileListBox;
    Edit2: TEdit;
    ScrollBox1: TScrollBox;
    Button4: TButton;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    //procedure draw(sx,sy,ex,ey:longint);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  movex:array[1..8]of Integer=(-1,0,1,1,1,0,-1,-1);
  movey:array[1..8]of Integer=(-1,-1,-1,0,1,1,1,0);
  sequence:array[1..4]of Integer=(4,2,3,1);
  num: LongInt=0;
  objnum: LongInt=0;
  data:array[0..5,1..2]of Integer;
  database:array[1..1000,1..4,1..2]of Integer;

implementation

{$R *.dfm}

uses
  System.json;

procedure draw(sx,sy,ex,ey:longint; k:LongInt = clRed; len:LongInt = 1);
begin
  with Form3.PaintBox1.Canvas do
    begin
      MoveTo(sx,sy);
      Pen.Style := psSolid;//样式
      Pen.Color := k ;//颜色
      Pen.Width := len;//宽度
      LineTo(ex,ey);
    end;
end;

procedure drawpoint(x,y:longint;k:longint = clRed);
var i:LongInt;
begin
  with form3 do
  begin
    label1.Caption:='X='+IntToStr(x)+'  Y='+IntToStr(y);
    for I := 1 to 8 do
    begin
      PaintBox1.Canvas.Pixels[x,y]:=k;
      if (x+movex[i]>=0)and(y+movey[i]>=0) then
        PaintBox1.Canvas.Pixels[x+movex[i],y+movey[i]]:=k;
    end;
  end;
end;

procedure redraw;
var
  I: Integer;
begin
  with form3 do
  begin
    PaintBox1.Invalidate;
    PaintBox1.Repaint;
  end;
  for I := 1 to num do
    drawpoint(data[i][1],data[i][2]);
  for I := 1 to num-1 do
    draw(data[i][1],data[i][2],data[i+1][1],data[i+1,2]);
  if num=4 then
    draw(data[4][1],data[4][2],data[1][1],data[1,2]);
end;

procedure makejson;
var  str:string;
     i,j:integer;
     bat:TextFile;
begin
  if not FileExists(Form3.Edit1.text+'\jsondata\') then
    CreateDir(Form3.Edit1.text+'\jsondata\');
  str:=Form3.Edit1.text+'\jsondata\'+form3.Edit2.Text;
  Delete(str,Length(str)-3,4);
  str:=str+'.json';
  Form3.Edit2.Text:=str;
  Assignfile(bat,str);
  Rewrite(bat);
  Writeln(bat,'{');
  for I := 0 to objnum-1 do
    begin
      Write(bat,'    "');
      write(bat,i);
      Writeln(bat,'": {');
      Writeln(bat,'        "coordinate": {');
      for j := 1 to 4 do
        begin
          write(bat,'            "p_');
          write(bat,j);
          Writeln(bat,'": {');
          write(bat,'                "y": ');
          write(bat,database[i+1][j][2]);
          Writeln(bat,', ');
          write(bat,'                "x": ');
          writeln(bat,database[i+1][j][1]);
          write(bat,'            }');
          if j<>4 then Writeln(bat,', ')
                  else writeln(bat);
        end;
      Writeln(bat,'        }, ');
      Writeln(bat,'        "content": ""');
      write(bat,'    }');
      if i<>objnum-1 then Writeln(bat,', ')
                   else writeln(bat);

    end;
  Write(bat,'}');
  CloseFile(bat);
end;

procedure cleardata;
var i,j:LongInt;
begin
  num:=0;
  objnum:=0;
  for I := 1 to 5 do
    for j := 1 to 2 do
      data[i,j]:=0;
  with Form3.Image1 do
  begin
    Left := 0;
    Width := 0;
    Height := 0;
    Top := 0;
  end;
  with Form3.PaintBox1 do
  begin
    Left := Form3.Image1.Left;
    Width := Form3.Image1.Width;
    Height := Form3.Image1.Height;
    Top := Form3.Image1.Top;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  dec(num);
  redraw;
end;

procedure TForm3.Button2Click(Sender: TObject);
var ok:Boolean;
    str:string;
begin
  ok:=selectdirectory('选择文件夹','',str);
  Edit1.Text:=str;
  FileListBox1.Directory:=str;
end;

procedure TForm3.Button3Click(Sender: TObject);
var i:LongInt;
begin
  if (num=4) then
    begin
      objnum:=objnum+1;
      for I := 1 to 4 do
      begin
        database[objnum][i][1]:=data[i][1];
        database[objnum][i][2]:=data[i][2];
      end;
      num:=0;
      redraw;
    end;
end;

{procedure readjson();
var jsonArray: TJSONArray;
    JSONObject: TJSONObject;
    str:string;
    strs:TStrings;
    bat:TextFile;
    i,j:longint;
    jsonvalue: Tjsonvalue;

begin
  strs.Clear;
  str:=Form3.Edit1.text+'\jsondata\'+form3.Edit2.Text;
  Delete(str,Length(str)-3,4);
  str:=str+'.json';
  Form3.Edit2.Text:=str;
  Assignfile(bat,str);
  Reset(bat);
  while not Eof(bat) do
  begin
    Readln(bat,str);
    strs.Add(str);
  end;
  JSONObject := TJSONObject.ParseJSONValue(Trim(str)) as TJSONObject;
  i:=0;
  while jsonObject.TryGetValue(IntToStr(i) , jsonvalue) do
  begin
    jsonArray := TJSONArray(JSONObject.GetValue(IntToStr(i)));
    inc(i);
  end;
end;    }

procedure TForm3.Button4Click(Sender: TObject);
var i,j:LongInt;
begin
  if  FileExists(Form3.Edit1.text+'\jsondata\'+form3.Edit2.Text) then
  begin
    //Readjson();
  end;
  for j := 1 to objnum do
    begin
      for I := 1 to 4 do
        drawpoint(database[j][i][1],database[j][i][2],clYellow);
      for I := 1 to 4-1 do
        draw(database[j][i][1],database[j][i][2],database[j][i+1][1],database[j][i+1,2],clYellow,2);
      //if num=4 then
        draw(database[j][4][1],database[j][4][2],database[j][1][1],database[j][1,2],clYellow,2);
    end;

end;

procedure TForm3.FileListBox1Change(Sender: TObject);
begin
  ScrollBox1.VertScrollBar.Position:=0;
  ScrollBox1.HorzScrollBar.Position:=0;
  if FileListBox1.FileName<>'' then
  begin
    makejson;
    Image1.Picture.LoadFromFile(FileListBox1.FileName);
    cleardata;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  I: Integer;
  j: Integer;
begin
  SendMessage(self.Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
  cleardata;
  FileListBox1.Directory:='';
  Edit1.Text:='Please choose folder';
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key='a' then
  begin
    Dec(num);
    redraw;
  end;
end;

procedure TForm3.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var  I,j: Integer;
     ok:Boolean;
begin
  ok:=False;
  if (RadioButton1.Checked)and(Button=mbLeft) then OK:=True;
  if (RadioButton2.Checked)and(Button=mbRight) then OK:=True;
  if (num=4)and(Button<>mbMiddle) then
    ok:=False;
  if (Button=mbMiddle)and(num=4) then
    begin
      objnum:=objnum+1;
      for I := 1 to 4 do
      begin
        database[objnum][i][1]:=data[i][1];
        database[objnum][i][2]:=data[i][2];
      end;
      num:=0;
      redraw;
    end;
  if OK then
  begin
    drawpoint(x,y);
    Inc(num);
    if num>4 then begin
                    num:=1;
                    data[num][1]:=x;
                    data[num][2]:=y;redraw;
                  end
             else
               begin
                 if num<>1 then draw(data[num-1,1],data[num-1,2],x,y);
                 if num=4 then draw(x,y,data[1,1],data[1][2]);
               end;
    data[num][1]:=x;
    data[num][2]:=y;
  end
  else
  begin
    data[num][1]:=x;
    data[num][2]:=y;
    Redraw;
  end;
end;

end.
