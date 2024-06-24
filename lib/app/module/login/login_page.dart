

import 'package:cuidapet/app/module/login/login_controller.dart';
import 'package:cuidapet/core/helpers/enviroments.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:cuidapet/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet/core/ui/widgets/cuidaper_text_form_field.dart';
import 'package:cuidapet/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validatorless/validatorless.dart';
part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
         child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              
              
              SizedBox(height: 50.h.toDouble()),
              Center(
                child: Image.asset(
                  Constants.logo,
                  width: 163.w.toDouble(),
                  fit: BoxFit.fill,
                  ),
              ),
              Text(Enviroments.params('BASE_URL') ?? ''),
              const SizedBox(height: 20,),
               const _LoginForm(),
               const SizedBox(height: 10,),
               const _OrSepareto(),
               const SizedBox(height: 20,),
               const _LoginRegisterButtons()
            ],
          ),
          ),
      )
    );
  }
}

class _OrSepareto extends StatelessWidget {

  const _OrSepareto({ super.key });

   @override
   Widget build(BuildContext context) {
       return  Row(
        children: [
             const Expanded(
               child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
               ),
             ),
            
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('OU',
               style: TextStyle(
                color: context.primaryColor,
                fontSize: 20.sp.toDouble(),
                fontWeight: FontWeight.bold
               ),
               ),
             ),
            
              const Expanded(
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                thickness: 1,
                             ),
              ),
            
        ],
       );
  }
}