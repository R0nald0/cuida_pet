part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {
  const _LoginRegisterButtons();

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LoginController>();
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
          onTap: () {
            controller.socialLogin(SocialLoginType.facebook);
          },
          width: .42.sw.toDouble(),
        ),
        RoundedButtonWithIcon(
          color: const Color(0xFFE15031),
          icon: FontAwesomeIcons.google,
          label: 'Google',
          onTap: () {
            controller.socialLogin(SocialLoginType.google);
          },
          width: .42.sw.toDouble(),
        ),
        RoundedButtonWithIcon(
          color: context.primaryColorDark,
          icon: FontAwesomeIcons.envelope,
          label: 'Cadastre-se',
          onTap: () {
            Modular.to.pushNamed(RouterCuidaPet.REGISTER_ROUTE);
          },
          width: .42.sw.toDouble(),
        )
      ],
    );
  }
}
