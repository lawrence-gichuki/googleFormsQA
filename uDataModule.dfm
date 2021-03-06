object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 466
  Width = 588
  object FDConnectionInsta: TFDConnection
    Params.Strings = (
      'Database=hms'
      'User_Name=exports'
      'Password=exports@123'
      'Server=172.16.0.204'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object FDQueryInsta: TFDQuery
    Connection = FDConnectionInsta
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 500
    SQL.Strings = (
      
        'SELECT patient_id,mr_no,full_name::VARCHAR, patient_phone, reg_d' +
        'ate, reg_time, status, visit_type_name, dept_id,dept_name, docto' +
        'r_name, center_id FROM custom_patient_visit_details WHERE dept_i' +
        'd NOT IN ('#39'DEP0005'#39', '#39'DEP_PHA'#39','#39'DEP_LAB'#39','#39'DEP_RAD'#39','#39'DEP0051'#39') AN' +
        'D doctor_name IS NOT NULL and  reg_date = NOW()::date and center' +
        '_id IN (1,7);')
    Left = 144
    Top = 32
    object FDQueryInstapatient_id: TWideStringField
      FieldName = 'patient_id'
      Origin = 'patient_id'
      Size = 15
    end
    object FDQueryInstamr_no: TWideStringField
      FieldName = 'mr_no'
      Origin = 'mr_no'
      Size = 15
    end
    object FDQueryInstafull_name: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'full_name'
      Origin = 'full_name'
      ReadOnly = True
      Size = 8190
    end
    object FDQueryInstapatient_phone: TWideStringField
      FieldName = 'patient_phone'
      Origin = 'patient_phone'
      Size = 16
    end
    object FDQueryInstareg_date: TDateField
      FieldName = 'reg_date'
      Origin = 'reg_date'
    end
    object FDQueryInstareg_time: TTimeField
      FieldName = 'reg_time'
      Origin = 'reg_time'
    end
    object FDQueryInstastatus: TWideStringField
      FieldName = 'status'
      Origin = 'status'
      Size = 15
    end
    object FDQueryInstavisit_type_name: TWideStringField
      FieldName = 'visit_type_name'
      Origin = 'visit_type_name'
      Size = 8190
    end
    object FDQueryInstadept_id: TWideStringField
      FieldName = 'dept_id'
      Origin = 'dept_id'
      Size = 10
    end
    object FDQueryInstadept_name: TWideStringField
      FieldName = 'dept_name'
      Origin = 'dept_name'
      Size = 100
    end
    object FDQueryInstadoctor_name: TWideStringField
      FieldName = 'doctor_name'
      Origin = 'doctor_name'
      Size = 100
    end
    object FDQueryInstacenter_id: TIntegerField
      FieldName = 'center_id'
      Origin = 'center_id'
    end
  end
  object FDConnectionLocal: TFDConnection
    Params.Strings = (
      'Database=postgres'
      'User_Name=postgres'
      'Password=root'
      'Server=172.16.0.4'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 192
  end
  object FDQueryVisits: TFDQuery
    Connection = FDConnectionLocal
    SQL.Strings = (
      
        'SELECT patient_id,mr_no,full_name, patient_phone,reg_date, reg_t' +
        'ime, status, visit_type_name, dept_id,dept_name, doctor_name, ce' +
        'nter_id'
      'FROM visit_details_q_and_a')
    Left = 136
    Top = 192
  end
  object FDQueryLink: TFDQuery
    Connection = FDConnectionLocal
    SQL.Strings = (
      'SELECT url FROM questionanaire_link;')
    Left = 224
    Top = 192
    object FDQueryLinkurl: TWideStringField
      FieldName = 'url'
      Origin = 'url'
      Size = 150
    end
  end
  object FDQueryPostVisits: TFDQuery
    Connection = FDConnectionLocal
    SQL.Strings = (
      
        'SELECT patient_id,mr_no,full_name, patient_phone,reg_date, reg_t' +
        'ime, status, visit_type_name, dept_id,dept_name, doctor_name, ce' +
        'nter_id'
      'FROM visit_details_q_and_a')
    Left = 320
    Top = 200
  end
  object FDConnectionSMS: TFDConnection
    Params.Strings = (
      'Database=sms'
      'User_Name=root'
      'Password=root'
      'Server=172.16.0.4'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 112
  end
  object FDQuerySMS: TFDQuery
    Connection = FDConnectionSMS
    SQL.Strings = (
      'SELECT * FROM outmessages')
    Left = 120
    Top = 112
    object FDQuerySMSoutMessagesID: TFDAutoIncField
      FieldName = 'outMessagesID'
      Origin = 'outMessagesID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQuerySMSsourceAddr: TStringField
      FieldName = 'sourceAddr'
      Origin = 'sourceAddr'
      Required = True
      Size = 60
    end
    object FDQuerySMSdestinationAddr: TLargeintField
      FieldName = 'destinationAddr'
      Origin = 'destinationAddr'
      Required = True
    end
    object FDQuerySMSmessageContent: TMemoField
      FieldName = 'messageContent'
      Origin = 'messageContent'
      Required = True
      BlobType = ftMemo
    end
    object FDQuerySMSstatus: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'status'
      Origin = '`status`'
    end
    object FDQuerySMSdateCreated: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'dateCreated'
      Origin = 'dateCreated'
    end
    object FDQuerySMSdateModified: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'dateModified'
      Origin = 'dateModified'
    end
    object FDQuerySMScreatedBy: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'createdBy'
      Origin = 'createdBy'
    end
  end
  object FDQueryReadSMSData: TFDQuery
    Connection = FDConnectionLocal
    SQL.Strings = (
      'SELECT patient_phone::varchar, url::varchar FROM q_sms_view')
    Left = 448
    Top = 192
    object FDQueryReadSMSDatapatient_phone: TWideStringField
      FieldName = 'patient_phone'
      Origin = 'patient_phone'
      Size = 15
    end
    object FDQueryReadSMSDataurl: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'url'
      Origin = 'url'
      Size = 150
    end
  end
end
