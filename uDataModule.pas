unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TDataModule1 = class(TDataModule)
    FDConnectionInsta: TFDConnection;
    FDQueryInsta: TFDQuery;
    FDQueryInstapatient_id: TWideStringField;
    FDQueryInstamr_no: TWideStringField;
    FDQueryInstafull_name: TWideStringField;
    FDQueryInstapatient_phone: TWideStringField;
    FDQueryInstareg_date: TDateField;
    FDQueryInstareg_time: TTimeField;
    FDQueryInstastatus: TWideStringField;
    FDQueryInstavisit_type_name: TWideStringField;
    FDQueryInstadept_id: TWideStringField;
    FDQueryInstadept_name: TWideStringField;
    FDQueryInstadoctor_name: TWideStringField;
    FDQueryInstacenter_id: TIntegerField;
    FDConnectionLocal: TFDConnection;
    FDQueryVisits: TFDQuery;
    FDQueryLink: TFDQuery;
    FDQueryLinkurl: TWideStringField;
    FDQueryPostVisits: TFDQuery;
    FDConnectionSMS: TFDConnection;
    FDQuerySMS: TFDQuery;
    FDQuerySMSoutMessagesID: TFDAutoIncField;
    FDQuerySMSsourceAddr: TStringField;
    FDQuerySMSdestinationAddr: TLargeintField;
    FDQuerySMSmessageContent: TMemoField;
    FDQuerySMSstatus: TIntegerField;
    FDQuerySMSdateCreated: TDateTimeField;
    FDQuerySMSdateModified: TSQLTimeStampField;
    FDQuerySMScreatedBy: TIntegerField;
    FDQueryReadSMSData: TFDQuery;
    FDQueryReadSMSDatapatient_phone: TWideStringField;
    FDQueryReadSMSDataurl: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
