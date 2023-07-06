import '../domain/dto/cliente_dto.dart';
import '../domain/porta/i_cliente.dart';
import 'package:uuid/uuid.dart';

class ClienteView {
  final ClienteRepository clienteRepository;

  final Uuid uuid;

  ClienteView({required this.clienteRepository}) : uuid = Uuid();

  Future<void> adicionarCliente(String nome, String telefone) async {
    var cliente = ClienteDTO(id: uuid.v4(), nome: nome, telefone: telefone);
    await clienteRepository.adicionarCliente(cliente);
  }

  Future<void> removerCliente(String id) async {
    await clienteRepository.removerCliente(id);
  }

  Future<List<ClienteDTO>> obterTodosClientes() async {
    return await clienteRepository.obterTodosClientes();
  }
}
