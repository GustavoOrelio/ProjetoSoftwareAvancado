import 'package:uuid/uuid.dart';

import '../domain/dto/servico_dto.dart';
import '../domain/porta/i_servico.dart';

class ServicoView {
  final ServicoRepository servicoRepository;
  final Uuid uuid;

  ServicoView({required this.servicoRepository}) : uuid = Uuid();

  Future<void> adicionarServico(String nome, double preco) async {
    var servico = ServicoDTO(id: uuid.v4(), nome: nome, preco: preco);
    await servicoRepository.adicionarServico(servico);
  }

  Future<void> removerServico(String id) async {
    await servicoRepository.removerServico(id);
  }

  Future<List<ServicoDTO>> obterTodosServicos() async {
    return await servicoRepository.obterTodosServicos();
  }
}
