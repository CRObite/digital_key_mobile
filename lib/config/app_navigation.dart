import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/screens/chat_pages/chat_page.dart';
import 'package:web_com/screens/faq_pages/faq_page.dart';
import 'package:web_com/screens/favourite_pages/favourite_page.dart';
import 'package:web_com/screens/finance_pages/finance_page.dart';
import 'package:web_com/screens/news_pages/news_page.dart';
import 'package:web_com/screens/office_pages/office_page.dart';
import 'package:web_com/screens/report_pages/report_page.dart';
import 'package:web_com/screens/review_pages/review_page.dart';
import 'package:web_com/screens/service_pages/service_page.dart';

import '../screens/authorization_pages/login_page.dart';
import '../screens/authorization_pages/password_recovery.dart';
import '../screens/authorization_pages/registration_page.dart';
import '../screens/authorization_pages/registration_second_page.dart';
import '../screens/navigation_page/navigation_page.dart';

class AppNavigation{

  static String initR = '/loginPage';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorReview = GlobalKey<NavigatorState>(debugLabel: 'shellReview');
  static final _rootNavigatorOffice = GlobalKey<NavigatorState>(debugLabel: 'shellOffice');
  static final _rootNavigatorFinance = GlobalKey<NavigatorState>(debugLabel: 'shellFinance');
  static final _rootNavigatorServices = GlobalKey<NavigatorState>(debugLabel: 'shellServices');
  static final _rootNavigatorReport = GlobalKey<NavigatorState>(debugLabel: 'shellReport');
  static final _rootNavigatorFavorite = GlobalKey<NavigatorState>(debugLabel: 'shellFavorite');
  static final _rootNavigatorFaq = GlobalKey<NavigatorState>(debugLabel: 'shellFaq');
  static final _rootNavigatorNews = GlobalKey<NavigatorState>(debugLabel: 'shellNews');

  BuildContext? navigationContext;


  static final GoRouter router = GoRouter(
      initialLocation: initR,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[

        GoRoute(
          path: '/chatPage',
          name: 'chatPage',
          builder: (context,state){
            return ChatPage(
              key: state.pageKey,
            );
          },
        ),

        GoRoute(
          path: '/loginPage',
          name: 'loginPage',
          builder: (context,state){
            return LoginPage(
              key: state.pageKey,
            );
          },
          routes: [
            GoRoute(
              path: 'passwordRecovery',
              name: 'passwordRecovery',
              builder: (context,state){
                return PasswordRecovery(
                  key: state.pageKey,
                );
              },
            ),

            GoRoute(
              path: 'registrationPage',
              name: 'registrationPage',
              builder: (context,state){
                return RegistrationPage(
                  key: state.pageKey,
                );
              },
              routes: [
                GoRoute(
                  path: 'registrationSecondPage',
                  name: 'registrationSecondPage',
                  builder: (context,state){

                    String name = '';
                    String phone = '';
                    String iin = '';
                    bool partner = false;
                    String type = '';

                    if(state.extra != null){
                      final extras = state.extra as Map<String, dynamic>;
                      name = extras['name'];
                      phone = extras['phone'];
                      iin = extras['iin'];
                      partner = extras['partner'];
                      type = extras['type'];
                    }

                    return RegistrationSecondPage(
                      key: state.pageKey,
                      name: name,
                      phone: phone,
                      iin: iin,
                      partner: partner,
                      type: type,
                    );
                  },
                ),

              ]
            ),
          ]
        ),

        StatefulShellRoute.indexedStack(
            builder: (context,state,navigationShell){
              return NavigationPage(
                navigationShell: navigationShell,
              );
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                navigatorKey: _rootNavigatorReview,
                routes: [
                  GoRoute(
                      path: '/reviewPage',
                      name: 'reviewPage',
                      builder: (context,state){
                        return ReviewPage(
                          key: state.pageKey,
                        );
                      },
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorOffice,
                routes: [
                  GoRoute(
                    path: '/officePage',
                    name: 'officePage',
                    builder: (context,state){
                      return OfficePage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorFinance,
                routes: [
                  GoRoute(
                    path: '/financePage',
                    name: 'financePage',
                    builder: (context,state){
                      return FinancePage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _rootNavigatorServices,
                routes: [
                  GoRoute(
                    path: '/servicePage',
                    name: 'servicePage',
                    builder: (context,state){
                      return ServicePage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),

              StatefulShellBranch(
                navigatorKey: _rootNavigatorReport,
                routes: [
                  GoRoute(
                    path: '/reportPage',
                    name: 'reportPage',
                    builder: (context,state){
                      return ReportPage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),

              StatefulShellBranch(
                navigatorKey: _rootNavigatorFavorite,
                routes: [
                  GoRoute(
                    path: '/favouritePage',
                    name: 'favouritePage',
                    builder: (context,state){
                      return FavouritePage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),

              StatefulShellBranch(
                navigatorKey: _rootNavigatorFaq,
                routes: [
                  GoRoute(
                    path: '/faqPage',
                    name: 'faqPage',
                    builder: (context,state){
                      return FaqPage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),

              StatefulShellBranch(
                navigatorKey: _rootNavigatorNews,
                routes: [
                  GoRoute(
                    path: '/newsPage',
                    name: 'newsPage',
                    builder: (context,state){
                      return NewsPage(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),
            ]
        )
      ]
  );
}
