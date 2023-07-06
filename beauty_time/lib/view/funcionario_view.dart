import 'package:uuid/uuid.dart';

import '../domain/dto/funcionario_dto.dart';
import '../domain/porta/i_funcionario.dart';

class FuncionarioView {
  final FuncionarioRepository funcionarioRepository;
  final Uuid uuid;

  FuncionarioView({required this.funcionarioRepository}) : uuid = Uuid();

  Future<void> adicionarFuncionario(String nome, String cargo) async {
    var funcionario = FuncionarioDTO(id: uuid.v4(), nome: nome, cargo: cargo);
    await funcionarioRepository.adicionarFuncionario(funcionario);
  }

  Future<void> removerFuncionario(String id) async {
    await funcionarioRepository.removerFuncionario(id);
  }

  Future<List<FuncionarioDTO>> obterTodosFuncionarios() async {
    return await funcionarioRepository.obterTodosFuncionarios();
  }
}
