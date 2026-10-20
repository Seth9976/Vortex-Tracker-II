{
This is part of Vortex Tracker II project
(c)2000-2026 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://ay.strangled.net/
}

unit options;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF Windows}
  Windows,
  {$ELSE Windows}
  WinVersion,
  {$ENDIF Windows}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls, Buttons, Grids, digsound, AY, LCLProc, TypInfo;

type
  PVTFont = ^TVTFont;

  TVTFont = record
    Name: string;
    Size: integer;
    Bold: boolean;
  end;

  TColorTarget = (ctGlobal, ctTracks, ctSample, ctOrnaments, ctTest);

  TOptionsSet = record
    TracksFont, SamplesFont, OrnamentsFont, TestsFont: TVTFont;
    GlobalColorWorkspace, GlobalColorBgEmpty,
    TracksColorBg, TracksColorTxt, TracksColorBgHl,
    TracksColorBgHlMain, TracksColorBgBeyond, TracksColorTxtHlMain,
    SamplesColorBg, SamplesColorTxt, SamplesColorBgLp, SamplesColorTxtLp,
    SamplesColorBgBeyond, SamplesColorTxtBeyond,
    SamplesColorBgHl, SamplesColorBgLpHl, SamplesColorBgBeyondHl,
    OrnamentsColorBg, OrnamentsColorTxt, OrnamentsColorBgLp, OrnamentsColorTxtLp,
    OrnamentsColorBgBeyond, OrnamentsColorTxtBeyond,
    OrnamentsColorBgHl, OrnamentsColorBgLpHl, OrnamentsColorBgBeyondHl,
    TestsColorBg, TestsColorTxt: TColor;
    TracksNOfLines, NoteTable, AutoStepValue: integer;
    ChipType: TChipTypes;
    ChannelsAllocation, ChannelsAllocationCarousel: integer;
    AY_Freq, Interrupt_Freq, NumberOfChannels, SampleRate, SampleBit: integer;
    FilterWant: boolean;
    DetectFeaturesLevel, DetectModuleHeader: boolean;
    DecTrLines, DecNoise, EnvAsNote, RecalcEnv, BgAllowMIDI: boolean;
    SamAsNote, OrnAsNote, TracksHint, SamHint, OrnHint, SamOrnHLines: boolean;
    NotWarnUndo, LMBToDraw: boolean;
    Lang: string;
    {$IFDEF Windows}
    Priority: dword;
    {$ENDIF Windows}
  end;

  { TOptionsDlg }

  TOptionsDlg = class(TForm)
    BDefineShorcut: TButton;
    BDeleteShortcut: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    BSetDefaults: TButton;
    CBcaBCA: TCheckBox;
    CBcaCAB: TCheckBox;
    CBcaBAC: TCheckBox;
    CBcaACB: TCheckBox;
    CBcaCBA: TCheckBox;
    CBDecTrLines: TCheckBox;
    CBDecNoise: TCheckBox;
    CBEnvAsNote: TCheckBox;
    CBTracksHint: TCheckBox;
    CBSamAsNote: TCheckBox;
    CBRecalcEnv: TCheckBox;
    CBKeysSources: TComboBox;
    CBBgAllowMIDI: TCheckBox;
    CBOrnAsNote: TCheckBox;
    CBSamHint: TCheckBox;
    CBcaMono: TCheckBox;
    CBcaABC: TCheckBox;
    CBSamOrnHL: TCheckBox;
    CBNotWarnUndo: TCheckBox;
    CBLang: TComboBox;
    CBLMBtoDraw: TCheckBox;
    CBOrnHint: TCheckBox;
    EdNoteTbl: TEdit;
    EdAutStpVal: TEdit;
    GBDesign: TGroupBox;
    GBInitParams: TGroupBox;
    ChanSel: TGroupBox;
    GBLang: TGroupBox;
    Label1: TLabel;
    LbNoteTbl: TLabel;
    LbAutStpVal: TLabel;
    LbTestsFont: TLabel;
    LbOrnamentsFont: TLabel;
    LbSamplesFont: TLabel;
    LbTracksFont: TLabel;
    LbTests: TLabel;
    LbOrnaments: TLabel;
    LbTracks: TLabel;
    LbGlobal: TLabel;
    LbFIRk: TLabel;
    LbSamples: TLabel;
    OpsPages: TPageControl;
    PnKeyButs: TPanel;
    RBcaABC: TRadioButton;
    RBcaACB: TRadioButton;
    RBcaBAC: TRadioButton;
    RBcaBCA: TRadioButton;
    RBcaCAB: TRadioButton;
    RBcaCBA: TRadioButton;
    RBcaMono: TRadioButton;
    ShGlobalBgEmpty: TShape;
    ShGlobalWorkspace: TShape;
    ShOrnamentsBgBeyondHl: TShape;
    ShOrnamentsBgHl: TShape;
    ShSamplesBgLpHl: TShape;
    ShSamplesBgBeyondHl: TShape;
    ShOrnamentsBgLpHl: TShape;
    ShTestsBg: TShape;
    ShTestsTxt: TShape;
    ShSamplesBg: TShape;
    ShOrnamentsBg: TShape;
    ShOrnamentsBgBynd: TShape;
    ShSamplesBgLp: TShape;
    ShSamplesBgBynd: TShape;
    ShOrnamentsBgLp: TShape;
    ShOrnamentsTxt: TShape;
    ShOrnamentsTxtBynd: TShape;
    ShSamplesTxtLp: TShape;
    ShSamplesTxtBynd: TShape;
    ShOrnamentsTxtLp: TShape;
    ShTracksBgBynd: TShape;
    ShSamplesBgHl: TShape;
    ShTracksBgHlMain: TShape;
    ShTracksBgHl: TShape;
    ShTracksTxt: TShape;
    ShSamplesTxt: TShape;
    ShTracksTxtHlMain: TShape;
    ShTracksBg: TShape;
    SGKeys: TStringGrid;
    DesignTab: TTabSheet;
    ButOK: TButton;
    ButCancel: TButton;
    EdNumLines: TEdit;
    KeysTab: TTabSheet;
    UDNumLines: TUpDown;
    LbNumLines: TLabel;
    FontDialog1: TFontDialog;
    ChipEmu: TTabSheet;
    ChipSel: TRadioGroup;
    IntSel: TRadioGroup;
    OpMod: TTabSheet;
    FeatLevel: TRadioGroup;
    SaveHead: TRadioGroup;
    DigiSndTab: TTabSheet;
    SR: TRadioGroup;
    BR: TRadioGroup;
    NCh: TRadioGroup;
    Buff: TGroupBox;
    TBBufLen: TTrackBar;
    LbBufLn: TLabel;
    TBBufNum: TTrackBar;
    LbNum: TLabel;
    LbTotLnCpt: TLabel;
    LbTotLn: TLabel;
    LbBufLnCpt: TLabel;
    Label6: TLabel;
    SBStop: TSpeedButton;
    Resamp: TRadioGroup;
    LbNotice: TLabel;
    LBChg: TLabel;
    ChFreq: TRadioGroup;
    SelDev: TGroupBox;
    CBDevice: TComboBox;
    OtherOps: TTabSheet;
    PriorGrp: TRadioGroup;
    EdChipFrq: TEdit;
    EdIntFrq: TEdit;
    ColorDialog1: TColorDialog;
    UDNoteTbl: TUpDown;
    UDAutStpVal: TUpDown;
    procedure BDefineShorcutClick(Sender: TObject);
    procedure CBBgAllowMIDIChange(Sender: TObject);
    procedure CBcaChange(Sender: TObject);
    procedure CBLangEditingDone(Sender: TObject);
    procedure CBLMBtoDrawChange(Sender: TObject);
    procedure CBOrnAsNoteChange(Sender: TObject);
    procedure CBOrnHintChange(Sender: TObject);
    procedure CBSamAsNoteChange(Sender: TObject);
    procedure CBSamHintChange(Sender: TObject);
    procedure CBSamOrnHLChange(Sender: TObject);
    procedure CBTracksHintChange(Sender: TObject);
    procedure CBNotWarnUndoChange(Sender: TObject);
    procedure DeleteShortcutOrNoteKey;
    procedure CatchShortcutOrNoteKey;
    procedure BDeleteShortcutClick(Sender: TObject);
    procedure BSetDefaultsClick(Sender: TObject);
    procedure CBDecNoiseChange(Sender: TObject);
    procedure CBDecTrLinesChange(Sender: TObject);
    procedure CBEnvAsNoteChange(Sender: TObject);
    procedure EdAutStpValExit(Sender: TObject);
    procedure FillKeyGrid;
    procedure CBKeysSourcesChange(Sender: TObject);
    procedure CBRecalcEnvChange(Sender: TObject);
    procedure EdNoteTblExit(Sender: TObject);
    procedure EdNumLinesExit(Sender: TObject);
    procedure ChipSelClick(Sender: TObject);
    procedure FillKeySources;
    procedure FormCreate(Sender: TObject);
    procedure LbOrnamentsFontMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure LbSamplesFontMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure LbTestsFontMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure LbTracksFontMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure LoadLanguages;
    procedure UpdateLang;
    function Get_Language: string;
    procedure IntSelClick(Sender: TObject);
    procedure OpsPagesChange(Sender: TObject);
    procedure FeatLevelClick(Sender: TObject);
    procedure RBcaClick(Sender: TObject);
    procedure SGKeysKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure GraphicControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShGlobalBgEmptyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShGlobalWorkspaceMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsBgBeyondHlMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsBgByndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsBgHlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsBgLpHlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsBgLpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsBgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsTxtByndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsTxtLpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShOrnamentsTxtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesBgBeyondHlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesBgByndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesBgHlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesBgLpHlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesBgLpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesBgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesTxtByndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesTxtLpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShSamplesTxtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTestsBgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTestsTxtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTracksBgByndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTracksBgHlMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTracksBgHlMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTracksBgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTracksTxtHlMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ShTracksTxtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure TBBufLenChange(Sender: TObject);
    procedure TBBufNumChange(Sender: TObject);
    procedure SRClick(Sender: TObject);
    procedure BRClick(Sender: TObject);
    procedure NChClick(Sender: TObject);
    procedure PlayStarts;
    procedure PlayStops;
    procedure ResampClick(Sender: TObject);
    procedure ChFreqClick(Sender: TObject);
    procedure CBDeviceChange(Sender: TObject);
    procedure SaveHeadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PriorGrpClick(Sender: TObject);
    function GetValue(const s: string): integer;
    procedure EdChipFrqExit(Sender: TObject);
    procedure EdIntFrqExit(Sender: TObject);

    procedure ShowFont(aFont: TVTFont; aHolder: TGraphicControl);


    //set aFont and font of aHolder to either aFontForce^ or Font Dialog result
    //(if aFontForce=nil), NoResize=False to resize all child windows
    function ChooseFont(var aFont: TVTFont; aHolder: TGraphicControl;
      NoResize: boolean; aFontForce: PVTFont = nil): boolean;

    procedure ShowColor(aColor: TColor; aColorHolder: TGraphicControl);

    //just call Color Dialog and return aColor
    function ChooseColor(var aColor: TColor): boolean;

    //check if was aHolder.OnMouseDown just before
    //(use in aHolder.OnMouseUp to simulate OnClick in TGraphicControl)
    function CanChooseColorOrFont(aHolder: TGraphicControl): boolean;

    //if call Color Dialog set aColorHolder сolor (use in in aColorHolder.OnMouseUp)
    function ChooseColor(var aColor: TColor; aColorHolder: TGraphicControl): boolean;

    //helper function for ChooseColorTracks/Samples/Ornaments/Tests
    function SetupColors(var aColor: TColor; aColorHolder: TGraphicControl;
      aColorForce: PColor; aColorHint: PColor = nil): boolean;

    //set aColor and colors of aColorHolder and aColorHint to either aColorForce^
    //or Color Dialog result (if aColorForce=nil)
    function ChooseColorTracks(var aColor: TColor; aColorHolder: TGraphicControl;
      aColorForce: PColor = nil; aColorHint: PColor = nil): boolean;
    function ChooseColorSamples(var aColor: TColor; aColorHolder: TGraphicControl;
      aColorForce: PColor = nil; aColorHint: PColor = nil): boolean;
    function ChooseColorOrnaments(var aColor: TColor; aColorHolder: TGraphicControl;
      aColorForce: PColor = nil; aColorHint: PColor = nil): boolean;
    function ChooseColorTests(var aColor: TColor; aColorHolder: TGraphicControl;
      aColorForce: PColor = nil; aColorHint: PColor = nil): boolean;

    procedure UDAutStpValChangingEx(Sender: TObject; var AllowChange: boolean;
      NewValue: smallint; Direction: TUpDownDirection);
    procedure UDNoteTblChangingEx(Sender: TObject; var AllowChange: boolean;
      NewValue: smallint; Direction: TUpDownDirection);
    procedure UDNumLinesChangingEx(Sender: TObject; var AllowChange: boolean;
      NewValue: smallint; Direction: TUpDownDirection);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptionsDlg: TOptionsDlg;

  //selected and previous options values
  VTOptions, Saved_VTOptions: TOptionsSet;

  //since LCL depricated GetDeaultLang, we need store SetDeaultLang result here:
  DefaultLang: string = 'en';

