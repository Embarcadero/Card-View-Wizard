unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Layouts, FMX.Controls.Presentation,
  FMX.Objects, FMX.VirtualKeyboard, FMX.Platform, uCardFrame, System.Actions,
  FMX.ActnList;

type
  TMainForm = class(TForm)
    WizardTabControl: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    GestureManager1: TGestureManager;
    StellarStyleBook: TStyleBook;
    FrameCard1: TFrameCard;
    FrameCard2: TFrameCard;
    FrameCard3: TFrameCard;
    FrameCard4: TFrameCard;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    procedure FormCreate(Sender: TObject);
    procedure WizardTabControlChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  const
    WIZARD_TITLE_1 = 'Time for a Break?';
    WIZARD_TEXT_1 = 'Find your next destination. Locate the best place for a vacation.';
    WIZARD_TITLE_2 = 'Buy a Ticket';
    WIZARD_TEXT_2 = 'Get the perfect date, time, and select the right transportation.';
    WIZARD_TITLE_3 = 'Jump on the Train';
    WIZARD_TEXT_3 = 'Fast and safe rail travel can get you there. Luxury seats and dining.';
    WIZARD_TITLE_4 = 'Hit the Beach';
    WIZARD_TEXT_4 = 'Spend some time at the beach, take a photo, and enjoy your vacation!';
    WIZARD_NEXT_BUTTON_4 = 'Get Started';

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

{$DEFINE FIRSTSET}
//{$DEFINE SECONDSET}
//{$DEFINE THIRDSET}

procedure TMainForm.FormCreate(Sender: TObject);
begin

{$IFDEF FIRSTSET}
  // first set
  FrameCard1.SetCardTitle(WIZARD_TITLE_1);
  FrameCard1.SetCardText(WIZARD_TEXT_1);
  FrameCard1.ConfigureCard(TCardButton.Inner, TCardBGImage.Inner, TCardLayout.TextImage);

  FrameCard2.SetCardTitle(WIZARD_TITLE_2);
  FrameCard2.SetCardText(WIZARD_TEXT_2);
  FrameCard2.ConfigureCard(TCardButton.Inner, TCardBGImage.Inner, TCardLayout.TextImage);

  FrameCard3.SetCardTitle(WIZARD_TITLE_3);
  FrameCard3.SetCardText(WIZARD_TEXT_3);
  FrameCard3.ConfigureCard(TCardButton.Inner, TCardBGImage.Inner, TCardLayout.TextImage);

  FrameCard4.SetCardTitle(WIZARD_TITLE_4);
  FrameCard4.SetCardText(WIZARD_TEXT_4);
  FrameCard4.SetNextButtonText(WIZARD_NEXT_BUTTON_4);
  FrameCard4.ConfigureCard(TCardButton.Inner, TCardBGImage.Inner, TCardLayout.TextImage);
{$ENDIF}

{$IFDEF SECONDSET}
 // second set
  FrameCard1.SetCardTitle(WIZARD_TITLE_1);
  FrameCard1.SetCardText(WIZARD_TEXT_1);
  FrameCard1.ConfigureCard(TCardButton.Outer, TCardBGImage.None, TCardLayout.ImageText);
  FrameCard1.SetNextButtonTextColor(TAlphaColorRec.White);

  FrameCard2.SetCardTitle(WIZARD_TITLE_2);
  FrameCard2.SetCardText(WIZARD_TEXT_2);
  FrameCard2.ConfigureCard(TCardButton.Outer, TCardBGImage.None, TCardLayout.ImageText);
  FrameCard2.SetNextButtonTextColor(TAlphaColorRec.White);

  FrameCard3.SetCardTitle(WIZARD_TITLE_3);
  FrameCard3.SetCardText(WIZARD_TEXT_3);
  FrameCard3.ConfigureCard(TCardButton.Outer, TCardBGImage.None, TCardLayout.ImageText);
  FrameCard3.SetNextButtonTextColor(TAlphaColorRec.White);

  FrameCard4.SetCardTitle(WIZARD_TITLE_4);
  FrameCard4.SetCardText(WIZARD_TEXT_4);
  FrameCard4.SetNextButtonText(WIZARD_NEXT_BUTTON_4);
  FrameCard4.ConfigureCard(TCardButton.Outer, TCardBGImage.None, TCardLayout.ImageText);
  FrameCard4.SetNextButtonTextColor(TAlphaColorRec.White);
{$ENDIF}

{$IFDEF THIRDSET}
  // third Set
  FrameCard1.SetCardTitle(WIZARD_TITLE_1);
  FrameCard1.SetCardText(WIZARD_TEXT_1);
  FrameCard1.ConfigureCard(TCardButton.Inner, TCardBGImage.Outer, TCardLayout.TextImage);

  FrameCard2.SetCardTitle(WIZARD_TITLE_2);
  FrameCard2.SetCardText(WIZARD_TEXT_2);
  FrameCard2.ConfigureCard(TCardButton.Inner, TCardBGImage.Outer, TCardLayout.TextImage);

  FrameCard3.SetCardTitle(WIZARD_TITLE_3);
  FrameCard3.SetCardText(WIZARD_TEXT_3);
  FrameCard3.ConfigureCard(TCardButton.Inner, TCardBGImage.Outer, TCardLayout.TextImage);

  FrameCard4.SetCardTitle(WIZARD_TITLE_4);
  FrameCard4.SetCardText(WIZARD_TEXT_4);
  FrameCard4.SetNextButtonText(WIZARD_NEXT_BUTTON_4);
  FrameCard4.ConfigureCard(TCardButton.Inner, TCardBGImage.Outer, TCardLayout.TextImage);
{$ENDIF}

  WizardTabControlChange(Sender);
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
  FService : IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
      begin
        // do nothing
      end
    else
      begin
        if WizardTabControl.ActiveTab <> TabItem1 then
          begin
            WizardTabControl.SetActiveTabWithTransitionAsync(WizardTabControl.Tabs[WizardTabControl.TabIndex-1],TTabTransition.Slide,TTabTransitionDirection.Reversed,nil);
            Key := 0;
          end;
      end;
  end
end;

procedure TMainForm.WizardTabControlChange(Sender: TObject);
var
I: Integer;
begin
  for I := 0 to WizardTabControl.TabCount-1 do
    begin
      if TTabItem(WizardTabControl.Tabs[I]).TagObject is TRectangle then
        begin
          TButton(TTabItem(WizardTabControl.Tabs[I]).TagObject).Visible := False;
        end;
    end;
  if WizardTabControl.TabIndex>-1 then
    if WizardTabControl.ActiveTab.TagObject is TRectangle then
      begin
        TButton(WizardTabControl.ActiveTab.TagObject).Visible := True;
      end;
end;

end.
