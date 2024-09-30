import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';

import '../../widgets/expanded_button.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> with SingleTickerProviderStateMixin {

  bool goSecond = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully visible
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBlue,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: OvalTopContainer(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if (!goSecond)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Добро пожаловать в Webcom',
                                style: TextStyle(
                                  color: AppColors.secondaryGreyDarker,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Webcom Kazakhstan - независимое digital-агентство в Казахстане',
                                style: TextStyle(
                                  color: AppColors.secondaryGreyDarker,
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (goSecond)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Анализируйте эффектность вашей ракламы',
                                style: TextStyle(
                                  color: AppColors.secondaryGreyDarker,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Алгоритмы сквозной аналитики отображают статистику по рекламным сетям и кампаниям',
                                style: TextStyle(
                                  color: AppColors.secondaryGreyDarker,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Stack(
                    key: ValueKey<bool>(goSecond),
                    children: [
                      if (!goSecond)
                        ...[
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width * 0.03,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/apple_card.png'),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: MediaQuery.of(context).size.height * 0.25,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/dv_card.png'),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.27,
                            left: 0,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/google_card.png'),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.15,
                            left: MediaQuery.of(context).size.width * 0.5,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/meta_card.png'),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.05,
                            left: MediaQuery.of(context).size.width * 0.6,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/tik_tok_card.png'),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.32,
                            left: MediaQuery.of(context).size.width * 0.5,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/yandex_card.png'),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.08,
                            left: MediaQuery.of(context).size.width * 0.14,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/vk_card.png'),
                            ),
                          ),
                        ],
                      if (goSecond)
                        ...[
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.2,
                            right: MediaQuery.of(context).size.width * 0.08,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/board_second_card.png'),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.02,
                            left: MediaQuery.of(context).size.width * 0.08,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Image.asset('assets/images/board_first_card.png'),
                            ),
                          ),
                        ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ExpandedButton(
            onPressed: () async {

              if(!goSecond){
                setState(() {
                  goSecond = true;
                  _animationController.reset();
                  _animationController.forward();
                });
              }else{
                SharedPreferencesOperator.saveOnBoardStatus(true);
                if(await SharedPreferencesOperator.containsCurrentUser()){
                  context.goNamed('reviewStatistics');
                }else{
                  context.goNamed('loginPage');
                }
              }
            },
            child: const Text(
              'Далее',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class OvalTopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child;

  const OvalTopContainer({super.key, required this.height, required this.width, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalTopClipper(),
      child: Container(
        height: height,
        width: width,
        color: color,
        child: child,
      ),
    );
  }
}

class OvalTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height * 0.25);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
