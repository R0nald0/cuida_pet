part of '../login_page.dart';
class _LoginRegisterButtons extends StatelessWidget {

  const _LoginRegisterButtons({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      alignment: WrapAlignment.center,
      runSpacing: 10,
      children: [
        RoundedButtonWithIcon(
          color: const Color(0xFF4267b3),
           icon: FontAwesomeIcons.facebook, 
          label: 'Facebook', 
          onTap: (){},
          width: .42.sw.toDouble(),
          ),
          RoundedButtonWithIcon(
          color: const Color(0xFFE15031),
           icon: FontAwesomeIcons.google, 
          label: 'Google', 
          onTap: (){},
          width: .42.sw.toDouble(),
          ),
          RoundedButtonWithIcon(
          color: context.primaryColorDark,
           icon: FontAwesomeIcons.envelope, 
          label: 'Cadastre-se', 
          onTap: (){
            Modular.to.pushNamed('/auth/register/');
          },
          width: .42.sw.toDouble(),
          )
      ],
    );
  }
}