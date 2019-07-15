unit uCardFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FMX.TabControl,
  System.ImageList, FMX.ImgList, FMX.Effects, FMX.Filter.Effects, System.UIConsts,
  FMX.Ani, System.Math, FMX.Platform;

type
  TCardButton = record
    const
      None = 0;
      Inner = 1;
      Outer = 2;
  end;
  TCardBGImage = record
    const
      None = 0;
      Inner = 1;
      Outer = 2;
      InnerAndOuter = 3;
  end;
  TCardLayout = record
    const
      TextImage = 0;
      ImageText = 1;
  end;
  TFrameCard = class(TFrame)
    BackgroundImage: TImage;
    BackgroundRect: TRectangle;
    CardRect: TRectangle;
    CardBackgroundImage: TImage;
    CardLayout: TLayout;
    CardTitleLabel: TLabel;
    CardTextLabel: TLabel;
    CardImage: TImage;
    TextLayout: TLayout;
    CardNextRectBTN: TRectangle;
    CardNextLabel: TLabel;
    FooterNextRectBTN: TRectangle;
    FillCardRGBEffect: TFillRGBEffect;
    FooterNextLabel: TLabel;
    CircleMD: TCircle;
    FloatAnimationMD: TFloatAnimation;
    procedure CardNextRectBTNClick(Sender: TObject);
    procedure FloatAnimationMDFinish(Sender: TObject);
    procedure FloatAnimationMDProcess(Sender: TObject);
    procedure CardNextRectBTNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FooterNextRectBTNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
    FX,FY: Single;
    FAccentColor: TAlphaColor;
    FAccentColorSet: Boolean;
    procedure MaterialDesignMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  public
    { Public declarations }
    procedure ConfigureCard(CardButton: Integer; CardBGImage: Integer; CardLayout: Integer); overload;
    procedure ConfigureCard; overload;
    function GetAccentColor: TAlphaColor;
    procedure SetAcceptColor(const AColor: TAlphaColor);
    procedure SetCardTitle(const ATitle: String);
    procedure SetCardText(const AText: String);
    procedure SetCardTextColor(const AColor: TAlphaColor);
    procedure SetCardImage(ABitmap: TBitmap);
    procedure SetCardBackgroundImage(ABitmap: TBitmap);
    procedure SetCardBackgroundColor(const AColor: TAlphaColor);
    procedure SetCardColor(const AColor: TAlphaColor);
    procedure SetBackgroundImage(ABitmap: TBitmap);
    procedure SetBackgroundColor(const AColor: TAlphaColor);
    procedure SetNextButtonText(const AText: String);
    procedure SetNextButtonTextColor(const AColor: TAlphaColor);
    procedure SetNextButtonColor(const AColor: TAlphaColor);
  end;

implementation

{$R *.fmx}

procedure TFrameCard.MaterialDesignMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  CircleMD.Parent := TControl(Sender);
  CircleMD.Position.X := X-(CircleMD.Width/2);
  FX := X;
  CircleMD.Position.Y := Y-(CircleMD.Height/2);
  FY := Y;
  CircleMD.Width := 0;
  CircleMD.Height := 0;
  CircleMD.Visible := True;
  FloatAnimationMD.StopValue := Max(TControl(Sender).Width,TControl(Sender).Height)*2;
end;

procedure TFrameCard.ConfigureCard(CardButton: Integer; CardBGImage: Integer; CardLayout: Integer);
var
TabControl: TTabControl;
begin
  case CardButton of
    TCardButton.None: begin
       CardNextRectBTN.Visible := False;
       FooterNextRectBTN.Visible := False;
    end;
    TCardButton.Inner: begin
       CardNextRectBTN.Visible := True;
       FooterNextRectBTN.Visible := False;
    end;
    TCardButton.Outer: begin
       CardNextRectBTN.Visible := False;
       if Parent<>nil then
         if Parent.Parent is TTabItem then
           begin
             TTabItem(Parent.Parent).TagObject := FooterNextRectBTN;
             TabControl := TTabItem(Parent.Parent).TabControl;
             FooterNextRectBTN.Parent := TabControl.Parent
           end;
       FooterNextRectBTN.Visible := False;
    end;
  end;

  case CardBGImage of
    TCardBGImage.None: begin
      BackgroundImage.Visible := False;
      CardBackgroundImage.Visible := False;
    end;
    TCardBGImage.Inner: begin
      BackgroundImage.Visible := False;
      CardBackgroundImage.Visible := True;
      CardBackgroundImage.Opacity := 0.2;
      SetCardBackgroundColor(CardNextRectBTN.Fill.Color);
    end;
    TCardBGImage.Outer: begin
      BackgroundImage.Visible := True;
      CardBackgroundImage.Visible := False;
      FillCardRGBEffect.Enabled := True;
      SetCardTextColor(GetAccentColor);
    end;
    TCardBGImage.InnerAndOuter: begin
      BackgroundImage.Visible := True;
      CardBackgroundImage.Visible := True;
      CardBackgroundImage.Opacity := 0.2;
      SetCardBackgroundColor(CardNextRectBTN.Fill.Color);
    end;
  end;

  case CardLayout of
    TCardLayout.TextImage: begin
      TextLayout.Align := TAlignLayout.MostTop;
    end;
    TCardLayout.ImageText: begin
      TextLayout.Align := TAlignLayout.MostBottom;
      FillCardRGBEffect.Enabled := True;
      SetCardTextColor(GetAccentColor);
    end;
  end;
