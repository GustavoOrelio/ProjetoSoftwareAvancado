import 'package:beauty_time/domain/profissional.dart';
import 'package:beauty_time/domain/servico.dart';
import 'package:beauty_time/domain/cliente.dart';

class Agendamento {
  final String id;
  final Cliente cliente;
  final Profissional profissional;
  final Servico servico;
  final DateTime data;

  Agendamento({required this.id, required this.cliente, required this.profissional, required this.servico, required this.data});
}