//Icone <a href="https://www.flaticon.com/br/icones-gratis/inventario" title="invent�rio �cones">Invent�rio �cones criados por Freepik - Flaticon</a>
// Autora Stella Ramalho
unit frmMain;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Buttons,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  ShellApi,

  IniFiles,

  Winapi.Messages,
  Winapi.Windows,

  Xml.XMLDoc,
  Xml.XMLIntf,
  Xml.xmldom, Vcl.ExtCtrls;


type
  TfrmPrincipal = class(TForm)
    trVw: TTreeView;
    XMLDocument: TXMLDocument;
    edtEmpresa: TEdit;
    Empresa: TLabel;
    Respons�vel: TLabel;
    lblSetor: TLabel;
    Label4: TLabel;
    rdgUnidade: TRadioGroup;
    lblData: TLabel;
    edtResponsavel: TEdit;
    edtLocal: TEdit;
    edtPatrimonio: TEdit;
    btnGerar: TButton;
    Label1: TLabel;
    edtPatMon: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    I : TiniFile;
    procedure GenereteTree(XMLNode: IXMLNode; TreeNode: TTreeNode);

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

function ExecutarEEsperar(NomeArquivo : String) : Boolean;
var Sh: TShellExecuteInfo;
    CodigoSaida: DWORD;
begin
  FillChar(Sh, SizeOf(Sh), 0) ;
  Sh.cbSize := SizeOf(TShellExecuteInfo) ;
  with Sh do
  begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    lpVerb := nil;
    lpFile := PChar(NomeArquivo);
    nShow := SW_SHOWNORMAL;
  end;
  if ShellExecuteEx(@Sh) then
  begin
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(Sh.hProcess, CodigoSaida) ;
    until not(CodigoSaida = STILL_ACTIVE);
    Result := True;
  end
  else
    Result := False;
  end;

procedure TfrmPrincipal.btnGerarClick(Sender: TObject);
var
  NodeRequest,
  NodeDrives : IXMLNode;
  Arq        : TextFile;
  linha,
  linhaMon,
  NomePC,
  TamHD,
  ArqTxtName : string;
  IFor     : Integer;

begin
  I.WriteString('DADOS','EMPRESA',edtEmpresa.text);
//  I.WriteString('DADOS','RESPONSAVEL',edtResponsavel.text);
  I.WriteString('DADOS','LOCAL',edtLocal.text);
  I.WriteString('DADOS','UNIDADE',rdgUnidade.Items[rdgUnidade.ItemIndex]);

  Linha      := '';
  LinhaMon   := '';
  ArqTxtName := '';
  ArqTxtName := edtEmpresa.text + ' - ' + edtLocal.Text;

  NodeRequest := XmlDocument.ChildNodes['REQUEST'].ChildNodes['CONTENT'];

// Nome_empresa;
  Linha    := lblData.Caption +';';

//Tipo_Equipamento;
  Linha := linha + NodeRequest.ChildNodes['HARDWARE'].ChildNodes['CHASSIS_TYPE'].Text + ';';

//Nome_Responsavel;Local;Unidade;Patrimonio;
  Linha := linha + edtEmpresa.text +';'+edtResponsavel.Text+';'+edtLocal.Text+';'+
           rdgUnidade.Items[rdgUnidade.ItemIndex]+';'+edtPatrimonio.Text+';';


//Fabricante;
  Linha := linha + NodeRequest.ChildNodes['BIOS'].ChildNodes['SMANUFACTURER'].Text + ';';
//Modelo;
  Linha := linha + NodeRequest.ChildNodes['BIOS'].ChildNodes['SMODEL'].Text + ';';
//Service_Tag;
  Linha := linha + NodeRequest.ChildNodes['BIOS'].ChildNodes['SSN'].Text + ';';

//CPU;
  Linha := linha + NodeRequest.ChildNodes['CPUS'].ChildNodes['NAME'].Text + ';';

//Drive_HD;
  NodeDrives := NodeRequest.ChildNodes['DRIVES']; TamHD := '';
  for IFor := 0 to NodeDrives.ChildNodes.Count -1 do begin
    if (NodeDrives.ChildNodes['DESCRIPTION'].Text = 'Disco Fixo Local')
        and
       (NodeDrives.ChildNodes['LETTER'].Text = 'C:') then begin
         TamHD := NodeDrives.ChildNodes['TOTAL'].Text;
       end;
  end;
  if TamHD <>'' then begin
    TamHD := FloatToStr(StrToInt(TamHD)/1024);
  end;
  Linha := linha + TamHD + ';';
//Nome_PC;
  Linha := linha + NodeRequest.ChildNodes['HARDWARE'].ChildNodes['NAME'].Text + ';';
  NomePC :=NodeRequest.ChildNodes['HARDWARE'].ChildNodes['NAME'].Text;

//Memoria;
  Linha := linha + NodeRequest.ChildNodes['MEMORIES'].ChildNodes['CAPACITY'].Text + ';';

//Sistema_Operacional
  Linha := linha + NodeRequest.ChildNodes['OPERATINGSYSTEM'].ChildNodes['FULL_NAME'].Text + ';';
