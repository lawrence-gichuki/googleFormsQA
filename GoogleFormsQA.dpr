program GoogleFormsQA;

uses
  Vcl.Forms,
  uQuestionnaire in 'uQuestionnaire.pas' {Questionnaire},
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Purple');
  Application.CreateForm(TQuestionnaire, Questionnaire);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
