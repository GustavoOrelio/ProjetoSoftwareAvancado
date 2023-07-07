import 'package:flutter_sms/flutter_sms.dart';

import '../domain/porta/i_sms.dart';

class SMSServiceImpl implements SMSService {
  @override
  Future<void> enviarSMS(String numero, String mensagem) async {
    await sendSMS(message: mensagem, recipients: [numero]);
  }
}