//Arquitetura
  Linha := linha + NodeRequest.ChildNodes['OPERATINGSYSTEM'].ChildNodes['ARCH'].Text + ';';

//Linha do monitor
  if edtPatMon.Text <> '' then begin
  // Nome_empresa;
    LinhaMon    := lblData.Caption +';';

  //Tipo_Equipamento;
    LinhaMon := LinhaMon + 'Monitor' + ';';

  //Nome_Responsavel;Local;Unidade;Patrimonio;
    LinhaMon := LinhaMon + edtEmpresa.text +';'+edtResponsavel.Text+';'+edtLocal.Text+';'+
             rdgUnidade.Items[rdgUnidade.ItemIndex]+';'+edtPatrimonio.Text+';';


{  NodeEvolucao :=  XMLDocument.ChildNodes['composicao'].ChildNodes['evolucao'];
  PairList := TStringList.Create;
  mmSaida.Lines.Clear;

  for i := 0 to NodeEvolucao.ChildNodes.Count-1 do begin
    NodeArquetipo := NodeEvolucao.ChildNodes[i];
    if NodeArquetipo.ChildNodes['ativo'].Text = 'T' then begin

 }



    NodeDrives := XmlDocument.ChildNodes['REQUEST'].ChildNodes['CONTENT'];
    for IFor := 0 to NodeDrives.ChildNodes.Count -1 do begin

      TamHD := NodeDrives.ChildNodes[iFor].NodeName;


      if NodeDrives.ChildNodes[iFor].NodeName = 'MONITORS' then begin
        if NodeDrives.ChildNodes[iFor].ChildNodes['SERIAL'].Text <> '00000000' then begin

        //Fabricante;
        TamHD := NodeDrives.ChildNodes[iFor].ChildNodes['MANUFACTURER'].Text + ';';
          LinhaMon := LinhaMon + NodeDrives.ChildNodes[iFor].ChildNodes['MANUFACTURER'].Text + ';';
        //Modelo;
          LinhaMon := LinhaMon + NodeDrives.ChildNodes[iFor].ChildNodes['CAPTION'].Text + ';';
        //Service_Tag;
          LinhaMon := LinhaMon + NodeDrives.ChildNodes[iFor].ChildNodes['SERIAL'].Text + ';';
        end;
      end;
    end;


  //CPU;
  //Drive_HD;
  //Nome_PC;
  //Memoria;
  //Sistema_Operacional
  //Arquitetura
    LinhaMon := LinhaMon + ';;;;;;';


  end;

  RenameFile('tempxml.xml',ArqTxtName+' - '+ NomePC +' - '+ edtPatrimonio.Text+'.xml');

  ArqTxtName := ArqTxtName+'.csv';

  AssignFile(Arq, ArqTxtName);
  if FileExists(ArqTxtName) then
    Append(Arq)
  else begin
    Rewrite(Arq);
    WriteLn(Arq,'Data;Tipo_Equipamento;Nome_empresa;Nome_Responsavel;Local;Unidade;Patrimonio;Fabricante;Modelo;Service_Tag;'+
                'CPU;Drive_HD;Nome_PC;Memoria;Sistema_Operacional;Arquitetura');
  end;

  WriteLn(Arq,Linha);
  if edtPatMon.Text <> '' then WriteLn(Arq,LinhaMon);

  CloseFile(Arq);
  ShowMessage('Invent�rio feito!!');

end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  I.Free;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);

begin
  I:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
  edtResponsavel.Text  := '';
  edtPatrimonio.Text   := '';
  edtPatMon.Text       := '';
  edtEmpresa.Text      := I.ReadString('DADOS','EMPRESA','');
  edtLocal.Text        := I.ReadString('DADOS','LOCAL','');
  rdgUnidade.ItemIndex := rdgUnidade.Items.IndexOf(I.ReadString('DADOS','UNIDADE',''));
  lblData.Caption      := DateToStr(Date);

  if not FileExists('tempxml.xml') then
    ExecutarEEsperar('glpi-inventory.bat');

  SetForegroundWindow(frmPrincipal.Handle);
  XMLDocument.LoadFromFile ('tempxml.xml'); // pegando o conte�do da vari�vel Caminho.
  trVw.Items.Clear; //limpa o conte�do que estiver na TreeView
  XMLDocument.Active:= True; // ativa o XMLDocument
  GenereteTree(XMLDocument.DocumentElement, nil); //Monta a TreeView

  edtResponsavel.SetFocus;
end;

procedure TfrmPrincipal.GenereteTree(XMLNode: IXMLNode; TreeNode: TTreeNode);
var
  NodeText : string;
  NewTreeNode: TTreeNode;
  I : Integer;
 begin
  if XMLNode.NodeType <> ntElement then
    Exit;
  NodeText := XMLNode.NodeName;
  if XMLNode.IsTextElement then
    NodeText := NodeText + '=' + XMLNode.NodeValue;
  NewTreeNode := trVw.Items.AddChild(TreeNode, NodeText);
  if XMLNode.HasChildNodes then
    for I := 0 to XMLNode.ChildNodes.Count - 1 do
      GenereteTree(XMLNode.ChildNodes[I], NewTreeNode);
 end;

end.
