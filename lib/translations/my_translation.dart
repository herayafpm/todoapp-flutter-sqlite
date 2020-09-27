import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello_world': 'Hello World',
          'empty_data': 'Empty Data',
          'empty_title': 'Empty Title'
        },
        'id_ID': {
          'hello_world': 'Halo Dunia',
          'empty_data': 'Data kosong',
          'empty_title': 'Judul Kosong'
        }
      };
}
