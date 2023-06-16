import 'package:beauty_time/domain/dto/servico_dto.dart';

abstract class ServicoRepository {
  Future<void> saveServico(ServicoDTO servico);

  Future<List<ServicoDTO>> getServicos();

  Future<ServicoDTO> getServico(int id);

  Future<void> updateServico(ServicoDTO servico);

  Future<void> deleteServico(int id);
}