implementation

uses
  Main, digsoundcode, digsoundbuf, trfuncs, keys, catchshortcut, nkeypeeker,
  Languages, LCLTranslator, LResources;

  {$R *.lfm}

function TOptionsDlg.GetValue(const s: string): integer;
var
  Er: integer;
begin
  Val(Trim(s), Result, Er);
  if Er <> 0 then
    Result := -1;
end;

procedure TOptionsDlg.EdNumLinesExit(Sender: TObject);
begin
  EdNumLines.Text := IntToStr(UDNumLines.Position);
  VTOptions.TracksNOfLines := UDNumLines.Position;
end;

procedure TOptionsDlg.CBDecTrLinesChange(Sender: TObject);
begin
  VTOptions.DecTrLines := CBDecTrLines.Checked;
end;

procedure TOptionsDlg.CBEnvAsNoteChange(Sender: TObject);
begin
  VTOptions.EnvAsNote := CBEnvAsNote.Checked;
end;

procedure TOptionsDlg.EdAutStpValExit(Sender: TObject);
begin
  EdAutStpVal.Text := IntToStr(UDAutStpVal.Position);
  VTOptions.AutoStepValue := UDAutStpVal.Position;
end;

procedure TOptionsDlg.FillKeyGrid;
var
  sca: TShortcutActions;
  i, j: integer;
  s: string;
begin
  if CBKeysSources.ItemIndex < CBKeysSources.Items.Count - 1 then
    //usual shortcuts
   begin
    i := 0;
    SGKeys.RowCount := 0;
    for sca := Low(TShortcutActions) to High(TShortcutActions) do
      if sca in ShortcutBySource[TShortcutSources(CBKeysSources.ItemIndex)] then
       begin
        SGKeys.RowCount := i + 1;
        SGKeys.Objects[0, i] := TObject({%H-}Pointer(Ord(sca)));
        //dummy object just action number
        SGKeys.Cells[0, i] := ShortcutActionsDesc[sca];
        SGKeys.Cells[1, i] := ShortCutToText{Raw}(CustomShortcuts[sca]){%H-};
        Inc(i);
       end;
   end
  else
    //note keys
   begin
    i := 0;
    SGKeys.RowCount := 0;
    for j := 1 to 255 do
     begin
      s := {%H-}ShortCutToText{Raw}(j);
      if s <> '' then
       begin
        SGKeys.RowCount := i + 1;
        SGKeys.Objects[0, i] := TObject({%H-}Pointer(j)); //dummy object just key number
        SGKeys.Cells[0, i] := s;
        SGKeys.Cells[1, i] := NoteKeyCodesDesc[TNoteKeyCodes(NoteKeys[j])];
        Inc(i);
       end;
     end;
    SGKeys.SortColRow(True, 0);
   end;
  if SGKeys.CanSetFocus then
    SGKeys.SetFocus;