end;

procedure TFrameCard.CardNextRectBTNMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MaterialDesignMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TFrameCard.ConfigureCard;
begin
  ConfigureCard(TCardButton.Inner, TCardBGImage.Inner, TCardLayout.TextImage);
end;

procedure TFrameCard.FloatAnimationMDFinish(Sender: TObject);
begin
  CircleMD.Visible := False;
end;

procedure TFrameCard.FloatAnimationMDProcess(Sender: TObject);
begin
  CircleMD.Width := CircleMD.Height;
  CircleMD.Position.X := FX-(CircleMD.Width/2);;
  CircleMD.Position.Y := FY-(CircleMD.Height/2);;
end;

procedure TFrameCard.FooterNextRectBTNMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MaterialDesignMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TFrameCard.FrameResize(Sender: TObject);
var
  ScreenService: IFMXScreenService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenService)) then
  begin
    if ScreenService.GetScreenOrientation in [TScreenOrientation.Portrait, TScreenOrientation.InvertedPortrait] then
     begin
       CardRect.Margins.Bottom := 100;
       CardRect.Margins.Left := 50;
       CardRect.Margins.Right := 50;
       CardRect.Margins.Top := 100;
       CardImage.Align := TAlignLayout.VertCenter;
     end
    else
     begin
       CardRect.Margins.Bottom := 50;
       CardRect.Margins.Left := 25;
       CardRect.Margins.Right := 25;
       CardRect.Margins.Top := 50;
       CardImage.Align := TAlignLayout.Client;
     end;
  end;
end;

procedure TFrameCard.CardNextRectBTNClick(Sender: TObject);
var
TabControl: TTabControl;
begin
  if Parent.Parent is TTabItem then
    begin
      TabControl := TTabItem(Parent.Parent).TabControl;
      if TabControl.TabCount>(TabControl.TabIndex+1) then
        TabControl.SetActiveTabWithTransitionAsync(TabControl.Tabs[TabControl.TabIndex+1],TTabTransition.Slide,TTabTransitionDirection.Normal,nil);
    end;
end;

function TFrameCard.GetAccentColor: TAlphaColor;
begin
  if FAccentColorSet=False then
    begin
      Result := $FF203040;
    end
  else
    begin
      FAccentColorSet := True;
      Result := FAccentColor;
    end;
end;

procedure TFrameCard.SetAcceptColor(const AColor: TAlphaColor);
begin
  FAccentColor := AColor;
end;

procedure TFrameCard.SetCardTitle(const ATitle: string);
begin
  CardTitleLabel.Text := ATitle;
end;

procedure TFrameCard.SetCardText(const AText: string);
begin
  CardTextLabel.Text := AText;
end;

procedure TFrameCard.SetCardTextColor(const AColor: TAlphaColor);
begin
  CardTitleLabel.StyledSettings := CardNextLabel.StyledSettings - [TStyledSetting.FontColor];
  CardTextLabel.StyledSettings := FooterNextLabel.StyledSettings - [TStyledSetting.FontColor];
  CardTitleLabel.TextSettings.FontColor := AColor;
  CardTextLabel.TextSettings.FontColor := AColor;
end;

procedure TFrameCard.SetCardImage(ABitmap: TBitmap);
begin
  CardImage.Bitmap.Assign(ABitmap);
end;

procedure TFrameCard.SetCardBackgroundImage(ABitmap: TBitmap);
begin
  CardBackgroundImage.Bitmap.Assign(ABitmap);
end;

procedure TFrameCard.SetCardBackgroundColor(const AColor: TAlphaColor);
begin
  CardRect.Fill.Color := AColor;
end;

procedure TFrameCard.SetCardColor(const AColor: TAlphaColor);
begin
  CardRect.Fill.Color := AColor;
end;

procedure TFrameCard.SetBackgroundImage(ABitmap: TBitmap);
begin
  BackgroundImage.Bitmap.Assign(ABitmap);
end;

procedure TFrameCard.SetBackgroundColor(const AColor: TAlphaColor);
begin
  BackgroundRect.Fill.Color := AColor;
end;

procedure TFrameCard.SetNextButtonText(const AText: string);
begin
  CardNextLabel.Text := AText;
  FooterNextLabel.Text := AText;
end;

procedure TFrameCard.SetNextButtonTextColor(const AColor: TAlphaColor);
begin
  CardNextLabel.StyledSettings := CardNextLabel.StyledSettings - [TStyledSetting.FontColor];
  FooterNextLabel.StyledSettings := FooterNextLabel.StyledSettings - [TStyledSetting.FontColor];
  CardNextLabel.TextSettings.FontColor := AColor;
  FooterNextLabel.TextSettings.FontColor := AColor;
end;

procedure TFrameCard.SetNextButtonColor(const AColor: TAlphaColor);
begin
  CardNextRectBTN.Fill.Color := AColor;
  FooterNextRectBTN.Fill.Color := AColor;
  FillCardRGBEffect.Color := AColor;
  CircleMD.Fill.Color := AColor;
end;

end.
