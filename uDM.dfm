object DM: TDM
  OnCreate = DataModuleCreate
  Height = 548
  Width = 637
  object FDMemTable_AddrList: TFDMemTable
    OnCalcFields = FDMemTable_AddrListCalcFields
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 48
    object FDMemTable_AddrListwxid: TWideStringField
      FieldName = 'wxid'
      Size = 64
    end
    object FDMemTable_AddrListnickname: TWideStringField
      FieldName = 'nickname'
      Size = 64
    end
    object FDMemTable_AddrListremark: TWideStringField
      FieldName = 'remark'
      Size = 64
    end
    object FDMemTable_AddrListcustomname: TWideStringField
      FieldName = 'customAccount'
      Size = 64
    end
    object FDMemTable_AddrListkind: TStringField
      FieldKind = fkCalculated
      FieldName = 'kind'
      Calculated = True
    end
  end
  object DataSource_AddrList: TDataSource
    DataSet = FDMemTable_AddrList
    Left = 80
    Top = 136
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Documents\Embarcadero\Studio\Projects\2025-10-16wxbo' +
        't2\bin\helper.sdb'
      'DriverID=SQLite')
    Left = 336
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 464
    Top = 152
  end
  object FDQuery_Huifu: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Huifu')
    Left = 96
    Top = 304
    object FDQuery_Huifuid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object FDQuery_Huifu收信ID: TWideStringField
      FieldName = #25910#20449'ID'
      Origin = '"'#25910#20449'ID"'
      Size = 25
    end
    object FDQuery_Huifu收信内容: TWideStringField
      FieldName = #25910#20449#20869#23481
      Origin = '"'#25910#20449#20869#23481'"'
      Size = 254
    end
    object FDQuery_Huifu发信对象: TWideStringField
      FieldName = #21457#20449#23545#35937
      Origin = '"'#21457#20449#23545#35937'"'
      Size = 25
    end
    object FDQuery_Huifu发信类型: TWideStringField
      FieldName = #21457#20449#31867#22411
      Origin = '"'#21457#20449#31867#22411'"'
      Size = 25
    end
    object FDQuery_Huifu发信内容: TWideStringField
      FieldName = #21457#20449#20869#23481
      Origin = '"'#21457#20449#20869#23481'"'
      Size = 254
    end
    object FDQuery_Huifu发信延时: TIntegerField
      FieldName = #21457#20449#24310#26102
      Origin = '"'#21457#20449#24310#26102'"'
    end
  end
  object DataSource_Huifu: TDataSource
    DataSet = FDQuery_Huifu
    Left = 96
    Top = 232
  end
  object DataSource_Time: TDataSource
    DataSet = FDQuery_Time
    Left = 216
    Top = 232
  end
  object FDQuery_Time: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Time')
    Left = 216
    Top = 288
    object FDQuery_Timeid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object FDQuery_Time是否启用: TBooleanField
      FieldName = #26159#21542#21551#29992
      Origin = '"'#26159#21542#21551#29992'"'
    end
    object FDQuery_Time对象ID: TWideStringField
      FieldName = #23545#35937'ID'
      Origin = '"'#23545#35937'ID"'
      Size = 25
    end
    object FDQuery_Time类别: TWideStringField
      FieldName = #31867#21035
      Origin = '"'#31867#21035'"'
      Size = 25
    end
    object FDQuery_Time内容: TWideStringField
      FieldName = #20869#23481
      Origin = '"'#20869#23481'"'
      Size = 254
    end
    object FDQuery_Time定时时间: TWideStringField
      FieldName = #23450#26102#26102#38388
      Origin = '"'#23450#26102#26102#38388'"'
      Size = 254
    end
    object FDQuery_Time是否重复: TBooleanField
      FieldName = #26159#21542#37325#22797
      Origin = '"'#26159#21542#37325#22797'"'
    end
    object FDQuery_Time备注: TWideStringField
      FieldName = #22791#27880
      Origin = '"'#22791#27880'"'
      Size = 25
    end
  end
  object FDMemTable_Huifu: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftAutoInc
      end
      item
        Name = #25910#20449'ID'
        DataType = ftWideString
        Size = 25
      end
      item
        Name = #25910#20449#20869#23481
        DataType = ftWideString
        Size = 254
      end
      item
        Name = #21457#20449#23545#35937
        DataType = ftWideString
        Size = 25
      end
      item
        Name = #21457#20449#31867#22411
        DataType = ftWideString
        Size = 25
      end
      item
        Name = #21457#20449#20869#23481
        DataType = ftWideString
        Size = 254
      end
      item
        Name = #21457#20449#24310#26102
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 96
    Top = 408
    Content = {
      4144425310000000E7020000FF00010001FF02FF03040020000000460044004D
      0065006D005400610062006C0065005F00480075006900660075000500200000
      00460044004D0065006D005400610062006C0065005F00480075006900660075
      00060000000000070000080032000000090000FF0AFF0B040004000000690064
      00050004000000690064000C00010000000E000D000F00011000011100011200
      011300FFFFFFFF1400FFFFFFFF1500011600011700011800011900011A000400
      000069006400FEFF0B0400080000003665E14F490044000500080000003665E1
      4F490044000C00020000000E001B001C00190000000F00011000011200011500
      011600011700011A000C00000022003665E14F4900440022001D0019000000FE
      FF0B0400080000003665E14F8551B95B0500080000003665E14F8551B95B0C00
      030000000E001B001C00FE0000000F0001100001120001150001160001170001
      1A000C00000022003665E14F8551B95B22001D00FE000000FEFF0B0400080000
      00D153E14FF95B618C050008000000D153E14FF95B618C0C00040000000E001B
      001C00190000000F00011000011200011500011600011700011A000C00000022
      00D153E14FF95B618C22001D0019000000FEFF0B040008000000D153E14F7B7C
      8B57050008000000D153E14F7B7C8B570C00050000000E001B001C0019000000
      0F00011000011200011500011600011700011A000C0000002200D153E14F7B7C
      8B5722001D0019000000FEFF0B040008000000D153E14F8551B95B0500080000
      00D153E14F8551B95B0C00060000000E001B001C00FE0000000F000110000112
      00011500011600011700011A000C0000002200D153E14F8551B95B22001D00FE
      000000FEFF0B040008000000D153E14FF65EF665050008000000D153E14FF65E
      F6650C00070000000E000D000F00011000011200011500011600011700011A00
      0C0000002200D153E14FF65EF6652200FEFEFF1EFEFF1FFEFF20FEFEFEFF21FE
      FF22FF23FEFEFE0E004D0061006E0061006700650072001E0055007000640061
      007400650073005200650067006900730074007200790012005400610062006C
      0065004C006900730074000A005400610062006C00650008004E0061006D0065
      00140053006F0075007200630065004E0061006D0065000A0054006100620049
      004400240045006E0066006F0072006300650043006F006E0073007400720061
      0069006E00740073001E004D0069006E0069006D0075006D0043006100700061
      006300690074007900180043006800650063006B004E006F0074004E0075006C
      006C00140043006F006C0075006D006E004C006900730074000C0043006F006C
      0075006D006E00100053006F007500720063006500490044000E006400740049
      006E007400330032001000440061007400610054007900700065001400530065
      006100720063006800610062006C006500120041006C006C006F0077004E0075
      006C006C000E004100750074006F0049006E0063000800420061007300650022
      004100750074006F0049006E006300720065006D0065006E0074005300650065
      00640022004100750074006F0049006E006300720065006D0065006E00740053
      0074006500700014004F0041006C006C006F0077004E0075006C006C0012004F
      0049006E0055007000640061007400650010004F0049006E0057006800650072
      0065000C004F0049006E004B006500790020004F004100660074006500720049
      006E0073004300680061006E006700650064001A004F0072006900670069006E
      0043006F006C004E0061006D0065001800640074005700690064006500530074
      00720069006E0067000800530069007A006500140053006F0075007200630065
      00530069007A0065001C0043006F006E00730074007200610069006E0074004C
      00690073007400100056006900650077004C006900730074000E0052006F0077
      004C006900730074001800520065006C006100740069006F006E004C00690073
      0074001C0055007000640061007400650073004A006F00750072006E0061006C
      000E004300680061006E00670065007300}
    object FDMemTable_Huifuid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = False
      IdentityInsert = True
    end
    object FDMemTable_Huifu收信ID: TWideStringField
      FieldName = #25910#20449'ID'
      Origin = '"'#25910#20449'ID"'
      Size = 25
    end
    object FDMemTable_Huifu收信内容: TWideStringField
      FieldName = #25910#20449#20869#23481
      Origin = '"'#25910#20449#20869#23481'"'
      Size = 254
    end
    object FDMemTable_Huifu发信对象: TWideStringField
      FieldName = #21457#20449#23545#35937
      Origin = '"'#21457#20449#23545#35937'"'
      Size = 25
    end
    object FDMemTable_Huifu发信类型: TWideStringField
      FieldName = #21457#20449#31867#22411
      Origin = '"'#21457#20449#31867#22411'"'
      Size = 25
    end
    object FDMemTable_Huifu发信内容: TWideStringField
      FieldName = #21457#20449#20869#23481
      Origin = '"'#21457#20449#20869#23481'"'
      Size = 254
    end
    object FDMemTable_Huifu发信延时: TIntegerField
      FieldName = #21457#20449#24310#26102
      Origin = '"'#21457#20449#24310#26102'"'
    end
  end
  object FDQuery_Group: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        '                                                                ' +
        '       select * from zu')
    Left = 384
    Top = 376
    object FDQuery_Groupid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object FDQuery_Group组名: TWideStringField
      FieldName = #32452#21517
      Origin = '"'#32452#21517'"'
      Size = 25
    end
    object FDQuery_Group组员ID: TWideStringField
      FieldName = #32452#21592'ID'
      Origin = '"'#32452#21592'ID"'
      Size = 25
    end
  end
  object DataSource_Group: TDataSource
    DataSet = FDQuery_Group
    Left = 400
    Top = 288
  end
  object FDQuery_ZU: TFDQuery
    Connection = FDConnection1
    Left = 512
    Top = 376
  end
  object FDQuery_JICI: TFDQuery
    OnCalcFields = FDQuery_JICICalcFields
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT '#32452#21592'ID, COUNT(*) as '#27425#25968' FROM jici WHERE huifuid = 1 GROUP BY' +
        ' '#32452#21592'ID;')
    Left = 512
    Top = 472
    object FDQuery_JICI组员ID: TWideStringField
      FieldName = #32452#21592'ID'
      Origin = '"'#32452#21592'ID"'
      Size = 25
    end
    object FDQuery_JICInickname: TStringField
      FieldKind = fkCalculated
      FieldName = 'nickname'
      Size = 64
      Calculated = True
    end
    object FDQuery_JICI次数: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = #27425#25968
      Origin = '"'#27425#25968'"'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object DataSource_JICI: TDataSource
    DataSet = FDQuery_JICI
    Left = 424
    Top = 480
  end
end
