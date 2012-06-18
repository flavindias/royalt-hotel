unit u_dm;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  Tdm = class(TDataModule)
    conexao: TADOConnection;
    t_cliente: TADOTable;
    ds_cliente: TDataSource;
    q_cliente: TADOQuery;
    ds_cliente_grid: TDataSource;
    t_clientecpf: TWideStringField;
    t_clientenome: TWideStringField;
    t_clientetelefone_celular: TWideStringField;
    t_clienteemail: TWideStringField;
    t_clienteendereco: TWideStringField;
    t_clientecomplemento: TWideStringField;
    t_clientebairro: TWideStringField;
    t_clientecidade: TWideStringField;
    t_clienteestado: TWideStringField;
    t_clientecep: TWideStringField;
    t_clientepais: TWideStringField;
    t_clientetelefone_residencial: TWideStringField;
    ds_reserva_grid: TDataSource;
    q_reserva: TADOQuery;
    ds_reserva: TDataSource;
    q_quarto: TADOQuery;
    q_limpeza: TADOQuery;
    ds_limpeza_grid: TDataSource;
    t_quarto: TADOTable;
    t_reserva: TADOTable;
    t_reservaid: TAutoIncField;
    t_reservacheck_in: TDateTimeField;
    t_reservacheck_out: TDateTimeField;
    t_reservanum_quarto: TIntegerField;
    t_reservacpf_cliente: TWideStringField;
    t_reservanome_cliente: TWideStringField;
    q_senha: TADOQuery;
    q_pagamento: TADOQuery;
    ds_pagamento_grid: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
