
import 'package:intl/intl.dart';

class TextFormatter {
  
   static final  _fotmatPatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: r'R$'
   );

   TextFormatter._();
   static String formatReal(double value) => _fotmatPatter.format(value);

}