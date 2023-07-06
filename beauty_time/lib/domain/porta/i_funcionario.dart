import '../dto/funcionario_dto.dart';

abstract class FuncionarioRepository {
  Future<void> adicionarFuncionario(FuncionarioDTO funcionario);

  Future<void> removerFuncionario(String id);

  Future<List<FuncionarioDTO>> obterTodosFuncionarios();
}
