unit pendencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DateUtils;

type
  Tfrmpendencia = class(TForm)
    tbdenuncia: TTable;
    tbdenunciaDenuncia: TIntegerField;
    tbdenunciaArchive: TBooleanField;
    tbdenunciaFiscalEncaminha: TStringField;
    tbdenunciaPrazo: TDateField;
    tbdenunciaLogradouro: TStringField;
    dsdenuncia: TDataSource;
    tboficio: TTable;
    tboficioOficio: TIntegerField;
    tboficioData: TDateField;
    tboficioFiscalencaminha: TStringField;
    tboficioDtencaminha: TDateField;
    tboficioPrazo: TDateField;
    tboficioDtatendimento: TDateField;
    tboficioUser: TStringField;
    tboficioArchive: TBooleanField;
    tboficioCancela: TBooleanField;
    tboficioEmitente: TStringField;
    tboficioMotivo: TStringField;
    tboficioRegulado: TStringField;
    tboficioLogradouro: TStringField;
    tboficioCdbai: TSmallintField;
    tboficioOrdem: TStringField;
    tboficioCpf: TStringField;
    tboficioCnpj: TStringField;
    dsoficio: TDataSource;
    tbreq: TTable;
    tbreqControle: TAutoIncField;
    tbreqCodigo: TIntegerField;
    tbreqOS: TIntegerField;
    tbreqArea: TStringField;
    tbreqMotivo: TStringField;
    tbreqVeiculos: TSmallintField;
    tbreqRequerente: TStringField;
    tbreqObs_Req: TStringField;
    tbreqDt_Req: TDateField;
    tbreqFiscal_Encaminha: TStringField;
    tbreqRecebedor: TStringField;
    tbreqDt_encaminha: TDateField;
    tbreqEncaminhador: TStringField;
    tbreqFiscal_Atend: TStringField;
    tbreqDt_Atend: TDateField;
    tbreqTipo_Documento: TStringField;
    tbreqObs_Atend: TStringField;
    tbreqEncaminhamento: TBooleanField;
    tbreqAtendimento: TBooleanField;
    tbreqNum_Documento: TStringField;
    tbreqCancelado: TBooleanField;
    tbreqComplexidade: TStringField;
    tbreqPrazo: TDateField;
    dsreq: TDataSource;
    tbplanta: TTable;
    tbplantaProtocolo: TIntegerField;
    tbplantaCodigo: TIntegerField;
    tbplantaCarga: TStringField;
    tbplantaAssunto: TStringField;
    dsplanta: TDataSource;
    tbtramitacao: TTable;
    tbtramitacaoProtocolo: TIntegerField;
    tbtramitacaoData: TDateField;
    tbtramitacaoHora: TTimeField;
    tbtramitacaoDestino: TStringField;
    dstramitacao: TDataSource;
    tbcontrib: TTable;
    tbcontribCodigo: TIntegerField;
    tbcontribRazao: TStringField;
    dscontrib: TDataSource;
    sgPendencias: TStringGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgPendenciasDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    RowColors: array of TColor;
    function IsHoliday(d: TDate): Boolean;
    function IsBusinessDay(d: TDate): Boolean;
    function AddBusinessDays(startDate: TDate; days: Integer): TDate;
  public
  end;

var
  frmpendencia: Tfrmpendencia;

implementation

uses login;

{$R *.dfm}

const
  CLR_VENCIDO = TColor($001E1EC0);

procedure Tfrmpendencia.FormActivate(Sender: TObject);
var
  dias: Integer;
  tramitDates: TStringList;
  fiscais: TStringList;
  protoStr: string;
  dt, lastDt: TDateTime;
  lastDate: TDate;
  deadline: TDate;
  razaoSocial: string;
  dtStr: string;
  complexOficio: string;
  isAdmin: Boolean;
  counts: array[0..43, 0..3] of Integer;
  i, idx, total, rowIdx: Integer;

  procedure AddRow(const tipo, numero, complexidade, descricao, prazoStr,
    situacao: string; cor: TColor);
  var
    r: Integer;
  begin
    if (sgPendencias.RowCount = 2) and (sgPendencias.Cells[0, 1] = '') then
      r := 1
    else
    begin
      r := sgPendencias.RowCount;
      sgPendencias.RowCount := r + 1;
      SetLength(RowColors, r);
    end;
    RowColors[r - 1] := cor;
    sgPendencias.Cells[0, r] := tipo;
    sgPendencias.Cells[1, r] := numero;
    sgPendencias.Cells[2, r] := complexidade;
    sgPendencias.Cells[3, r] := descricao;
    sgPendencias.Cells[4, r] := prazoStr;
    sgPendencias.Cells[5, r] := situacao;
  end;

