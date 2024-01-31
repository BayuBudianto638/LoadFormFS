unit uTestFS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, sPanel, StdCtrls, Buttons, FileCtrl,
  DBGrids, Menus, TB97Ctls, sSkinProvider, fs_iibxrtti, fs_ibdertti, 
  fs_iadortti, fs_idbctrlsrtti, fs_idbrtti, fs_idialogsrtti,
  fs_iextctrlsrtti, fs_iformsrtti, fs_igraphicsrtti, fs_iclassesrtti,
  fs_ipascal, fs_iinterpreter, fs_synmemo, Grids,
  Clipbrd, Comctrls, Db, Dbcgrids,  ShellApi,
  Dbctrls, Dblookup, Dbtables, Ddeman, Mask, Mplayer, Oleconst, Olectnrs, Chart,
  Olectrls, Outline, Tabnotbk, Tabs,
  ToolWin, ImgList,  fs_ichartrtti;


type
  TForm1 = class(TForm)
    fsScript1: TfsScript;
    fsPascal1: TfsPascal;
    fsClassesRTTI1: TfsClassesRTTI;
    fsGraphicsRTTI1: TfsGraphicsRTTI;
    fsFormsRTTI1: TfsFormsRTTI;
    fsDialogsRTTI1: TfsDialogsRTTI;
    fsExtCtrlsRTTI1: TfsExtCtrlsRTTI;
    fsSyntaxMemo1: TfsSyntaxMemo;
    fsDBRTTI1: TfsDBRTTI;
    fsDBCtrlsRTTI1: TfsDBCtrlsRTTI;
    fsBDERTTI1: TfsBDERTTI;
    fsADORTTI1: TfsADORTTI;
    fsChartRTTI1: TfsChartRTTI;
    fsIBXRTTI1: TfsIBXRTTI;
    Button1: TButton;
    Open: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FindMethod(Reader: TReader; const MethodName: string;
    var Address: Pointer; var Error: Boolean);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
   frm : TForm;

type
    TClassArray = array [1..145] of TPersistentClass;
const 
  ClassArray: TClassArray = (
    TBitmap, TGraphic, TOutlineNode, TGraphicsObject,
    TBrush, THeaderSection, TParams, TCanvas,
    THeaderSections, TPen, TIcon, TPicture,
    TIconOptions, TCollection, TCollectionItem, TColumn,
    TStatusPanel, TColumnTitle, TStatusPanels, TClipboard,
    TControlScrollBar, TListColumn, TStringList, TListItem,
    TStrings, TListItems, TMetafile, TMetafileCanvas,
    TTreeNode, TFont, TParaAttributes, TTreeNodes,
    TApplication, TDDEServerItem, TPanel, TAutoIncField,
    TDirectoryListBox, TPopupMenu, TBatchMove, TDrawGrid,
    TPrintDialog, TBCDField, TDriveComboBox, TPrinterSetupDialog,
    TBevel, TEdit, TProgressBar, TBitBtn,
    TField, TQuery, TBlobField, TFileListBox,
    TRadioButton, TBooleanField, TFilterComboBox, TRadioGroup,
    TButton, TFindDialog, TReplaceDialog, TBytesField,
    TFloatField, TCheckBox, TFontDialog,
    TRichEdit, TColorDialog, TForm, TSaveDialog,
    TComboBox, TGraphicField, TScreen, TCurrencyField,
    TGroupBox, TScrollBar, TDatabase, THeader,
    TScrollBox, TDataSource, THeaderControl, TSession,
    TDateField, THotKey, TShape, TStaticText, TDateTimeField,
    TImage, TSmallIntField, TDBCheckBox, TImageList,
    TSpeedButton, TDBComboBox, TIntegerField, TStatusBar,
    TDBCtrlGrid, TLabel, TStoredProc, TDBEdit,
    TListBox, TStringField, TDBGrid, TListView,
    TStringGrid, TDBImage, TMainMenu, TTabbedNotebook,
    TDBListBox, TMaskEdit, TTabControl, TDBLookupCombo,
    TMediaPlayer, TTable, TMemoField, TDBLookupComboBox,
    TMemo, TTabSet, TDBLookupList, TTabSheet, TToolBar,
    TCoolBar, TToolButton, 
    TDBLookupListBox, TMenuItem, TTimeField, TDBMemo,
    TNotebook, TTable, TDBNavigator, TOleContainer,
    TTimer, TDBRadioGroup, TOpenDialog, TTrackBar,
    TDBText, TOutline, TTreeView, TDDEClientConv,
    TOutline, TUpdateSQL, TDDEClientItem, TPageControl,
    TUpDown, TDDEServerConv, TPaintBox, TVarBytesField,
    TWordField, TSplitter);

procedure TForm1.FindMethod(Reader: TReader; const MethodName: string;
    var Address: Pointer; var Error: Boolean);