end;

procedure TOptionsDlg.CBKeysSourcesChange(Sender: TObject);
begin
  FillKeyGrid;
end;

procedure TOptionsDlg.CBRecalcEnvChange(Sender: TObject);
begin
  VTOptions.RecalcEnv := CBRecalcEnv.Checked;
end;

procedure TOptionsDlg.EdNoteTblExit(Sender: TObject);
begin
  EdNoteTbl.Text := IntToStr(UDNoteTbl.Position);
  VTOptions.NoteTable := UDNoteTbl.Position;
end;

procedure TOptionsDlg.CBDecNoiseChange(Sender: TObject);
begin
  VTOptions.DecNoise := CBDecNoise.Checked;
end;

procedure TOptionsDlg.BSetDefaultsClick(Sender: TObject);
begin
  ShortcutsSetDefault;
  NoteKeysSetDefault;
  CBKeysSources.OnChange(CBKeysSources);
end;

procedure TOptionsDlg.CatchShortcutOrNoteKey;

//asca is ignored if All=True
  function SearchSameSC(SC: TShortCut; ascs: TShortcutSources;
    asca: TShortcutActions; All: boolean = False): integer;
  var
    sca: TShortcutActions;
  begin
    for sca := Low(TShortcutActions) to High(TShortcutActions) do
      if (All or (sca <> asca)) and (sca in ShortcutBySource[ascs]) and (
        //simple shortcut
        (SC = CustomShortcuts[sca]) or
        //cursor with Shift
        ((sca in ShortcutCursorBySource[ascs]) and
        (SC = (CustomShortcuts[sca] or scShift)))) then
        Exit(Ord(sca));
    Result := -1;
  end;

  function SearchSameKey(Key: integer; ascs: TShortcutSources): integer;
  begin
    Result := SearchSameSC(Key, ascs, SCA_FileNew{dummy}, True);
    if Result < 0 then
      //octave upper
      Result := SearchSameSC(Key or scShift, ascs, SCA_FileNew{dummy}, True);
    if Result < 0 then
      //octave lower
      Result := SearchSameSC(Key or scCtrl or scShift, ascs, SCA_FileNew{dummy}, True);
  end;

var
  mes: string;
  ccnt, wcnt: integer;

  procedure AddMes(const aMes: string; c: boolean);
  begin
    if mes <> '' then
      mes += #13#10;
    mes += aMes;
    if c then
      Inc(ccnt)
    else
      Inc(wcnt);
  end;

  function CompleteMesAndAskUser: boolean;
  begin
    if mes <> '' then
     begin
      mes += #13#10#13#10 + Mes_WantCont + ' ';
      if ccnt <> 0 then
       begin
        mes += Mes_Removeing + ' ';
        if ccnt = 1 then
          mes += Mes_Conflict
        else
          mes += Mes_Conflicts;
        if wcnt <> 0 then
          mes += ' ' + Mes_And + ' ';
       end;
      if wcnt <> 0 then
       begin
        mes += Mes_Ignoring + ' ';
        if wcnt = 1 then
          mes += Mes_Warning
        else
          mes += Mes_Warnings;
       end;
      mes += '?';
     end;
    Result := (mes = '') or (MessageDlg(mes, mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  end;

  function ValidShortcut(var SC: TShortCut): boolean;

    function IsSameNoteKey: integer;
    var
      Shifts: TShortCut;
    begin
      Shifts := SC and $FF00;
      Result := SC and 255;
      if ((Shifts = 0) or //no any Shifts
        (Shifts = scShift) or //single Shift
        (Shifts = (scCtrl or scShift)) //Ctrl+Shift
        ) and (NoteKeys[Result] <> shortint(NK_NO)) then
        Exit;
      Result := -1;
    end;

  var
    Warnings: array[TShortcutSources] of integer;
    WarningNK, ConflictNK, Conflict: integer;
    scs, thisscs: TShortcutSources;
    thissca: TShortcutActions;
    i: integer;
  begin
    for scs := Low(TShortcutSources) to High(TShortcutSources) do
      Warnings[scs] := -1; //no warning
    WarningNK := -1;
    ConflictNK := -1;
    Conflict := -1;

    thisscs := TShortcutSources(CBKeysSources.ItemIndex);
    thissca := TShortcutActions(
      {%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top])));

    if thissca in ShortcutCursorBySource[thisscs] then
      //cursor combination not allowed Shift (used for selection)
      SC := SC or scShift xor scShift;

    if SC < 256 then //single chars
      //check for value inputting conflicts
      if ((thisscs = SCS_PatternLengthEditor) and
        (SC in [VK_0..VK_9, VK_UP, VK_DOWN, VK_DELETE, VK_BACK])) or
        ((thisscs = SCS_PositionListEditor) and (SC in [VK_LEFT, VK_RIGHT])) or
        ((thisscs = SCS_OrnamentEditor) and (SC in [VK_0..VK_9])) or
        ((thisscs in [SCS_SampleEditor, SCS_TestLineEditor, SCS_PatternEditor]) and
        (SC in [VK_0..VK_9, VK_A..VK_F])) then
       begin
        ShowMessage(Mes_Shortcut + ' "' +{%H-}ShortCutToText{Raw}(SC) +
          '" ' + Mes_DueConflict);
        Exit(False);
       end;

    //check for conflicts in one group
    Conflict := SearchSameSC(SC, thisscs, thissca);

    //search for same shortcuts in other groups if Global
    if thisscs = SCS_GlobalActions then
     begin
      for scs := Succ(SCS_GlobalActions) to High(TShortcutSources) do
        Warnings[scs] := SearchSameSC(SC, scs, thissca);
      WarningNK := IsSameNoteKey;
     end
    else //not global
     begin
      //search for same shortcuts in Global
      Warnings[SCS_GlobalActions] := SearchSameSC(SC, SCS_GlobalActions, thissca);
      if thisscs in [SCS_PatternEditor, SCS_TestLineEditor] then
        //search conflicts with Note Keys
        ConflictNK := IsSameNoteKey;
     end;

    ccnt := 0;
    wcnt := 0; //conflict and warnigs counters
    mes := '';

    if Conflict >= 0 then
      AddMes(Mes_ConflictWith + ' ' + ShortcutActionTextInfo(
        TShortcutActions(Conflict)), True);

    if ConflictNK >= 0 then
      AddMes(Mes_ConflictWithNote + ' ' + NotKeyTextInfo(ConflictNK), True);

    for scs := Low(TShortcutSources) to High(TShortcutSources) do
      if Warnings[scs] >= 0 then
        AddMes(Mes_SameWith + ' ' + ShortcutActionTextInfo(
          TShortcutActions(Warnings[scs])), False);

    if WarningNK >= 0 then
      AddMes(Mes_SameWithNote + ' ' + NotKeyTextInfo(WarningNK), False);

    Result := CompleteMesAndAskUser;

    if Result and (ccnt <> 0) then
     begin
      if Conflict >= 0 then
       begin
        CustomShortcuts[TShortcutActions(Conflict)] := 0;
        for i := 0 to SGKeys.RowCount - 1 do
          if {%H-}PtrInt(Pointer(SGKeys.Objects[0, i])) = Conflict then
           begin
            SGKeys.Cells[1, i] := ShortCutToText{Raw}(0){%H-};
            Break;
           end;
       end;
      if ConflictNK >= 0 then
        NoteKeys[ConflictNK] := shortint(NK_NO);
     end;
  end;

  function ValidNoteKey: boolean;
  var
    Key, Warning, ConflictPat, ConflictTst: integer;
  begin
    if NKChooseFrm.LBNKeys.ItemIndex = 0 then //no action marker
      Exit(True);

    Key := {%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top]));

    //Search in pattern editor
    ConflictPat := SearchSameKey(Key, SCS_PatternEditor);

    //Search in test line editor
    ConflictTst := SearchSameKey(Key, SCS_TestLineEditor);

    //Search in globals
    Warning := SearchSameKey(Key, SCS_GlobalActions);

    ccnt := 0;
    wcnt := 0; //conflict and warnigs counters
    mes := '';

    if ConflictPat >= 0 then
      AddMes(Mes_ConflictWith + ' ' + ShortcutActionTextInfo(
        TShortcutActions(ConflictPat)), True);

    if ConflictTst >= 0 then
      AddMes(Mes_ConflictWith + ' ' + ShortcutActionTextInfo(
        TShortcutActions(ConflictTst)), True);

    if Warning >= 0 then
      AddMes(Mes_SameWith + ' ' + ShortcutActionTextInfo(
        TShortcutActions(Warning)), False);

    Result := CompleteMesAndAskUser;

    if Result and (ccnt <> 0) then
     begin
      if ConflictPat >= 0 then
        CustomShortcuts[TShortcutActions(ConflictPat)] := 0;
      if ConflictTst >= 0 then
        CustomShortcuts[TShortcutActions(ConflictTst)] := 0;
     end;
  end;

