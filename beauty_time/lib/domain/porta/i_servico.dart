import '../dto/servico_dto.dart';

abstract class ServicoRepository {
  Future<void> adicionarServico(ServicoDTO servico);

  Future<void> removerServico(String id);

  Future<List<ServicoDTO>> obterTodosServicos();
}
