program WizardTemplate;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uCardFrame in 'uCardFrame.pas' {FrameCard: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait, TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