begin
  if CBKeysSources.ItemIndex < CBKeysSources.Items.Count - 1 then //usual shortcuts
   begin
    CatchSCFrm.Top := Top + (Height - CatchSCFrm.Height) div 2;
    CatchSCFrm.Left := Left + (Width - CatchSCFrm.Width) div 2;
    if (CatchSCFrm.ShowModal = mrOk) and ValidShortcut(CatchedShortcut) then
     begin
      CustomShortcuts[TShortcutActions(
        {%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top])))] :=
        CatchedShortcut;
      SGKeys.Cells[1, SGKeys.Selection.Top] := ShortCutToText{Raw}(CatchedShortcut){%H-};
      if not SGKeys.Focused and SGKeys.CanSetFocus then
        SGKeys.SetFocus;
     end;
   end
  else //note keys
   begin
    NKChooseFrm.Top := Top + (Height - NKChooseFrm.Height) div 2;
    NKChooseFrm.Left := Left + (Width - NKChooseFrm.Width) div 2;
    NKChooseFrm.LBNKeys.ItemIndex :=
      NoteKeys[{%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top]))];
    if (NKChooseFrm.ShowModal = mrOk) and ValidNoteKey then
     begin
      NoteKeys[{%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top]))] :=
        NKChooseFrm.LBNKeys.ItemIndex;
      SGKeys.Cells[1, SGKeys.Selection.Top] :=
        NoteKeyCodesDesc[TNoteKeyCodes(NKChooseFrm.LBNKeys.ItemIndex)];
      if not SGKeys.Focused and SGKeys.CanSetFocus then
        SGKeys.SetFocus;
     end;
   end;
end;

procedure TOptionsDlg.DeleteShortcutOrNoteKey;
begin
  if CBKeysSources.ItemIndex < CBKeysSources.Items.Count - 1 then //usual shortcuts
   begin
    CustomShortcuts[TShortcutActions(
      {%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top])))] := 0;
    SGKeys.Cells[1, SGKeys.Selection.Top] := ShortCutToText{Raw}(0){%H-};
   end
  else //note keys
   begin
    NoteKeys[{%H-}PtrInt(Pointer(SGKeys.Objects[0, SGKeys.Selection.Top]))] :=
      shortint(NK_NO);
    SGKeys.Cells[1, SGKeys.Selection.Top] := NoteKeyCodesDesc[NK_NO];
   end;
  if not SGKeys.Focused and SGKeys.CanSetFocus then
    SGKeys.SetFocus;
end;

procedure TOptionsDlg.BDefineShorcutClick(Sender: TObject);
begin
  CatchShortcutOrNoteKey;
end;

procedure TOptionsDlg.CBBgAllowMIDIChange(Sender: TObject);
begin
  VTOptions.BgAllowMIDI := CBBgAllowMIDI.Checked;
end;

procedure TOptionsDlg.CBcaChange(Sender: TObject);
var
  Bit: integer;
begin
  Bit := 1 shl (Sender as TCheckBox).Tag;
  if (Sender as TCheckBox).Checked then
    VTOptions.ChannelsAllocationCarousel :=
      VTOptions.ChannelsAllocationCarousel or Bit
  else
    VTOptions.ChannelsAllocationCarousel :=
      VTOptions.ChannelsAllocationCarousel and ($7F xor Bit);
end;

procedure TOptionsDlg.UpdateLang;
var
  i: integer;
begin
  i := CBKeysSources.ItemIndex;
  DefaultLang := SetDefaultLang(VTOptions.Lang);
  FillKeySources;
  CBKeysSources.ItemIndex := i;
  FillKeyGrid;
  MainForm.SetMultiShortcuts;
  //LCL rules again: secondary shortcuts in actions are localized ;)
  //mask LCL error (frames are not translated)
  if Assigned(LRSTranslator) and (LRSTranslator is TUpdateTranslator) then
    for i := 0 to MainForm.Childs.Count - 1 do
      (LRSTranslator as TUpdateTranslator).UpdateTranslation(
        TCustomFrame(MainForm.Childs[i]));
  MainForm.UpdateChildHints; //for update some localized dynamic hints
  MainForm.ResizeChilds; //need for reset captions of some buttons
end;

function TOptionsDlg.Get_Language: string;
begin
  if VTOptions.Lang = '' then
    Result := DefaultLang
  else
    Result := VTOptions.Lang;
end;

procedure TOptionsDlg.CBLangEditingDone(Sender: TObject);
var
  NewLang: string;
begin
  if CBLang.Text = CBLang.Items[0] then
    NewLang := ''
  else
    NewLang := CBLang.Text;
  if VTOptions.Lang <> NewLang then
   begin
    VTOptions.Lang := NewLang;
    UpdateLang;
   end;
end;

procedure TOptionsDlg.CBLMBtoDrawChange(Sender: TObject);
begin
  VTOptions.LMBToDraw := CBLMBtoDraw.Checked;
end;

procedure TOptionsDlg.CBOrnAsNoteChange(Sender: TObject);
begin
  VTOptions.OrnAsNote := CBOrnAsNote.Checked;
end;

procedure TOptionsDlg.CBOrnHintChange(Sender: TObject);
begin
  VTOptions.OrnHint := CBOrnHint.Checked;
  MainForm.UpdateChildsOrnamentsHints;
end;

procedure TOptionsDlg.CBSamAsNoteChange(Sender: TObject);
begin
  VTOptions.SamAsNote := CBSamAsNote.Checked;
end;

procedure TOptionsDlg.CBSamHintChange(Sender: TObject);
begin
  VTOptions.SamHint := CBSamHint.Checked;
  MainForm.UpdateChildsSamplesHints;
end;

procedure TOptionsDlg.CBSamOrnHLChange(Sender: TObject);
begin
  VTOptions.SamOrnHLines := CBSamOrnHL.Checked;
  MainForm.InvalidateChildSamples;
  MainForm.InvalidateChildOrnaments;
