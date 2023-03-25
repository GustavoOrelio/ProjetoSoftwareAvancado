import 'package:controle_ponto/model/tipo_gestor.dart';
import 'package:controle_ponto/model/tipo_solicitacao.dart';

class Gestor {
  String nome;
  TipoGestor tipo;

  Gestor({required this.nome, required this.tipo});

  bool podeAprovarSolicitacao(TipoSolicitacao tipoSolicitacao) {
    switch (tipo) {
      case TipoGestor.NORMAL:
        return tipoSolicitacao != TipoSolicitacao.ABONO_HORAS_FALTANTES;
      case TipoGestor.ADMINISTRADOR:
        return true;
    }
  }
}