begin
  sgPendencias.RowCount := 2;
  sgPendencias.FixedRows := 1;
  sgPendencias.Cells[0, 1] := '';
  sgPendencias.Cells[0, 0] := 'Tipo';
  sgPendencias.Cells[1, 0] := 'N'#186;
  sgPendencias.Cells[2, 0] := 'Complexidade';
  sgPendencias.Cells[3, 0] := 'Raz'#227'o Social';
  sgPendencias.Cells[4, 0] := 'Prazo';
  sgPendencias.Cells[5, 0] := 'Situa'#231#227'o';
  SetLength(RowColors, 1);
  RowColors[0] := clWhite;

  if not ((frmlogin.c_grp = 'FIS') or (frmlogin.c_grp = 'ADM')) then
    Exit;

  isAdmin := (frmlogin.c_grp = 'ADM');

  if isAdmin then
  begin
    { === ADM: resumo por fiscal === }
    Caption := 'Ordens de Servi'#231'o Vencidas - Por Fiscal';
    sgPendencias.Cells[0, 0] := 'Fiscal';
    sgPendencias.Cells[1, 0] := 'Of'#237'cios';
    sgPendencias.Cells[2, 0] := 'OS';
    sgPendencias.Cells[3, 0] := 'Den'#250'ncias';
    sgPendencias.Cells[4, 0] := 'Protocolos';
    sgPendencias.Cells[5, 0] := 'Total';

    { Larguras proporcionais para ADM }
    sgPendencias.ColWidths[0] := sgPendencias.ClientWidth div 2;
    i := (sgPendencias.ClientWidth - sgPendencias.ColWidths[0]) div 5;
    sgPendencias.ColWidths[1] := i;
    sgPendencias.ColWidths[2] := i;
    sgPendencias.ColWidths[3] := i;
    sgPendencias.ColWidths[4] := i;
    sgPendencias.ColWidths[5] := sgPendencias.ClientWidth
      - sgPendencias.ColWidths[0] - (i * 4);

    fiscais := TStringList.Create;
    fiscais.Sorted := True;
    try
      fiscais.Add('ACADIA DE SOUZA VIEIRA SILVA');
      fiscais.Add('ADRIANA CRHISTINA DE REZENDE CARNEIRO');
      fiscais.Add('ADRIANE PEREIRA GUIMAR'#195'ES');
      fiscais.Add('ALINE CASTRO DAMASIO');
      fiscais.Add('ANA PAULA RODRIGUES CORR'#202'A GUIMAR'#195'ES');
      fiscais.Add('ANGELA RIBEIRO NEVES');
      fiscais.Add('ARIANNE FERREIRA VIEIRA');
      fiscais.Add('C'#201'SIO MALAQUIAS');
      fiscais.Add('CL'#193'UDIO NASCIMENTO SILVA');
      fiscais.Add('CL'#211'VIS RAFAEL BORGES FERREIRA');
      fiscais.Add('DANIEL SOARES BARBOSA');
      fiscais.Add('DANIELA DE ALMEIDA CASTRO');
      fiscais.Add('EDSON ARANTES FARIA FILHO');
      fiscais.Add('EDUARDO LUCAS MAGALH'#195'ES CASTRO');
      fiscais.Add('FAB'#205'OLA PEDROSA PEIXOTO MARQUES');
      fiscais.Add('GERALDO EDSON ROSA');
      fiscais.Add('GLEICIANE MARIA JOS'#201' DA SILVA');
      fiscais.Add('G'#218'BIO DIAS PEREIRA');
      fiscais.Add('JO'#195'O BATISTA LUCAS DA SILVA REIS');
      fiscais.Add('JOSE LUIZ RIBEIRO');
      fiscais.Add('JULIANA FERREIRA VITURINO');
      fiscais.Add('JULIANA K'#202'NIA MARTINS DA SILVA');
      fiscais.Add('JULIO C'#201'SAR TELES SPINDOLA');
      fiscais.Add('KAMILLA CHRYSTINE ROLIM D. SANTOS GARC'#202'S');
      fiscais.Add('LIDIANE SIM'#213'ES');
      fiscais.Add('LIVIA BRITO');
      fiscais.Add('LUCIANA CONSOLA'#199#195'O DOS SANTOS');
      fiscais.Add('LUCIANA SANTANA DA ROCHA');
      fiscais.Add('LUCIENE DE SOUZA BARBOSA GOMES SILVA');
      fiscais.Add('MARCIO HENRIQUE GOMES RODOVALHO');
      fiscais.Add('MARIA EDWIGES PINHEIRO DE SOUZA CHAVES');
      fiscais.Add('MARINA PERILLO NAVARRETE LAVERS');
      fiscais.Add('PATR'#205'CIA CORDEIRO DE MORAES E SOUZA');
      fiscais.Add('PEDRO HENRIQUE AIRES RIBEIRO');
      fiscais.Add('RODRIGO ALESSANDRO T'#212'GO SANTOS');
      fiscais.Add('R'#218'BIA MARA DE FREITAS');
      fiscais.Add('SILVIA MARQUES NAVES DA MOTA SOUZA');
      fiscais.Add('SIMONE DUARTE GROSSI');
      fiscais.Add('TATHIANE PESSOA DE SOUZA');
      fiscais.Add('THIAGO GOMES GOBO');
      fiscais.Add('VANESSA SANTANA');
      fiscais.Add('VIVIANE MANOEL DA SILVA BORGES');
      fiscais.Add('VIVIANE MIYADA');
      fiscais.Add('WANESSA DE BRITO JORGE');

      FillChar(counts, SizeOf(counts), 0);

      { Oficios }
      tboficio.Filtered := False;
      tboficio.Open;
      tboficio.First;
      while not tboficio.Eof do
      begin
        if (tboficioarchive.Value <> True)
          and (tboficiocancela.Value <> True)
          and (Copy(tboficioordem.Value, 17, 5) <> 'BAIXA')
          and not tboficioPrazo.IsNull
          and (tboficioPrazo.Value < Date) then
        begin
          idx := fiscais.IndexOf(tboficiofiscalencaminha.Value);
          if idx >= 0 then Inc(counts[idx][0]);
        end;
        tboficio.Next;
      end;

      { Requerimentos / OS }
      tbreq.Filtered := False;
      tbreq.Open;
      tbreq.First;
      while not tbreq.Eof do
      begin
        if (tbreqatendimento.Value <> True)
          and (tbreqcancelado.Value <> True)
          and (tbreqcomplexidade.Value <> 'BAIXA')
          and not tbreqPrazo.IsNull
          and (tbreqPrazo.Value < Date) then
        begin
          idx := fiscais.IndexOf(tbreqfiscal_encaminha.Value);
          if idx >= 0 then Inc(counts[idx][1]);
        end;
        tbreq.Next;
      end;

      { Denuncias }
      tbdenuncia.Filtered := False;
      tbdenuncia.Open;
      tbdenuncia.First;
      while not tbdenuncia.Eof do
      begin
        if (tbdenunciaarchive.Value <> True)
          and not tbdenunciaPrazo.IsNull
          and (tbdenunciaPrazo.Value < Date) then
        begin
          idx := fiscais.IndexOf(tbdenunciafiscalencaminha.Value);
          if idx >= 0 then Inc(counts[idx][2]);
        end;
        tbdenuncia.Next;
      end;

      { Protocolos - ADM: conta direto por carga em planta, sem cruzar tramitacao }
      tbplanta.Filtered := False;
      tbplanta.Open;
      tbplanta.First;
      while not tbplanta.Eof do
      begin
        idx := fiscais.IndexOf(tbplantaCarga.Value);
        if idx >= 0 then Inc(counts[idx][3]);
        tbplanta.Next;
      end;

      { Renderiza resumo }
      for i := 0 to fiscais.Count - 1 do
      begin
        total := counts[i][0] + counts[i][1] + counts[i][2] + counts[i][3];
        if total > 0 then
        begin
          rowIdx := sgPendencias.RowCount;
          sgPendencias.RowCount := rowIdx + 1;
          SetLength(RowColors, rowIdx);
          RowColors[rowIdx - 1] := clWhite;
          sgPendencias.Cells[0, rowIdx] := fiscais[i];
          sgPendencias.Cells[1, rowIdx] := IntToStr(counts[i][0]);
          sgPendencias.Cells[2, rowIdx] := IntToStr(counts[i][1]);
          sgPendencias.Cells[3, rowIdx] := IntToStr(counts[i][2]);
          sgPendencias.Cells[4, rowIdx] := IntToStr(counts[i][3]);
          sgPendencias.Cells[5, rowIdx] := IntToStr(total);
        end;
      end;
    finally
      fiscais.Free;
    end;

    if (sgPendencias.RowCount = 2) and (sgPendencias.Cells[0, 1] = '') then
    begin
      RowColors[0] := clInfoBk;
      sgPendencias.Cells[0, 1] := 'Nenhum fiscal com itens vencidos no momento';
      sgPendencias.Cells[1, 1] := '';
      sgPendencias.Cells[2, 1] := '';
      sgPendencias.Cells[3, 1] := '';
      sgPendencias.Cells[4, 1] := '';
      sgPendencias.Cells[5, 1] := '';
    end;
  end
  else
  begin
    { === FISCAL: detalhe por item === }
    Caption := 'Alerta de OS: ' + frmlogin.c_user;
    tboficio.Open;
    tbreq.Open;
    tbdenuncia.Open;
    tbcontrib.Open;

    { Oficios }
    tboficio.Filter := 'fiscalencaminha = ' + QuotedStr(frmlogin.c_user);
    tboficio.Filtered := True;
    tboficio.First;
    while not tboficio.Eof do
    begin
      if (tboficiofiscalencaminha.Value = frmlogin.c_user)
        and (tboficioarchive.Value <> True)
        and (tboficiocancela.Value <> True)
        and (Copy(tboficioordem.Value, 17, 5) <> 'BAIXA')
        and not tboficioPrazo.IsNull then
      begin
        if AnsiCompareText(Trim(tboficiomotivo.Value), 'RETORNO') = 0 then
          complexOficio := ''
        else
          complexOficio := Trim(Copy(tboficioordem.Value, 1, 15));
        dias := DaysBetween(Date, tboficioPrazo.Value);
        if tboficioPrazo.Value < Date then
          AddRow(
            tboficiomotivo.Value,
            IntToStr(tboficioOficio.Value),
            complexOficio,
            tboficioRegulado.Value,
            DateToStr(tboficioPrazo.Value),
            'VENCIDO h'#225' ' + IntToStr(dias) + ' dia(s)',
            CLR_VENCIDO)
        else if dias <= 5 then
          AddRow(
            tboficiomotivo.Value,
            IntToStr(tboficioOficio.Value),
            complexOficio,
            tboficioRegulado.Value,
            DateToStr(tboficioPrazo.Value),
            'Vence em ' + IntToStr(dias) + ' dia(s)',
            clYellow);
      end;
      tboficio.Next;
    end;

    { Requerimentos / OS }
    tbreq.Filter := 'fiscal_encaminha = ' + QuotedStr(frmlogin.c_user);
    tbreq.Filtered := True;
    tbreq.First;
    while not tbreq.Eof do
    begin
      if (tbreqfiscal_encaminha.Value = frmlogin.c_user)
        and (tbreqatendimento.Value <> True)
        and (tbreqcancelado.Value <> True)
        and (tbreqcomplexidade.Value <> 'BAIXA')
        and not tbreqPrazo.IsNull then
      begin
        if tbcontrib.FindKey([tbreqCodigo.Value]) then
          razaoSocial := tbcontribRazao.Value
        else
          razaoSocial := tbreqRequerente.Value;
        dias := DaysBetween(Date, tbreqPrazo.Value);
        if tbreqPrazo.Value < Date then
          AddRow(
            'REQUERIMENTO',
            IntToStr(tbreqOS.Value),
            tbreqComplexidade.Value,
            razaoSocial,
            DateToStr(tbreqPrazo.Value),
            'VENCIDO h'#225' ' + IntToStr(dias) + ' dia(s)',
            CLR_VENCIDO)
        else if dias <= 5 then
          AddRow(
            'Requerimento',
            IntToStr(tbreqOS.Value),
            tbreqComplexidade.Value,
            razaoSocial,
            DateToStr(tbreqPrazo.Value),
            'Vence em ' + IntToStr(dias) + ' dia(s)',
            clYellow);
      end;
      tbreq.Next;
    end;

    { Denuncias }
    tbdenuncia.Filter := 'fiscalencaminha = ' + QuotedStr(frmlogin.c_user);
    tbdenuncia.Filtered := True;
    tbdenuncia.First;
    while not tbdenuncia.Eof do
    begin
      if (tbdenunciafiscalencaminha.Value = frmlogin.c_user)
        and (tbdenunciaarchive.Value <> True)
        and not tbdenunciaPrazo.IsNull then
      begin
        dias := DaysBetween(Date, tbdenunciaPrazo.Value);
        if tbdenunciaPrazo.Value < Date then
          AddRow(
            'DEN'#218'NCIA',
            IntToStr(tbdenunciaDenuncia.Value),
            '',
            tbdenunciaLogradouro.Value,
            DateToStr(tbdenunciaPrazo.Value),
            'VENCIDO h'#225' ' + IntToStr(dias) + ' dia(s)',
            CLR_VENCIDO)
        else if dias <= 5 then
          AddRow(
            'DEN'#218'NCIA',
            IntToStr(tbdenunciaDenuncia.Value),
            '',
            tbdenunciaLogradouro.Value,
            DateToStr(tbdenunciaPrazo.Value),
            'Vence em ' + IntToStr(dias) + ' dia(s)',
            clYellow);
      end;
      tbdenuncia.Next;
    end;

    { Protocolos }
    tramitDates := TStringList.Create;
    try
      tbtramitacao.Open;
      tbtramitacao.Filter := 'destino = ' + QuotedStr(frmlogin.c_user);
      tbtramitacao.Filtered := True;
      tbtramitacao.First;
      while not tbtramitacao.Eof do
      begin
        protoStr := IntToStr(tbtramitacaoProtocolo.Value) + '|' + tbtramitacaoDestino.Value;
        dt := tbtramitacaoData.Value + tbtramitacaoHora.Value;
        dtStr := tramitDates.Values[protoStr];
        if (dtStr = '') or (dt > StrToFloat(dtStr)) then
          tramitDates.Values[protoStr] := FloatToStr(dt);
        tbtramitacao.Next;
      end;

      tbplanta.Open;
      tbplanta.Filter := 'carga = ' + QuotedStr(frmlogin.c_user);
      tbplanta.Filtered := True;
      tbplanta.First;
      while not tbplanta.Eof do
      begin
        protoStr := IntToStr(tbplantaProtocolo.Value);
        dtStr := tramitDates.Values[protoStr + '|' + tbplantaCarga.Value];
        if dtStr <> '' then
        begin
          lastDt := StrToFloat(dtStr);
          lastDate := Trunc(lastDt);
          deadline := AddBusinessDays(lastDate, 15);
          dias := DaysBetween(Date, deadline);
          if tbcontrib.FindKey([tbplantaCodigo.Value]) then
            razaoSocial := tbcontribRazao.Value
          else
            razaoSocial := tbplantaAssunto.Value;
          if deadline < Date then
            AddRow(
              'PROTOCOLO',
              protoStr,
              '',
              razaoSocial,
              DateToStr(deadline),
              'VENCIDO h'#225' ' + IntToStr(dias) + ' dia(s)',
              CLR_VENCIDO)
          else if dias <= 5 then
            AddRow(
              'PROTOCOLO',
              protoStr,
              '',
              razaoSocial,
              DateToStr(deadline),
              'Vence em ' + IntToStr(dias) + ' dia(s)',
              clYellow);
        end;
        tbplanta.Next;
      end;
    finally
      tramitDates.Free;
    end;

    { Caixa livre }
    if (sgPendencias.RowCount = 2) and (sgPendencias.Cells[0, 1] = '') then
    begin
      RowColors[0] := clInfoBk;
      sgPendencias.Cells[0, 1] :=
        'N'#227'o h'#225' itens vencidos ou pr'#243'ximos do vencimento na sua caixa de entrada';
      sgPendencias.Cells[1, 1] := '';
      sgPendencias.Cells[2, 1] := '';
      sgPendencias.Cells[3, 1] := '';
      sgPendencias.Cells[4, 1] := '';
      sgPendencias.Cells[5, 1] := '';
    end;
  end;
end;

procedure Tfrmpendencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tboficio.Active then tboficio.Close;
  if tbreq.Active then tbreq.Close;
  if tbdenuncia.Active then tbdenuncia.Close;
  if tbplanta.Active then tbplanta.Close;
  if tbtramitacao.Active then tbtramitacao.Close;
  if tbcontrib.Active then tbcontrib.Close;
end;

procedure Tfrmpendencia.sgPendenciasDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  txt: string;
  textRect: TRect;
  spanRect: TRect;
begin
  if ARow = 0 then
  begin
    sgPendencias.Canvas.Brush.Color := $00C8C8C8;
    sgPendencias.Canvas.Font.Style := [fsBold];
    sgPendencias.Canvas.Font.Color := clBlack;
    sgPendencias.Canvas.FillRect(Rect);
    txt := sgPendencias.Cells[ACol, ARow];
    textRect := Rect;
    InflateRect(textRect, -4, -2);
    DrawText(sgPendencias.Canvas.Handle, PChar(txt), Length(txt), textRect,
      DT_LEFT or DT_VCENTER or DT_SINGLELINE);
  end
  else if (ARow >= 1) and (ARow <= Length(RowColors)) then
  begin
    if RowColors[ARow - 1] = clInfoBk then
    begin
      sgPendencias.Canvas.Font.Style := [fsItalic];
      sgPendencias.Canvas.Font.Color := $00606060;
      if ACol = 0 then
      begin
        spanRect.Left := 0;
        spanRect.Top := Rect.Top;
        spanRect.Right := sgPendencias.ClientWidth;
        spanRect.Bottom := Rect.Bottom;
        sgPendencias.Canvas.Brush.Color := clInfoBk;
        sgPendencias.Canvas.FillRect(spanRect);
        DrawText(sgPendencias.Canvas.Handle,
          PChar(sgPendencias.Cells[0, ARow]),
          Length(sgPendencias.Cells[0, ARow]),
          spanRect,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      end
      else
      begin
        sgPendencias.Canvas.Brush.Color := clInfoBk;
        sgPendencias.Canvas.FillRect(Rect);
      end;
    end
    else
    begin
      sgPendencias.Canvas.Brush.Color := RowColors[ARow - 1];
      if RowColors[ARow - 1] = CLR_VENCIDO then
        sgPendencias.Canvas.Font.Color := clWhite
      else
        sgPendencias.Canvas.Font.Color := clBlack;
      sgPendencias.Canvas.Font.Style := [];
      sgPendencias.Canvas.FillRect(Rect);
      txt := sgPendencias.Cells[ACol, ARow];
      textRect := Rect;
      InflateRect(textRect, -4, -2);
      DrawText(sgPendencias.Canvas.Handle, PChar(txt), Length(txt), textRect,
        DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
    end;
  end
  else
  begin
    sgPendencias.Canvas.Brush.Color := clWhite;
    sgPendencias.Canvas.FillRect(Rect);
  end;
end;

function Tfrmpendencia.IsHoliday(d: TDate): Boolean;
var
  m, dy, yr: Word;
begin
  DecodeDate(d, yr, m, dy);
  Result := ((m = 1)  and (dy = 1))
         or ((m = 4)  and (dy = 21))
         or ((m = 5)  and (dy = 1))
         or ((m = 9)  and (dy = 7))
         or ((m = 10) and (dy = 12))
         or ((m = 11) and (dy = 2))
         or ((m = 11) and (dy = 15))
         or ((m = 12) and (dy = 25));
end;

function Tfrmpendencia.IsBusinessDay(d: TDate): Boolean;
begin
  Result := (DayOfWeek(d) >= 2) and (DayOfWeek(d) <= 6) and not IsHoliday(d);
end;

function Tfrmpendencia.AddBusinessDays(startDate: TDate; days: Integer): TDate;
var
  current: TDate;
  remaining: Integer;
begin
  current := startDate;
  remaining := days;
  while remaining > 0 do
  begin
    current := current + 1;
    if IsBusinessDay(current) then
      Dec(remaining);
  end;
  Result := current;
end;

end.