end;

procedure TOptionsDlg.CBTracksHintChange(Sender: TObject);
begin
  VTOptions.TracksHint := CBTracksHint.Checked;
  MainForm.UpdateChildsTracksHints;
end;

procedure TOptionsDlg.CBNotWarnUndoChange(Sender: TObject);
begin
  VTOptions.NotWarnUndo := CBNotWarnUndo.Checked;
end;

procedure TOptionsDlg.BDeleteShortcutClick(Sender: TObject);
begin
  DeleteShortcutOrNoteKey;
end;

procedure TOptionsDlg.ChipSelClick(Sender: TObject);
begin
  MainForm.SetEmulatingChip(TChipTypes(ChipSel.ItemIndex + 1));
end;

procedure TOptionsDlg.FillKeySources;
var
  scs: TShortcutSources;
begin
  CBKeysSources.Clear;
  for scs := Low(TShortcutSources) to High(TShortcutSources) do
    CBKeysSources.Items.Add(ShortcutSourcesDesc[scs]);
  CBKeysSources.Items.Add(Mes_NoteKeys);
  CBKeysSources.ItemIndex := 0;
end;

procedure TOptionsDlg.FormCreate(Sender: TObject);
begin
  FillKeySources;
  with SGKeys do
    ColWidths[0] := ClientWidth - ColWidths[1] - 4 - GetSystemMetrics(SM_CXVSCROLL);
  UDAutStpVal.Max := MaxPatLen;
  UDAutStpVal.Min := -MaxPatLen;
  LoadLanguages;
end;

procedure TOptionsDlg.LbOrnamentsFontMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseFont(VTOptions.OrnamentsFont, LbOrnamentsFont, ssShift in Shift) then
    if ssShift in Shift then
     begin
      ChooseFont(VTOptions.TracksFont, LbTracksFont, True, @VTOptions.OrnamentsFont);
      ChooseFont(VTOptions.SamplesFont, LbSamplesFont, True, @VTOptions.OrnamentsFont);
      ChooseFont(VTOptions.TestsFont, LbTestsFont, False, @VTOptions.OrnamentsFont);
     end;
end;

procedure TOptionsDlg.LbSamplesFontMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseFont(VTOptions.SamplesFont, LbSamplesFont, ssShift in Shift) then
    if ssShift in Shift then
     begin
      ChooseFont(VTOptions.TracksFont, LbTracksFont, True, @VTOptions.SamplesFont);
      ChooseFont(VTOptions.OrnamentsFont, LbOrnamentsFont, True, @VTOptions.SamplesFont);
      ChooseFont(VTOptions.TestsFont, LbTestsFont, False, @VTOptions.SamplesFont);
     end;
end;

procedure TOptionsDlg.LbTestsFontMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseFont(VTOptions.TestsFont, LbTestsFont, ssShift in Shift) then
    if ssShift in Shift then
     begin
      ChooseFont(VTOptions.TracksFont, LbTracksFont, True, @VTOptions.TestsFont);
      ChooseFont(VTOptions.SamplesFont, LbSamplesFont, True, @VTOptions.TestsFont);
      ChooseFont(VTOptions.OrnamentsFont, LbOrnamentsFont, False, @VTOptions.TestsFont);
     end;
end;

procedure TOptionsDlg.LbTracksFontMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseFont(VTOptions.TracksFont, LbTracksFont, ssShift in Shift) then
    if ssShift in Shift then
     begin
      ChooseFont(VTOptions.SamplesFont, LbSamplesFont, True, @VTOptions.TracksFont);
      ChooseFont(VTOptions.OrnamentsFont, LbOrnamentsFont, True, @VTOptions.TracksFont);
      ChooseFont(VTOptions.TestsFont, LbTestsFont, False, @VTOptions.TracksFont);
     end;
end;

procedure TOptionsDlg.LoadLanguages;
var
  SearchRec: TSearchRec;
  i, j: integer;
  Dir, s: string;
  unique: boolean;
begin
  CBLang.Clear;
  CBLang.Items.Append('auto/en');
  CBLang.Items.Append('en');
  Dir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'languages' + DirectorySeparator;
  if not DirectoryExists(Dir, False{todo: fpc bug: FP can't expand relative links}) then
    Exit;
  i := FindFirst(Dir + '*.po', faAnyFile, SearchRec);
  while i = 0 do
   begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      if SearchRec.Attr and faDirectory = 0 then
        if SearchRec.Size > 0 then
         begin
          i := Length(SearchRec.Name) - 3;
          s := Copy(SearchRec.Name, 1, i);
          while (i > 0) and (s[i] <> '.') do
            Dec(i);
          if i > 0 then
           begin
            s := Copy(s, i + 1, Length(s));
            unique := True;
            for j := 1 to CBLang.Items.Count - 1 do
              if CBLang.Items[j] = s then
               begin
                unique := False;
                Break;
               end;
            if unique then
              CBLang.Items.Append(s);
           end;
         end;
    i := FindNext(SearchRec);
   end;
  FindClose(SearchRec);
end;

procedure TOptionsDlg.IntSelClick(Sender: TObject);
var
  f: integer;
begin
  case IntSel.ItemIndex of
    0: f := 50000;
    1: f := 48828;
    2: f := 60000;
    3: f := 100000;
    4: f := 200000;
    5:
     begin
      if not EdIntFrq.Focused and EdIntFrq.CanSetFocus then
       begin
        EdIntFrq.SelectAll;
        EdIntFrq.SetFocus;
       end;
      f := GetValue(EdIntFrq.Text);
      if f < 0 then exit;
     end;
    else
      Exit;
   end;
  if f <> VTOptions.Interrupt_Freq then
    MainForm.SetIntFreqEx(f);
end;

procedure TOptionsDlg.ShowFont(aFont: TVTFont; aHolder: TGraphicControl);
var
  bgColor, txtColor: TColor;
begin
  aHolder.Font.Name := aFont.Name;
  aHolder.Font.Size := aFont.Size;
  if aFont.Bold then
    aHolder.Font.Style := [fsBold]
  else
    aHolder.Font.Style := [];
  if aHolder = LbSamplesFont then
   begin
    bgColor := VTOptions.SamplesColorBg;
    txtColor := VTOptions.SamplesColorTxt;
   end
  else if aHolder = LbOrnamentsFont then
   begin
    bgColor := VTOptions.OrnamentsColorBg;
    txtColor := VTOptions.OrnamentsColorTxt;
   end
  else if aHolder = LbTestsFont then
   begin
    bgColor := VTOptions.TestsColorBg;
    txtColor := VTOptions.TestsColorTxt;
   end
  else
   begin
    bgColor := VTOptions.TracksColorBg;
    txtColor := VTOptions.TracksColorTxt;
   end;
  aHolder.Font.Color := txtColor;
  aHolder.Color := bgColor;
end;

function TOptionsDlg.ChooseFont(var aFont: TVTFont; aHolder: TGraphicControl;
  NoResize: boolean; aFontForce: PVTFont = nil): boolean;
begin
  if aFontForce <> nil then
    aFont := aFontForce^
  else if CanChooseColorOrFont(aHolder) then
    with FontDialog1 do
     begin
      Font.Name := aFont.Name;
      Font.Size := aFont.Size;
      if aFont.Bold then
        Font.Style := [fsBold]
      else
        Font.Style := [];
      if not Execute then
        Exit(False);
      aFont.Name := Font.Name;
      aFont.Size := Font.Size;
      aFont.Bold := fsBold in Font.Style;
     end
  else
    Exit(False);
  ShowFont(aFont, aHolder);
  Result := True;
  if NoResize then
    Exit;
  MainForm.ResizeChilds;
end;

procedure TOptionsDlg.ShowColor(aColor: TColor; aColorHolder: TGraphicControl);
begin
  (aColorHolder as TShape).Brush.Color := aColor;
end;

procedure TOptionsDlg.OpsPagesChange(Sender: TObject);
begin
  if OpsPages.ActivePage = KeysTab then
    //force focus to accept SGKeys local hotkeys "Enter" and "Delete"
    if not SGKeys.Focused and SGKeys.CanSetFocus then
      SGKeys.SetFocus;
end;

procedure TOptionsDlg.FeatLevelClick(Sender: TObject);
begin
  FeaturesLevel := FeatLevel.ItemIndex;
  VTOptions.DetectFeaturesLevel := FeaturesLevel > 2;
  if VTOptions.DetectFeaturesLevel then
    FeaturesLevel := 1;
end;

procedure TOptionsDlg.RBcaClick(Sender: TObject);
begin
  if VTOptions.ChannelsAllocation <> (Sender as TRadioButton).Tag then
    MainForm.SetChannelsAllocation((Sender as TRadioButton).Tag);
end;

procedure TOptionsDlg.SGKeysKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  case Key of
    VK_DELETE:
     begin
      DeleteShortcutOrNoteKey;
      Key := 0;
     end;
    VK_RETURN:
     begin
      CatchShortcutOrNoteKey;
      Key := 0;
     end;
    VK_ESCAPE://TStringGrid "eats" it, so Cancel button does not work
     begin
      ModalResult := mrCancel;
      Key := 0;
     end;
   end;
end;

procedure TOptionsDlg.GraphicControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  //to emulate OnClick via OnMouseUp and get ssShift state
  if Button = mbLeft then (Sender as TGraphicControl).Tag := -1;
end;

procedure TOptionsDlg.ShGlobalBgEmptyMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColor(VTOptions.GlobalColorBgEmpty, Sender as TShape) then
   begin
    //empty space can be in ornaments (if small font or big window)
    //and (in theory) in samples
    MainForm.InvalidateChildSamples;
    MainForm.InvalidateChildOrnaments;

    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBgBeyond, ShTracksBgBynd,
        @VTOptions.GlobalColorBgEmpty);
      ChooseColorSamples(VTOptions.SamplesColorBgBeyond, ShSamplesBgBynd,
        @VTOptions.GlobalColorBgEmpty);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgBeyond,
        ShOrnamentsBgBynd, @VTOptions.GlobalColorBgEmpty);
     end;
   end;
