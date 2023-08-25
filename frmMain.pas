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
    Responsável: TLabel;
    lblSetor: TLabel;
    Label4: TLabel;
    rdgUnidade: TRadioGroup;
    lblData: TLabel;
    edtResponsavel: TEdit;
    edtLocal: TEdit;
    edtPatrimonio: TEdit;
    btnGerar: TButton;
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
  linha,
  NomePC,
  TamHD,
  ArqTxtName : string;
  IFor     : Integer;

begin
  I.WriteString('DADOS','EMPRESA',edtEmpresa.text);
  I.WriteString('DADOS','RESPONSAVEL',edtResponsavel.text);
  I.WriteString('DADOS','LOCAL',edtLocal.text);
  I.WriteString('DADOS','UNIDADE',rdgUnidade.Items[rdgUnidade.ItemIndex]);

  Linha      := '';
  ArqTxtName := '';
  ArqTxtName := edtEmpresa.text + ' - ' + edtLocal.Text;

  Linha := edtEmpresa.text +';'+edtResponsavel.Text+';'+edtLocal.Text+';'+
           rdgUnidade.Items[rdgUnidade.ItemIndex]+';'+edtPatrimonio.Text+';';
  NodeRequest := XmlDocument.ChildNodes['REQUEST'].ChildNodes['CONTENT'];

  Linha := linha + NodeRequest.ChildNodes['BIOS'].ChildNodes['SMANUFACTURER'].Text + ';';
  Linha := linha + NodeRequest.ChildNodes['BIOS'].ChildNodes['SMODEL'].Text + ';';
  Linha := linha + NodeRequest.ChildNodes['BIOS'].ChildNodes['SSN'].Text + ';';

  Linha := linha + NodeRequest.ChildNodes['CPUS'].ChildNodes['NAME'].Text + ';';

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

  Linha := linha + NodeRequest.ChildNodes['HARDWARE'].ChildNodes['CHASSIS_TYPE'].Text + ';';
  Linha := linha + NodeRequest.ChildNodes['HARDWARE'].ChildNodes['NAME'].Text + ';';
  NomePC :=NodeRequest.ChildNodes['HARDWARE'].ChildNodes['NAME'].Text;

  Linha := linha + NodeRequest.ChildNodes['MEMORIES'].ChildNodes['CAPACITY'].Text + ';';

  Linha := linha + NodeRequest.ChildNodes['OPERATINGSYSTEM'].ChildNodes['FULL_NAME'].Text + ';';
  Linha := linha + NodeRequest.ChildNodes['OPERATINGSYSTEM'].ChildNodes['ARCH'].Text + ';';

  RenameFile('tempxml.xml',ArqTxtName+' - '+ NomePC +' - '+ edtPatrimonio.Text+'.xml');

end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  I.Free;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);

begin
  I:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
  edtEmpresa.Text     := I.ReadString('DADOS','EMPRESA','');
  edtResponsavel.Text := I.ReadString('DADOS','RESPONSAVEL','');
  edtLocal.Text       := I.ReadString('DADOS','LOCAL','');
  rdgUnidade.ItemIndex :=
  rdgUnidade.Items.IndexOf(I.ReadString('DADOS','UNIDADE',''));
  lblData.Caption := DateToStr(Date);

//  ExecutarEEsperar('glpi-inventory.bat');

  XMLDocument.LoadFromFile ('tempxml.xml'); // pegando o conteúdo da variável Caminho.
  trVw.Items.Clear; //limpa o conteúdo que estiver na TreeView
  XMLDocument.Active:= True; // ativa o XMLDocument
  GenereteTree(XMLDocument.DocumentElement, nil); //Monta a TreeView

  edtPatrimonio.SetFocus;
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