begin
	Address := nil;
	Error := False;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   Input	 : TFileStream;
   Reader : TReader;
   bWriteProperty : boolean;
   sPropertyName : string;
   slStrings	 : TStringList;

   procedure WriteStr(const S: string);
   begin
       slStrings.Add(S);
   end;

   procedure ConvertValue; forward;

   procedure ConvertHeader;
   var
       sClassName,
       sObjectName : string;
       Flags : TFilerFlags;
       Position : Integer;
   begin
       Reader.ReadPrefix(Flags, Position);
       sClassName := Reader.ReadStr;
       sObjectName := Reader.ReadStr;
   end;

   procedure ConvertBinary;
   var
       lCount : Longint;
       pBuffer : PChar;
   begin
       Reader.ReadValue;
       Reader.Read(lCount, SizeOf(lCount));

       GetMem(pBuffer, lCount+1);
       Reader.Read(pBuffer^, lCount);
       FreeMem(pBuffer);
   end;

   procedure ConvertProperty; forward;

   procedure ConvertValue;
   begin
       case Reader.NextValue of
           vaList:
            begin
               Reader.ReadValue;
               while not Reader.EndOfList do
                   ConvertValue;
               Reader.ReadListEnd;
            end;
           vaInt8,
           vaInt16,
           vaInt32:
               Reader.ReadInteger;
           vaExtended:
               Reader.ReadFloat;
           vaString,
           vaLString:
               if bWriteProperty then
                   WriteStr(Reader.ReadString)
               else
                   Reader.ReadString;
           vaIdent,
           vaFalse,
           vaTrue,
           vaNil:
               Reader.ReadIdent;
           vaBinary:
               ConvertBinary;
           vaSet:
            begin
               Reader.ReadValue;
               while Reader.ReadStr <> '' do
                begin
                end;
            end;
           vaCollection:
            begin
               Reader.ReadValue;
               while not Reader.EndOfList do
                begin
                   if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
                       ConvertValue;
                   Reader.ReadValue;
                   while not Reader.EndOfList do
                       ConvertProperty;
                   Reader.ReadListEnd;
                end;
               Reader.ReadListEnd;
            end;
       end;
   end;

   procedure ConvertProperty;
   begin
       sPropertyName := Reader.ReadStr;
// bWriteProperty := WriteProperty(sPropertyName);
       ConvertValue;
   end;

   procedure ConvertObject;
   begin
       ConvertHeader;
       while not Reader.EndOfList do
           ConvertProperty;
       Reader.ReadListEnd;
       while not Reader.EndOfList do
           ConvertObject;
       Reader.ReadListEnd;
   end;
   
begin
  {
  if isOpen = false then
  begin
    fsScript1.Clear;
    fsScript1.Lines := EditorText.Lines;
    fsScript1.Parent := fsGlobalUnit;

    if fsScript1.Compile then
      fsScript1.Execute
    else
      MessageDlg(fsScript1.ErrorMsg, mtError, [mbOK],0);

    exit;
  end;
  }
    if Open.Execute then
    begin
   frm := TForm.Create( Application );

   Input := TFileStream.Create(Open.FileName, fmOpenRead);
   slStrings := TStringList.Create;

   try
       Input.ReadResHeader;

       Reader := TReader.Create(Input, 4096);
       Reader.OnFindMethod := FindMethod;
       Reader.ReadRootComponent(frm);
     {
       Reader := TReader.Create(Input, 4096);
       Reader.ReadSignature;

       ConvertObject;
      }
      showmessage('1');
      fsScript1.Clear;
         fsScript1.Lines := fsSyntaxMemo1.Lines;
         fsScript1.Parent := fsGlobalUnit;
         fsScript1.AddObject('Form1',frm);
         fsScript1.AddForm(frm);
       frm.Show;
        if fsScript1.Compile then
            fsScript1.Execute
         else
            MessageDlg(fsScript1.ErrorMsg, mtError, [mbOK],0);
      showmessage('2');       

     finally
     {
     frm.Free;
     Reader.Free;
     }
     Input.Free;
     slStrings.Free;
   end;
   end;
end;

initialization


//*Ini wajib di register, register kan semua component yang sudah di list di array atas tsb*//
RegisterClass(TForm);
RegisterClass(TEdit);
RegisterClass(TButton);
RegisterClass(TLabel);
RegisterClass(TMemo);
RegisterClass(TCheckBox);
RegisterClass(TRadioButton);
RegisterClass(TListBox);
RegisterClass(TComboBox);
RegisterClass(TGroupBox);
RegisterClass(TRadioGroup);
RegisterClass(TPanel);
RegisterClass(TBitBtn);
RegisterClass(TSpeedButton);
RegisterClass(TMaskEdit);
RegisterClass(TImage);
RegisterClass(TShape);
RegisterClass(TBevel);
RegisterClass(TStaticText);
RegisterClass(TOpenDialog);
RegisterClass(TSaveDialog);
RegisterClass(TFontDialog);
RegisterClass(TColorDialog);

end.
