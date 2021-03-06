unit uQuestionnaire;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,ShellAPI;

type
  TQuestionnaire = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Questionnaire: TQuestionnaire;

implementation

{$R *.dfm}

uses uDataModule;

procedure TQuestionnaire.Timer1Timer(Sender: TObject);
Var
patient_id, mr_no, full_name, patient_phone,visit_type_name, dept_id,dept_name, doctor_name,sql : String;
reg_date : Tdate;
reg_time : TTime;
center_id : Integer;

begin

DataModule1.FDQueryInsta.SQL.Clear;
DataModule1.FDQueryInsta.SQL.Add('SELECT patient_id,mr_no,full_name::VARCHAR,');
DataModule1.FDQueryInsta.SQL.Add('patient_phone, reg_date, reg_time, status,');
DataModule1.FDQueryInsta.SQL.Add('visit_type_name, dept_id,dept_name, doctor_name, center_id FROM custom_patient_visit_details ');
DataModule1.FDQueryInsta.SQL.Add('WHERE dept_id NOT IN (:DEP0005, :DEP_PHA,:DEP_LAB,:DEP_RAD, :DEP0051) AND doctor_name IS NOT NULL and  reg_date = NOW()::date and center_id IN (1,7)');
DataModule1.FDQueryInsta.Params.ParamByName('DEP0005').Value := 'DEP0005';
DataModule1.FDQueryInsta.Params.ParamByName('DEP_PHA').Value := 'DEP_PHA';
DataModule1.FDQueryInsta.Params.ParamByName('DEP_RAD').Value := 'DEP_RAD';
DataModule1.FDQueryInsta.Params.ParamByName('DEP_LAB').Value := 'DEP_LAB';
DataModule1.FDQueryInsta.Params.ParamByName('DEP0051').Value := 'DEP0051';
DataModule1.FDQueryInsta.Open();

      if DataModule1.FDQueryInsta.RecordCount <> 0 then
      begin
        repeat
        
        DataModule1.FDQueryPostVisits.SQL.Clear;
        DataModule1.FDQueryPostVisits.SQL.Add('INSERT INTO visit_details_q_and_a(');
        DataModule1.FDQueryPostVisits.SQL.Add('patient_id,mr_no,full_name, patient_phone,reg_date,');
        DataModule1.FDQueryPostVisits.SQL.Add('visit_type_name, dept_id,dept_name,');
        DataModule1.FDQueryPostVisits.SQL.Add('doctor_name, center_id) ');
        DataModule1.FDQueryPostVisits.SQL.Add('VALUES(:patient_id,:mr_no,:full_name,:patient_phone,:reg_date, ');
        DataModule1.FDQueryPostVisits.SQL.Add(':visit_type_name, :dept_id,:dept_name, ');
        DataModule1.FDQueryPostVisits.SQL.Add(':doctor_name, :center_id) ON CONFLICT ON CONSTRAINT visit_details_q_and_a_pkey DO NOTHING');
        DataModule1.FDQueryPostVisits.Params.ParamByName('patient_id').Value := DataModule1.FDQueryInstapatient_id.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('mr_no').Value := DataModule1.FDQueryInstamr_no.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('full_name').Value := DataModule1.FDQueryInstafull_name.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('patient_phone').Value := DataModule1.FDQueryInstapatient_phone.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('reg_date').Value := DataModule1.FDQueryInstareg_date.Value;
        //DataModule1.FDQueryPostVisits.Params.ParamByName('reg_time').Value := DataModule1.FDQueryInstareg_time.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('visit_type_name').Value := DataModule1.FDQueryInstavisit_type_name.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('dept_id').Value := DataModule1.FDQueryInstadept_id.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('dept_name').Value := DataModule1.FDQueryInstadept_name.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('doctor_name').Value := DataModule1.FDQueryInstadoctor_name.Value;
        DataModule1.FDQueryPostVisits.Params.ParamByName('center_id').Value := DataModule1.FDQueryInstacenter_id.Value;
        DataModule1.FDQueryPostVisits.ExecSQL;

        DataModule1.FDQueryInsta.Next;
        until DataModule1.FDQueryInsta.Eof;


      DataModule1.FDQueryReadSMSData.SQL.Clear;
      DataModule1.FDQueryReadSMSData.SQL.Add('SELECT patient_phone::varchar, url::varchar FROM q_sms_view');
      DataModule1.FDQueryReadSMSData.Open();

          if DataModule1.FDQueryReadSMSData.RecordCount <> 0 then
          begin

              DataModule1.FDQuerySMS.SQL.Clear;
              DataModule1.FDQuerySMS.SQL.Add('SELECT * FROM outmessages WHERE outMessagesID = 1');
              DataModule1.FDQuerySMS.Open();


              repeat
              DataModule1.FDQuerySMS.Insert;
              DataModule1.FDQuerySMSsourceAddr.Value := 'KAREN_HOSP';
              DataModule1.FDQuerySMSdestinationAddr.Text := DataModule1.FDQueryReadSMSDatapatient_phone.Text;
              DataModule1.FDQuerySMSmessageContent.Text := DataModule1.FDQueryReadSMSDataurl.Text;
              DataModule1.FDQuerySMScreatedBy.Value := 555555;
              DataModule1.FDQuerySMS.Post;

              DataModule1.FDQueryReadSMSData.Next;
              until DataModule1.FDQueryReadSMSData.Eof;

              if  ((System.SysUtils.FileExists('C:\SiliconSMSScripts\sendSMS.bat')) and (System.SysUtils.DirectoryExists('C:\xampp\php'))) then
              begin
                ShellExecute (Handle, 'open','C:\SiliconSMSScripts\sendSMS.bat', nil, nil, SW_SHOWMINIMIZED);
                DataModule1.FDQueryReadSMSData.SQL.clear;
                DataModule1.FDQueryReadSMSData.SQL.Add('UPDATE visit_details_q_and_a SET status = 1 WHERE status = 0');
                DataModule1.FDQueryReadSMSData.ExecSQL;
              end;
          end;


      end;

end;

end.
