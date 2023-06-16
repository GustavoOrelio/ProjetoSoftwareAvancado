import 'package:beauty_time/domain/dto/funcionario_dto.dart';

abstract class FuncionarioRepository {
  Future<void> saveFuncionario(FuncionarioDTO funcionario);

  Future<List<FuncionarioDTO>> getFuncionarios();

  Future<FuncionarioDTO> getFuncionario(int id);

  Future<void> updateFuncionario(FuncionarioDTO funcionario);

  Future<void> deleteFuncionario(int id);
}