end;

procedure TOptionsDlg.ShGlobalWorkspaceMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColor(VTOptions.GlobalColorWorkspace, Sender as TShape) then
    MainForm.Workspace.Color := VTOptions.GlobalColorWorkspace;
end;

procedure TOptionsDlg.ShOrnamentsBgBeyondHlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorBgBeyondHl, Sender as TShape) then
    if ssShift in Shift then
      ChooseColorSamples(VTOptions.SamplesColorBgBeyondHl, ShSamplesBgBeyondHl,
        @VTOptions.OrnamentsColorBgBeyondHl);
end;

procedure TOptionsDlg.ShOrnamentsBgByndMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorBgBeyond, Sender as TShape) then
    if ssShift in Shift then
     begin
      SetupColors(VTOptions.GlobalColorBgEmpty, ShGlobalBgEmpty,
        @VTOptions.OrnamentsColorBgBeyond);
      ChooseColorTracks(VTOptions.TracksColorBgBeyond, ShTracksBgBynd,
        @VTOptions.GlobalColorBgEmpty);
      ChooseColorSamples(VTOptions.SamplesColorBgBeyond, ShSamplesBgBynd,
        @VTOptions.GlobalColorBgEmpty);
     end;
end;

procedure TOptionsDlg.ShOrnamentsBgHlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorBgHl, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBgHl, ShTracksBgHl,
        @VTOptions.OrnamentsColorBgHl);
      ChooseColorSamples(VTOptions.SamplesColorBgHl, ShSamplesBgHl,
        @VTOptions.OrnamentsColorBgHl);
     end;
end;

procedure TOptionsDlg.ShOrnamentsBgLpHlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorBgLpHl, Sender as TShape) then
    if ssShift in Shift then
      ChooseColorSamples(VTOptions.SamplesColorBgLpHl, ShSamplesBgLpHl,
        @VTOptions.OrnamentsColorBgLpHl);
end;

procedure TOptionsDlg.ShOrnamentsBgLpMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorBgLp, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBgHlMain, ShTracksBgHlMain,
        @VTOptions.OrnamentsColorBgLp);
      ChooseColorSamples(VTOptions.SamplesColorBgLp, ShSamplesBgLp,
        @VTOptions.OrnamentsColorBgLp);
     end;
end;

procedure TOptionsDlg.ShOrnamentsBgMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorBg, Sender as
    TShape, nil, @LbOrnamentsFont.Color) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBg, ShTracksBg,
        @VTOptions.OrnamentsColorBg, @LbTracksFont.Color);
      ChooseColorSamples(VTOptions.SamplesColorBg, ShSamplesBg,
        @VTOptions.OrnamentsColorBg, @LbSamplesFont.Color);
      ChooseColorTests(VTOptions.TestsColorBg, ShTestsBg,
        @VTOptions.OrnamentsColorBg, @LbTestsFont.Color);
     end;
end;

procedure TOptionsDlg.ShOrnamentsTxtByndMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorTxtBeyond, Sender as TShape) then
    if ssShift in Shift then
      ChooseColorSamples(VTOptions.SamplesColorTxtBeyond, ShSamplesTxtBynd,
        @VTOptions.OrnamentsColorTxtBeyond);
end;

procedure TOptionsDlg.ShOrnamentsTxtLpMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorTxtLp, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorTxtHlMain, ShTracksTxtHlMain,
        @VTOptions.OrnamentsColorTxtLp);
      ChooseColorSamples(VTOptions.SamplesColorTxtLp, ShSamplesTxtLp,
        @VTOptions.OrnamentsColorTxtLp);
     end;
end;

procedure TOptionsDlg.ShOrnamentsTxtMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorOrnaments(VTOptions.OrnamentsColorTxt, Sender as
    TShape, nil, @LbOrnamentsFont.Font.Color) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorTxt, ShTracksTxt,
        @VTOptions.OrnamentsColorTxt, @LbTracksFont.Font.Color);
      ChooseColorSamples(VTOptions.SamplesColorTxt, ShSamplesTxt,
        @VTOptions.OrnamentsColorTxt, @LbSamplesFont.Font.Color);
      ChooseColorTests(VTOptions.TestsColorTxt, ShTestsTxt,
        @VTOptions.OrnamentsColorTxt, @LbTestsFont.Font.Color);
     end;
end;

procedure TOptionsDlg.ShSamplesBgBeyondHlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorBgBeyondHl, Sender as TShape) then
    if ssShift in Shift then
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgBeyondHl,
        ShOrnamentsBgBeyondHl, @VTOptions.SamplesColorBgBeyondHl);
end;

procedure TOptionsDlg.ShSamplesBgByndMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorBgBeyond, Sender as TShape) then
    if ssShift in Shift then
     begin
      SetupColors(VTOptions.GlobalColorBgEmpty, ShGlobalBgEmpty,
        @VTOptions.SamplesColorBgBeyond);
      ChooseColorTracks(VTOptions.TracksColorBgBeyond, ShTracksBgBynd,
        @VTOptions.GlobalColorBgEmpty);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgBeyond,
        ShOrnamentsBgBynd, @VTOptions.GlobalColorBgEmpty);
     end;
end;

procedure TOptionsDlg.ShSamplesBgHlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorBgHl, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBgHl, ShTracksBgHl,
        @VTOptions.SamplesColorBgHl);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgHl, ShOrnamentsBgHl,
        @VTOptions.SamplesColorBgHl);
     end;
