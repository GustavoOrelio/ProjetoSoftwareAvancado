import 'package:beauty_time/domain/dto/cliente_dto.dart';

abstract class ClienteRepository {
  Future<void> saveCliente(ClienteDTO cliente);

  Future<List<ClienteDTO>> getClientes();

  Future<ClienteDTO> getCliente(int id);

  Future<void> updateCliente(ClienteDTO cliente);

  Future<void> deleteCliente(int id);
}
