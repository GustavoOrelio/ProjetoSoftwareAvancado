abstract class ISmsService {
  Future<void> enviarSMS(String numero, String mensagem);
}