end;

procedure TOptionsDlg.ShSamplesBgLpHlMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorBgLpHl, Sender as TShape) then
    if ssShift in Shift then
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgLpHl, ShOrnamentsBgLpHl,
        @VTOptions.SamplesColorBgLpHl);
end;

procedure TOptionsDlg.ShSamplesBgLpMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorBgLp, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBgHlMain, ShTracksBgHlMain,
        @VTOptions.SamplesColorBgLp);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgLp, ShOrnamentsBgLp,
        @VTOptions.SamplesColorBgLp);
     end;
end;

procedure TOptionsDlg.ShSamplesBgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorBg, Sender as TShape,
    nil, @LbSamplesFont.Color) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBg, ShTracksBg,
        @VTOptions.SamplesColorBg, @LbTracksFont.Color);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBg, ShOrnamentsBg,
        @VTOptions.SamplesColorBg, @LbOrnamentsFont.Color);
      ChooseColorTests(VTOptions.TestsColorBg, ShTestsBg,
        @VTOptions.SamplesColorBg, @LbTestsFont.Color);
     end;
end;

procedure TOptionsDlg.ShSamplesTxtByndMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorTxtBeyond, Sender as TShape) then
    if ssShift in Shift then
      ChooseColorOrnaments(VTOptions.OrnamentsColorTxtBeyond,
        ShOrnamentsTxtBynd, @VTOptions.SamplesColorTxtBeyond);
end;

procedure TOptionsDlg.ShSamplesTxtLpMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorTxtLp, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorTxtHlMain, ShTracksTxtHlMain,
        @VTOptions.SamplesColorTxtLp);
      ChooseColorOrnaments(VTOptions.OrnamentsColorTxtLp, ShOrnamentsTxtLp,
        @VTOptions.SamplesColorTxtLp);
     end;
end;

procedure TOptionsDlg.ShSamplesTxtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorSamples(VTOptions.SamplesColorTxt, Sender as TShape,
    nil, @LbSamplesFont.Font.Color) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorTxt, ShTracksTxt,
        @VTOptions.SamplesColorTxt, @LbTracksFont.Font.Color);
      ChooseColorOrnaments(VTOptions.OrnamentsColorTxt, ShOrnamentsTxt,
        @VTOptions.SamplesColorTxt, @LbOrnamentsFont.Font.Color);
      ChooseColorTests(VTOptions.TestsColorTxt, ShTestsTxt,
        @VTOptions.SamplesColorTxt, @LbTestsFont.Font.Color);
     end;
end;

procedure TOptionsDlg.ShTestsBgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTests(VTOptions.TestsColorBg, Sender as TShape, nil,
    @LbTestsFont.Color) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorBg, ShTracksBg,
        @VTOptions.TestsColorBg, @LbTracksFont.Color);
      ChooseColorSamples(VTOptions.SamplesColorBg, ShSamplesBg,
        @VTOptions.TestsColorBg, @LbSamplesFont.Color);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBg, ShOrnamentsBg,
        @VTOptions.TestsColorBg, @LbOrnamentsFont.Color);
     end;
end;

procedure TOptionsDlg.ShTestsTxtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTests(VTOptions.TestsColorTxt, Sender as TShape,
    nil, @LbTestsFont.Font.Color) then
    if ssShift in Shift then
     begin
      ChooseColorTracks(VTOptions.TracksColorTxt, ShTracksTxt,
        @VTOptions.TestsColorTxt, @LbTracksFont.Font.Color);
      ChooseColorSamples(VTOptions.SamplesColorTxt, ShSamplesTxt,
        @VTOptions.TestsColorTxt, @LbSamplesFont.Font.Color);
      ChooseColorOrnaments(VTOptions.OrnamentsColorTxt, ShOrnamentsTxt,
        @VTOptions.TestsColorTxt, @LbOrnamentsFont.Font.Color);
     end;
end;

procedure TOptionsDlg.ShTracksBgByndMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTracks(VTOptions.TracksColorBgBeyond, Sender as TShape) then
    if ssShift in Shift then
     begin
      SetupColors(VTOptions.GlobalColorBgEmpty, ShGlobalBgEmpty,
        @VTOptions.TracksColorBgBeyond);
      ChooseColorSamples(VTOptions.SamplesColorBgBeyond, ShSamplesBgBynd,
        @VTOptions.GlobalColorBgEmpty);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgBeyond,
        ShOrnamentsBgBynd, @VTOptions.GlobalColorBgEmpty);
     end;
end;

procedure TOptionsDlg.ShTracksBgHlMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTracks(VTOptions.TracksColorBgHlMain, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorSamples(VTOptions.SamplesColorBgLp, ShSamplesBgLp,
        @VTOptions.TracksColorBgHlMain);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgLp, ShOrnamentsBgLp,
        @VTOptions.TracksColorBgHlMain);
     end;
end;

procedure TOptionsDlg.ShTracksBgHlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTracks(VTOptions.TracksColorBgHl, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorSamples(VTOptions.SamplesColorBgHl, ShSamplesBgHl,
        @VTOptions.TracksColorBgHl);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBgHl, ShOrnamentsBgHl,
        @VTOptions.TracksColorBgHl);
     end;
end;

procedure TOptionsDlg.ShTracksBgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTracks(VTOptions.TracksColorBg, Sender as TShape, nil,
    @LbTracksFont.Color) then
    if ssShift in Shift then
     begin
      ChooseColorSamples(VTOptions.SamplesColorBg, ShSamplesBg,
        @VTOptions.TracksColorBg, @LbSamplesFont.Color);
      ChooseColorOrnaments(VTOptions.OrnamentsColorBg, ShOrnamentsBg,
        @VTOptions.TracksColorBg, @LbOrnamentsFont.Color);
      ChooseColorTests(VTOptions.TestsColorBg, ShTestsBg,
        @VTOptions.TracksColorBg, @LbTestsFont.Color);
     end;
end;

procedure TOptionsDlg.ShTracksTxtHlMainMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTracks(VTOptions.TracksColorTxtHlMain, Sender as TShape) then
    if ssShift in Shift then
     begin
      ChooseColorSamples(VTOptions.SamplesColorTxtLp, ShSamplesTxtLp,
        @VTOptions.TracksColorTxtHlMain);
      ChooseColorOrnaments(VTOptions.OrnamentsColorTxtLp, ShOrnamentsTxtLp,
        @VTOptions.TracksColorTxtHlMain);
     end;
end;

procedure TOptionsDlg.ShTracksTxtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if ChooseColorTracks(VTOptions.TracksColorTxt, Sender as TShape,
    nil, @LbTracksFont.Font.Color) then
    if ssShift in Shift then
     begin
      ChooseColorSamples(VTOptions.SamplesColorTxt, ShSamplesTxt,
        @VTOptions.TracksColorTxt, @LbSamplesFont.Font.Color);
      ChooseColorOrnaments(VTOptions.OrnamentsColorTxt, ShOrnamentsTxt,
        @VTOptions.TracksColorTxt, @LbOrnamentsFont.Font.Color);
      ChooseColorTests(VTOptions.TestsColorTxt, ShTestsTxt,
        @VTOptions.TracksColorTxt, @LbTestsFont.Font.Color);
     end;
end;

procedure TOptionsDlg.TBBufLenChange(Sender: TObject);
begin
  SetBuffers(TBBufLen.Position, NumberOfBuffers);
  LbBufLn.Caption := IntToStr(BufLen_ms) + ' ' + Mes_ms;
  LbTotLn.Caption := IntToStr(BufLen_ms * NumberOfBuffers) + ' ' + Mes_ms;
  LBChg.Caption := LbTotLn.Caption;
end;

