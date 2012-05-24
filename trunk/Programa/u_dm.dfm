object dm: Tdm
  OldCreateOrder = False
  Height = 499
  Width = 623
  object conexao: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=admin;Data Source=C:\Ro' +
      'yalt Hotel\banco\banco.mdb;Mode=Share Deny None;Persist Security' +
      ' Info=False;Jet OLEDB:System database="";Jet OLEDB:Registry Path' +
      '="";Jet OLEDB:Database Password=systemhotel;Jet OLEDB:Engine Typ' +
      'e=5;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial B' +
      'ulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Dat' +
      'abase Password="";Jet OLEDB:Create System Database=False;Jet OLE' +
      'DB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact' +
      '=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:' +
      'SFP=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 16
  end
  object t_cliente: TADOTable
    Connection = conexao
    CursorType = ctStatic
    TableName = 'cliente'
    Left = 24
    Top = 72
    object t_clienteid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object t_clientecpf: TWideStringField
      FieldName = 'cpf'
      EditMask = '000\.000\.000\-00;0;_'
      Size = 255
    end
    object t_clientenome: TWideStringField
      FieldName = 'nome'
      Size = 255
    end
    object t_clientetelefone: TWideStringField
      FieldName = 'telefone'
      EditMask = '(00)0000-0000;0;_'
      Size = 255
    end
    object t_clienteestado: TWideStringField
      FieldName = 'estado'
      Size = 255
    end
    object t_clientecidade: TWideStringField
      FieldName = 'cidade'
      Size = 255
    end
  end
  object ds_cliente: TDataSource
    AutoEdit = False
    DataSet = t_cliente
    Left = 88
    Top = 72
  end
  object q_cliente: TADOQuery
    Connection = conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from cliente')
    Left = 152
    Top = 72
  end
  object ds_cliente_grid: TDataSource
    AutoEdit = False
    DataSet = q_cliente
    Left = 216
    Top = 72
  end
  object t_quarto: TADOTable
    Connection = conexao
    CursorType = ctStatic
    TableName = 'quarto'
    Left = 24
    Top = 144
  end
  object ds_quarto: TDataSource
    AutoEdit = False
    DataSet = t_quarto
    Left = 88
    Top = 144
  end
  object q_quarto: TADOQuery
    Connection = conexao
    CursorType = ctStatic
    Parameters = <>
    Left = 152
    Top = 144
  end
  object ds_quarto_grid: TDataSource
    AutoEdit = False
    DataSet = q_quarto
    Left = 216
    Top = 144
  end
end
