import 'package:flutter_sms/flutter_sms.dart';

import '../domain/porta/i_sms_service.dart';

class SMSServiceImpl implements ISmsService {
  @override
  Future<void> enviarSMS(String numero, String mensagem) async {
    await sendSMS(message: mensagem, recipients: [numero]);
  }
}
