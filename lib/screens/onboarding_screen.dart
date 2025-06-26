import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/onboarding/bloc/onboarding_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// * Usar pageView y traer desde la base de datos

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    BlocProvider.of<OnboardingBloc>(context).add(
      const OnboardingEventGetOnboardings(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) async {
        /* if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'loading ...',
          );
        } else {
          LoadingScreen().hide();
        } */
        if (state is OnboardingStateGetOnboardings) {
          if (state.exception != null) {
            await showErrorDialog(context, state.exception.toString());
          }
          // * Si el error es  no hay conexion hacer algo, si es no  hay onboarding
          // * pagina sign in o home desde el bloc me parece redireccionar
          /* if (state.onboardings == null || state.onboardings!.isEmpty) {
            await showErrorDialog(context,"onboarding");
    } */
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              // Handle loading state
              /* if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } */

              if (state is OnboardingStateGetOnboardings) {
                //if (state.onboardings == null) {
                if (state.onboardings == []) {
                  return const Text("No hay onboardings para mostrar");
                }
                if (state.onboardings == null) {
                  // * si es nulo es que todavia no respondio la api con la lista
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // ? como navegar con el boton
                return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount: state.onboardings!.length,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    final obd = state.onboardings![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: AppSizes.horizontalPadding,
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${(index + 1)}/${state.onboardings!.length}",
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      GoRouter.of(context).pushReplacement(
                                        AppRoutes.signInRoute,
                                      );
                                    },
                                    child: const Text(
                                      "Skip",
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 80.0),
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: SvgPicture.network(
                                  obd.imgUrl,
                                  placeholderBuilder: (context) {
                                    return const SizedBox(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/image_unavailable.png",
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Text(
                                obd.title,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                obd.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),

                          // ! esto deberia ser como elprogres bar con animacion
                          // ! y estático para mostrar convsbible
                          // ! para mostrar botones prev
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: index != 0,
                                  child: InkWell(
                                    onTap: () {
                                      if (_currentPage > 0) {
                                        _pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Prev",
                                      style: TextStyle(
                                          color: AppColors.grey2Color,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                  width: 90.0,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.onboardings!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index2) {
                                      if (index == index2) {
                                        return const CustomOnbordingRegtangle();
                                      }
                                      return const CustomOnbordingCircle();
                                    },
                                  ),
                                ),
                                index != state.onboardings!.length - 1
                                    ? CustomOnboardingTextButton(
                                        text: "Next",
                                        onTap: () {
                                          if (_currentPage <
                                              state.onboardings!.length - 1) {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                      )
                                    : CustomOnboardingTextButton(
                                        text: "Get Started",
                                        onTap: () {
                                          // ! auth state signedOut emitir este evento mejor
                                          // ? no por que
                                          /* context.read<AuthBloc>().add(
                                              const AuthEventChangeSignInPage()); */
                                          GoRouter.of(context).pushReplacement(
                                            AppRoutes.signInRoute,
                                          );
                                        },
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              /* return const Center(
                          child: Text("No hay productos -loading"),
                        ); */
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class CustomOnboardingTextButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CustomOnboardingTextButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16.0,
          color: AppColors.brandColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class CustomOnbordingCircle extends StatelessWidget {
  const CustomOnbordingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5.0),
      height: 8.0,
      width: 10.0,
      decoration: const BoxDecoration(
        color: AppColors.grey2Color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class CustomOnbordingRegtangle extends StatelessWidget {
  const CustomOnbordingRegtangle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(right: 5.0),
        height: 9.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}
