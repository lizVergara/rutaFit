import 'package:get/get.dart';

class HomeNavController extends GetxController {
  RxInt index = 0.obs;
  void changePage(int i) => index.value = i;
}
