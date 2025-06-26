import 'package:flu_go_jwt/design/foundations/app_images.dart';
import 'package:flu_go_jwt/screens/auth/widgets/custom_provider_button_svg.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowProvidersButtons extends StatefulWidget {
  const ShowProvidersButtons({super.key});

  @override
  State<ShowProvidersButtons> createState() => _ShowProvidersButtonsState();
}

class _ShowProvidersButtonsState extends State<ShowProvidersButtons> {
  @override
  Widget build(BuildContext context) {
    return

        /// * Da error cuando los elementos estan en una sola fila
        Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomProviderButtonSvg(
              imagePath: AppImages.googleIconSvg,
              onTap: () {
                context.read<AuthBloc>().add(const AuthEventGoogleSignIn());
              },
            ),
            CustomProviderButtonSvg(
              imagePath: AppImages.appleIconSvg,
              onTap: () {},
            ),
            CustomProviderButtonSvg(
              imagePath: AppImages.facebookIconSvg,
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomProviderButtonSvg(
              imagePath: AppImages.microsoftIconSvg,
              onTap: () {},
            ),
            CustomProviderButtonSvg(
              imagePath: AppImages.twitterIconSvg,
              onTap: () {},
            ),
            CustomProviderButtonSvg(
              imagePath: AppImages.gitubIconSvg,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
