program wcvs;

uses
  Forms,
  login in 'login.pas' {frmlogin},
  LOCPRO in 'LOCPRO.PAS' {frmlocpro},
  Principal in 'PRINCIPAL.PAS' {frmprincipal},
  ESTABE in 'ESTABE.pas' {frmestabe},
  sobre in 'SOBRE.PAS' {AboutBox},
  denuncia in 'denuncia.pas' {frmdenuncia},
  CPFeCGC in 'CPFeCGC.pas',
  f_relaespecifica in 'f_relaespecifica.pas' {frmrelespecifica},
  f_relativ in 'f_relativ.pas' {frmrelativ},
  relaespecifica in 'relaespecifica.pas' {rel_especifica},
  relativ in 'relativ.pas' {rel_atividade},
  atendimento in 'atendimento.pas' {frmatendimento},
  what in 'what.pas' {f_what},
  consolidado in 'consolidado.pas' {frmconso},
  r_rmpf in 'r_rmpf.pas' {rel_rmpf},
  r_pend in 'r_pend.pas' {rel_pen},
  alvnovo in 'alvnovo.pas' {frmalvnovo},
  memo in 'memo.pas',
  alveicular in 'alveicular.pas' {frmalveicular},
  r_retorno in 'r_retorno.pas' {frmretorno},
  relretorno in 'relretorno.pas' {Rel_retorno},
  alvara in 'alvara.pas' {frmalvara},
  rdpf in 'rdpf.pas' {frmrdpf},
  relvisita in 'relvisita.pas' {rel_visita},
  LOCPRO2 in 'LOCPRO2.PAS' {frmlocpro2},
  denpend in 'denpend.pas' {FrmDenPen},
  r_den in 'r_den.pas' {rel_den},
  os in 'os.pas' {frmOs},
  LOCPRO3 in 'LOCPRO3.PAS' {frmlocpro3},
  r_os in 'r_os.pas' {rel_os},
  reldenuncia in 'reldenuncia.pas' {Rel_ptden},
  locden in 'locden.pas' {frmlocden},
  locreq in 'locreq.pas' {frmlocOS},
  reladenuncias in 'reladenuncias.pas' {rel_denpen},
  LOCPRO4 in 'LOCPRO4.PAS' {frmlocpro4},
  r_rpdf in 'r_rpdf.pas' {rel_rdpf},
  r_rcon in 'r_rcon.pas' {rel_rcon},
  relarequerimento in 'relarequerimento.pas' {rel_req},
  relptos in 'relptos.pas' {rel_ptos},
  relprotocolo in 'relprotocolo.pas' {rel_protocolo},
  relremessa in 'relremessa.pas' {rel_remessa},
  r_fiscal in 'r_fiscal.pas' {frmfiscal},
  reljuntada in 'reljuntada.pas' {rel_juntada},
  rdpfvelho in 'rdpfvelho.pas' {frmrdpfvelho},
  relrequerimento in 'relrequerimento.pas' {rel_requer},
  r_old in 'r_old.pas' {rel_old},
  r_controle in 'r_controle.pas' {rel_controle},
  oficio in 'oficio.pas' {frmoficio},
  locof in 'locof.pas' {frmlocOF},
  relofpen in 'relofpen.pas' {rel_ofpen},
  relptof in 'relptof.pas' {rel_ptoficio},
  relptpen in 'relptpen.pas' {rel_ptpen},
  r_doc in 'r_doc.pas' {rel_doc},
  r_oficio in 'r_oficio.pas' {frmosof},
  relaoficio in 'relaoficio.pas' {rel_ofi},
  gera in 'gera.pas' {frmgera},
  pendencia in 'pendencia.pas' {frmpendencia},
  relretpen in 'relretpen.pas' {rel_retpen},
  consultapt in 'consultapt.pas' {frmconpt},
  r_protocolo in 'r_protocolo.pas' {frmospt},
  r_fisden in 'r_fisden.pas' {frmfisden},
  uExportarJsonCVS_Shared in 'uExportarJsonCVS_Shared.pas',
  uExportarMenor in 'uExportarMenor.pas',
  uExportCSV in 'uExportCSV.pas',
  ParamLogin in 'ParamLogin.pas' {frmParamLogin},
  ParamBairro in 'ParamBairro.pas' {frmParamBairro},
  ParamCnae in 'ParamCnae.pas' {frmParamCnae};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrmlogin, frmlogin);
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.CreateForm(Tfrmlocpro, frmlocpro);
  Application.CreateForm(Tfrmestabe, frmestabe);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(Tfrmdenuncia, frmdenuncia);
  Application.CreateForm(Tfrmrelespecifica, frmrelespecifica);
  Application.CreateForm(Tfrmrelativ, frmrelativ);
  Application.CreateForm(Trel_especifica, rel_especifica);
  Application.CreateForm(Trel_atividade, rel_atividade);
  Application.CreateForm(Tfrmatendimento, frmatendimento);
  Application.CreateForm(Tf_what, f_what);
  Application.CreateForm(Tfrmconso, frmconso);
  Application.CreateForm(Trel_rmpf, rel_rmpf);
  Application.CreateForm(Trel_pen, rel_pen);
  Application.CreateForm(Tfrmalvnovo, frmalvnovo);
  Application.CreateForm(Tfrmalveicular, frmalveicular);
  Application.CreateForm(Tfrmretorno, frmretorno);
  Application.CreateForm(TRel_retorno, Rel_retorno);
  Application.CreateForm(Tfrmalvara, frmalvara);
  Application.CreateForm(Tfrmrdpf, frmrdpf);
  Application.CreateForm(Trel_visita, rel_visita);
  Application.CreateForm(Tfrmlocpro2, frmlocpro2);
  Application.CreateForm(TFrmDenPen, FrmDenPen);
  Application.CreateForm(Trel_den, rel_den);
  Application.CreateForm(TfrmOs, frmOs);
  Application.CreateForm(Tfrmlocpro3, frmlocpro3);
  Application.CreateForm(Trel_os, rel_os);
  Application.CreateForm(TRel_ptden, Rel_ptden);
  Application.CreateForm(Tfrmlocden, frmlocden);
  Application.CreateForm(TfrmlocOS, frmlocOS);
  Application.CreateForm(Trel_denpen, rel_denpen);
  Application.CreateForm(Tfrmlocpro4, frmlocpro4);
  Application.CreateForm(Trel_rdpf, rel_rdpf);
  Application.CreateForm(Trel_rcon, rel_rcon);
  Application.CreateForm(Trel_req, rel_req);
  Application.CreateForm(Trel_ptos, rel_ptos);
  Application.CreateForm(Trel_protocolo, rel_protocolo);
  Application.CreateForm(Trel_remessa, rel_remessa);
  Application.CreateForm(Tfrmfiscal, frmfiscal);
  Application.CreateForm(Trel_juntada, rel_juntada);
  Application.CreateForm(Tfrmrdpfvelho, frmrdpfvelho);
  Application.CreateForm(Trel_requer, rel_requer);
  Application.CreateForm(Trel_old, rel_old);
  Application.CreateForm(Trel_controle, rel_controle);
  Application.CreateForm(Tfrmoficio, frmoficio);
  Application.CreateForm(TfrmlocOF, frmlocOF);
  Application.CreateForm(Trel_ofpen, rel_ofpen);
  Application.CreateForm(Trel_ptoficio, rel_ptoficio);
  Application.CreateForm(Trel_ptpen, rel_ptpen);
  Application.CreateForm(Trel_doc, rel_doc);
  Application.CreateForm(Tfrmosof, frmosof);
  Application.CreateForm(Trel_ofi, rel_ofi);
  Application.CreateForm(Tfrmgera, frmgera);
  Application.CreateForm(Tfrmpendencia, frmpendencia);
  Application.CreateForm(Trel_retpen, rel_retpen);
  Application.CreateForm(Tfrmconpt, frmconpt);
  Application.CreateForm(Tfrmospt, frmospt);
  Application.CreateForm(Tfrmfisden, frmfisden);
  Application.CreateForm(TfrmParamLogin, frmParamLogin);
  Application.CreateForm(TfrmParamBairro, frmParamBairro);
  Application.CreateForm(TfrmParamCnae, frmParamCnae);
  Application.Run;
end.
