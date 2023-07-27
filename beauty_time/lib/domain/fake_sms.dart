import 'package:beauty_time/domain/porta/i_sms_service.dart';

class FakeSmsService implements ISmsService {
  @override
  Future<void> enviarSMS(String numero, String mensagem) async {
    print('Enviando SMS para $numero: $mensagem');
  }
}