import 'package:cuidapet/app/module/register/register_controller.dart';
import 'package:cuidapet/core/constants.dart';
import 'package:cuidapet/core/ui/extensions/size_screenn_extension.dart';
import 'package:cuidapet/core/ui/widgets/cuidaper_text_form_field.dart';
import 'package:cuidapet/core/ui/widgets/cuidapet_default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validatorless/validatorless.dart';
    

 part 'widgets/form_register.dart';   
class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key }) :super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Center(
          child:  FaIcon(FontAwesomeIcons.chevronLeft),
        ),
      ),
      body:  SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20),
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
              const SizedBox(
                 height: 20,
              ),
               const _FormRegister()
               
                ],
               ),
        ),
      ),
    );
  }
}