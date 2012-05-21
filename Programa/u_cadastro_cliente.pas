unit u_cadastro_cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, ExtCtrls, Buttons, PngSpeedButton, Grids,
  DBGrids, u_dm, DB;

type
  Tf_cadastro_cliente = class(TForm)
    db_cpf: TDBEdit;
    db_nome: TDBEdit;
    db_telefone: TDBEdit;
    db_cidade: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    db_estado: TDBComboBox;
    b_novo: TPngSpeedButton;
    b_alterar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    Panel1: TPanel;
    group_pesquisar: TGroupBox;
    DBGrid1: TDBGrid;
    t_cpf: TEdit;
    t_nome: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    b_listar_todos: TPngSpeedButton;
    procedure b_novoClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
    procedure b_alterarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_cancelarClick(Sender: TObject);
    procedure b_fecharClick(Sender: TObject);
    procedure t_nomeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure b_listar_todosClick(Sender: TObject);
    procedure t_cpfChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_cliente: Tf_cadastro_cliente;
  resultado : integer;
  v_salvar : integer;
  conta_cpf : integer;

implementation

{$R *.dfm}

procedure Tf_cadastro_cliente.b_alterarClick(Sender: TObject);
begin
db_nome.Enabled:=true;
db_cpf.Enabled:=true;
db_telefone.Enabled:=true;
db_cidade.Enabled:=true;
db_estado.Enabled:=true;
b_salvar.Enabled:=true;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_novo.Enabled:=false;
b_cancelar.Enabled:=true;
//vai servir para o bot�o salvar saber se verifica se cpf j� existe, ou apenas atualiza
v_salvar := 2;
//
dm.t_cliente.Edit;
end;

procedure Tf_cadastro_cliente.b_cancelarClick(Sender: TObject);
begin
dm.t_cliente.Cancel;
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_telefone.Enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;

end;

procedure Tf_cadastro_cliente.b_excluirClick(Sender: TObject);
begin
If Application.MessageBox('Confirma Exclus�o?','Aten��o!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_cliente.Delete;
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_telefone.Enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
dm.q_cliente.Active:=false;
dm.q_cliente.Active:=true;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;
end;

procedure Tf_cadastro_cliente.b_fecharClick(Sender: TObject);
begin
dm.t_cliente.Cancel;
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_telefone.Enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;

close;
end;

procedure Tf_cadastro_cliente.b_listar_todosClick(Sender: TObject);
begin
dm.t_cliente.cancel;
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;

procedure Tf_cadastro_cliente.b_novoClick(Sender: TObject);
begin
db_nome.Enabled:=true;
db_cpf.Enabled:=true;
db_telefone.Enabled:=true;
db_cidade.Enabled:=true;
db_estado.Enabled:=true;
b_novo.Enabled:=false;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_salvar.Enabled:=true;
b_cancelar.Enabled:=true;
//vai servir para o bot�o salvar saber se verifica se cpf j� existe, ou apenas atualiza
v_salvar := 1;
//
dm.t_cliente.cancel;
dm.t_cliente.append;
db_cpf.SetFocus;
end;

procedure Tf_cadastro_cliente.b_salvarClick(Sender: TObject);
begin
if db_nome.text = '' then
  begin
  showmessage('Nome n�o poder ser vazio!');
  exit;
  end;
if db_cpf.text = '' then
  begin
  showmessage('CPF n�o poder ser vazio!');
  exit;
  end;
//se veio do bot�o novo verifica se cpf j� existe
if v_salvar = 1 then
begin
with dm.q_cliente do
  begin
  Active := False;
  SQL.Text := 'Select * from cliente where cpf = :cp';
  parameters.parambyname('cp').value := db_cpf.text;
  Active := True;
  conta_cpf := RecordCount;
  end;
  if (conta_cpf > 0) then
    begin
    showmessage('CPF j� cadastrado!');
    exit
    end
    else
    begin
    If Application.MessageBox('Gravar registro?','Aten��o!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin

    dm.t_cliente.Post;
    showmessage('Cadastro efetuado com sucesso!');
    db_nome.Enabled:=false;
    db_cpf.Enabled:=false;
    db_telefone.Enabled:=false;
    db_cidade.Enabled:=false;
    db_estado.Enabled:=false;
    b_salvar.Enabled:=false;
    b_alterar.Enabled:=true;
    b_cancelar.Enabled:=false;
    b_novo.Enabled:=true;
    b_excluir.Enabled:=true;
    //atualizar grid
    with dm.q_cliente do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from cliente order by nome');
    Open;
    end;
   end;
   end;
   end;

//se veio do bot�o alterar n�o verifica se cpf existe
if v_salvar = 2 then
begin
If Application.MessageBox('Confirma altera��o?','Aten��o!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_cliente.Post;
showmessage('Cadastro alterado com sucesso!');
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_telefone.Enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_alterar.Enabled:=true;
b_cancelar.Enabled:=false;
b_novo.Enabled:=true;
b_excluir.Enabled:=true;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;
end;

end;

procedure Tf_cadastro_cliente.DBGrid1CellClick(Column: TColumn);
begin
resultado := dm.q_cliente.fieldbyname('id').asinteger;
dm.t_cliente.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
end;

procedure Tf_cadastro_cliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dm.t_cliente.cancel;
end;

procedure Tf_cadastro_cliente.FormShow(Sender: TObject);
begin
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_telefone.Enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;

end;

procedure Tf_cadastro_cliente.t_cpfChange(Sender: TObject);
begin
if t_cpf.text <> '' then
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente where cpf like '''+t_cpf.text+'%''');
  Open;
  resultado := dm.q_cliente.fieldbyname('id').asinteger;
  dm.t_cliente.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
  end;
end
else
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;

end;

procedure Tf_cadastro_cliente.t_nomeChange(Sender: TObject);
begin
if t_nome.text <> '' then
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente where nome like '''+t_nome.text+'%''');
  Open;
  resultado := dm.q_cliente.fieldbyname('id').asinteger;
  dm.t_cliente.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
  end;
end
else
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;


end;

end.