procedure TOptionsDlg.TBBufNumChange(Sender: TObject);
begin
  SetBuffers(BufLen_ms, TBBufNum.Position);
  LBNum.Caption := IntToStr(NumberOfBuffers);
  LbTotLn.Caption := IntToStr(BufLen_ms * NumberOfBuffers) + ' ' + Mes_ms;
  LBChg.Caption := LbTotLn.Caption;
end;

procedure TOptionsDlg.SRClick(Sender: TObject);
begin
  case SR.ItemIndex of
    0: Set_Sample_Rate(11025);
    1: Set_Sample_Rate(22050);
    2: Set_Sample_Rate(44100);
    3: Set_Sample_Rate(48000);
    4: Set_Sample_Rate(96000);
    5: Set_Sample_Rate(192000);
   end;
  LbFIRk.Caption := FiltInfo;
end;

procedure TOptionsDlg.BRClick(Sender: TObject);
begin
  case BR.ItemIndex of
    0: Set_Sample_Bit(8);
    1: Set_Sample_Bit(16);
   end;
end;

procedure TOptionsDlg.NChClick(Sender: TObject);
begin
  Set_Stereo(NCh.ItemIndex + 1);
end;

procedure TOptionsDlg.PlayStarts;
begin
  SR.Enabled := False;
  BR.Enabled := False;
  NCh.Enabled := False;
  Buff.Enabled := False;
  LbNotice.Visible := True;
  LBChg.Visible := True;
  SelDev.Enabled := False;
end;

procedure TOptionsDlg.PlayStops;
begin
  SR.Enabled := True;
  BR.Enabled := True;
  NCh.Enabled := True;
  Buff.Enabled := True;
  LbNotice.Visible := False;
  LBChg.Visible := False;
  SelDev.Enabled := True;
end;

procedure TOptionsDlg.ResampClick(Sender: TObject);
begin
  SetFilter(Resamp.ItemIndex <> 0);
  LbFIRk.Caption := FiltInfo;
end;

procedure TOptionsDlg.ChFreqClick(Sender: TObject);
var
  f: integer;
begin
  case ChFreq.ItemIndex of
    0: f := 1773400;
    1: f := 1750000;
    2: f := 2000000;
    3: f := 1000000;
    4: f := 3500000;
    5:
     begin
      if not EdChipFrq.Focused and EdChipFrq.CanSetFocus then
       begin
        EdChipFrq.SelectAll;
        EdChipFrq.SetFocus;
       end;
      f := GetValue(EdChipFrq.Text);
      if f < 0 then
        Exit;
     end;
    else
      Exit;
   end;
  if f <> VTOptions.AY_Freq then
    Set_Chip_Frq(f);
  LbFIRk.Caption := FiltInfo;
end;

procedure TOptionsDlg.CBDeviceChange(Sender: TObject);
begin
  Set_WODevice(CBDevice.ItemIndex, CBDevice.Items[CBDevice.ItemIndex]);
end;

procedure TOptionsDlg.SaveHeadClick(Sender: TObject);
begin
  VortexModuleHeader := SaveHead.ItemIndex <> 1;
  VTOptions.DetectModuleHeader := SaveHead.ItemIndex = 2;
end;

procedure TOptionsDlg.FormShow(Sender: TObject);
begin
  OpsPages.SetFocus;
  FillKeyGrid;
end;

procedure TOptionsDlg.PriorGrpClick(Sender: TObject);
begin
  {$IFDEF Windows}
 if PriorGrp.ItemIndex = 0 then
   MainForm.SetPriority(NORMAL_PRIORITY_CLASS)
 else
   MainForm.SetPriority(HIGH_PRIORITY_CLASS);
  {$ELSE Windows}
  NonWin;
  {$ENDIF Windows}
end;

procedure TOptionsDlg.EdChipFrqExit(Sender: TObject);
begin
  if ChFreq.ItemIndex <> 5 then
    ChFreq.ItemIndex := 5
  else
    ChFreqClick(Sender);
end;

procedure TOptionsDlg.EdIntFrqExit(Sender: TObject);
begin
  if IntSel.ItemIndex <> 5 then
    IntSel.ItemIndex := 5
  else
    IntSelClick(Sender);
end;

function TOptionsDlg.ChooseColor(var aColor: TColor): boolean;
begin
  ColorDialog1.Color := aColor;
  Result := ColorDialog1.Execute;
  if Result then
    aColor := ColorDialog1.Color;
end;

function TOptionsDlg.CanChooseColorOrFont(aHolder: TGraphicControl): boolean;
begin
  Result := aHolder.Tag <> 0;
  aHolder.Tag := 0;
end;

function TOptionsDlg.ChooseColor(var aColor: TColor;
  aColorHolder: TGraphicControl): boolean;
begin
  Result := CanChooseColorOrFont(aColorHolder);
  if not Result then
    Exit;
  Result := ChooseColor(aColor);
  if Result then
    ShowColor(aColor, aColorHolder);
end;

function TOptionsDlg.SetupColors(var aColor: TColor; aColorHolder: TGraphicControl;
  aColorForce: PColor; aColorHint: PColor = nil): boolean;
begin
  if aColorForce <> nil then
   begin
    aColor := aColorForce^;
    ShowColor(aColor, aColorHolder);
   end
  else if not ChooseColor(aColor, aColorHolder) then
    Exit(False);
  if aColorHint <> nil then
    aColorHint^ := aColor;
  Result := True;
end;

function TOptionsDlg.ChooseColorTracks(var aColor: TColor;
  aColorHolder: TGraphicControl; aColorForce: PColor = nil;
  aColorHint: PColor = nil): boolean;
begin
  Result := SetupColors(aColor, aColorHolder, aColorForce, aColorHint);
  if Result then
    MainForm.InvalidateChildTracks;
end;

function TOptionsDlg.ChooseColorSamples(var aColor: TColor;
  aColorHolder: TGraphicControl; aColorForce: PColor = nil;
  aColorHint: PColor = nil): boolean;
begin
  Result := SetupColors(aColor, aColorHolder, aColorForce, aColorHint);
  if Result then
    MainForm.InvalidateChildSamples;
end;

function TOptionsDlg.ChooseColorOrnaments(var aColor: TColor;
  aColorHolder: TGraphicControl; aColorForce: PColor = nil;
  aColorHint: PColor = nil): boolean;
begin
  Result := SetupColors(aColor, aColorHolder, aColorForce, aColorHint);
  if Result then
    MainForm.InvalidateChildOrnaments;
end;

function TOptionsDlg.ChooseColorTests(var aColor: TColor;
  aColorHolder: TGraphicControl; aColorForce: PColor = nil;
  aColorHint: PColor = nil): boolean;
begin
  Result := SetupColors(aColor, aColorHolder, aColorForce, aColorHint);
  if Result then
    MainForm.InvalidateChildTests;
end;

procedure TOptionsDlg.UDAutStpValChangingEx(Sender: TObject;
  var AllowChange: boolean; NewValue: smallint; Direction: TUpDownDirection);
begin
  AllowChange := (NewValue >= -MaxPatLen) and (NewValue <= MaxPatLen);
  if AllowChange then
    VTOptions.AutoStepValue := NewValue;
end;

procedure TOptionsDlg.UDNoteTblChangingEx(Sender: TObject;
  var AllowChange: boolean; NewValue: smallint; Direction: TUpDownDirection);
begin
  AllowChange := NewValue in [0..3];
  if AllowChange then
    VTOptions.NoteTable := NewValue;
end;

procedure TOptionsDlg.UDNumLinesChangingEx(Sender: TObject;
  var AllowChange: boolean; NewValue: smallint; Direction: TUpDownDirection);
begin
  AllowChange := NewValue in [3..DefPatLen];
  if AllowChange then
    VTOptions.TracksNOfLines := NewValue;
end;

end.
