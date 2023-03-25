import 'package:controle_ponto/model/funcionario.dart';
import 'package:controle_ponto/model/tipo_solicitacao.dart';

class Solicitacao {
  Funcionario funcionario;
  TipoSolicitacao tipo;
  String justificativa;
  String anexo;
  bool aprovada = false;

  Solicitacao(
      {required this.funcionario,
        required this.tipo,
        required this.justificativa,
        required this.anexo});
}