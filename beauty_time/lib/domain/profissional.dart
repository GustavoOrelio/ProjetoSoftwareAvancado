import 'package:beauty_time/domain/servico.dart';

class Profissional {
  final String id;
  final String nome;
  final List<Servico> servicos;

  Profissional({required this.id, required this.nome, required this.servicos});
}