import 'package:beauty_time/domain/dto/cliente_dto.dart';

abstract class ClienteRepository {
  Future<void> adicionarCliente(ClienteDTO cliente);

  Future<void> removerCliente(String id);

  Future<List<ClienteDTO>> obterTodosClientes();

  Future<ClienteDTO> obterClientePorId(String id);
}
