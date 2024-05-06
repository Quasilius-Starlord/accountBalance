import 'package:intl/intl.dart';

String formatNumber(int num){
  return NumberFormat("#,##0.00", "en_US").format(num);
}