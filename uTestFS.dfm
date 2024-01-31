object Form1: TForm1
  Left = 192
  Top = 103
  Width = 924
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object fsSyntaxMemo1: TfsSyntaxMemo
    Left = 0
    Top = 0
    Width = 913
    Height = 401
    Cursor = crIBeam
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    TabStop = True
    BlockColor = clHighlight
    BlockFontColor = clHighlightText
    CommentAttr.Charset = DEFAULT_CHARSET
    CommentAttr.Color = clNavy
    CommentAttr.Height = -13
    CommentAttr.Name = 'Courier New'
    CommentAttr.Style = [fsItalic]
    KeywordAttr.Charset = DEFAULT_CHARSET
    KeywordAttr.Color = clWindowText
    KeywordAttr.Height = -13
    KeywordAttr.Name = 'Courier New'
    KeywordAttr.Style = [fsBold]
    StringAttr.Charset = DEFAULT_CHARSET
    StringAttr.Color = clNavy
    StringAttr.Height = -13
    StringAttr.Name = 'Courier New'
    StringAttr.Style = []
    TextAttr.Charset = DEFAULT_CHARSET
    TextAttr.Color = clWindowText
    TextAttr.Height = -13
    TextAttr.Name = 'Courier New'
    TextAttr.Style = []
    Lines.Strings = (
      'Procedure Init;'
      'begin'
      '  with Form1 do'
      '  begin'
      '    btnSave.OnClick := '#39'btnSaveClick'#39';'
      '  end;'
      'end;'
      ''
      'procedure btnSaveClick(sender: Tobject);'
      'begin'
      'ShowMessage('#39'Gagal menyimpan'#39');'
      'end;'
      ''
      'begin'
      '  Init;'
      'end.')
    ReadOnly = False
    SyntaxType = stPascal
    ShowFooter = True
    ShowGutter = True
  end
  object Button1: TButton
    Left = 840
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object fsScript1: TfsScript
    SyntaxType = 'PascalScript'
    Left = 120
    Top = 56
  end
  object fsPascal1: TfsPascal
    Left = 200
    Top = 64
  end
  object fsClassesRTTI1: TfsClassesRTTI
    Left = 248
    Top = 40
  end
  object fsGraphicsRTTI1: TfsGraphicsRTTI
    Left = 336
    Top = 48
  end
  object fsFormsRTTI1: TfsFormsRTTI
    Left = 304
    Top = 88
  end
  object fsDialogsRTTI1: TfsDialogsRTTI
    Left = 408
    Top = 80
  end
  object fsExtCtrlsRTTI1: TfsExtCtrlsRTTI
    Left = 456
    Top = 56
  end
  object fsDBRTTI1: TfsDBRTTI
    Left = 448
    Top = 16
  end
  object fsDBCtrlsRTTI1: TfsDBCtrlsRTTI
    Left = 520
    Top = 24
  end
  object fsBDERTTI1: TfsBDERTTI
    Left = 584
    Top = 40
  end
  object fsADORTTI1: TfsADORTTI
    Left = 648
    Top = 32
  end
  object fsChartRTTI1: TfsChartRTTI
    Left = 744
    Top = 72
  end
  object fsIBXRTTI1: TfsIBXRTTI
    Left = 648
    Top = 152
  end
  object Open: TOpenDialog
    Left = 48
    Top = 64
  end
end
