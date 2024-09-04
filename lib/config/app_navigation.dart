import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/screens/chat_pages/chat_page.dart';
import 'package:web_com/screens/faq_pages/faq_page.dart';
import 'package:web_com/screens/favourite_pages/favourite_page.dart';
import 'package:web_com/screens/finance_pages/finance_page.dart';
import 'package:web_com/screens/news_pages/news_page.dart';
import 'package:web_com/screens/report_pages/report_page.dart';
import 'package:web_com/screens/review_pages/review_page.dart';
import 'package:web_com/screens/service_pages/service_page.dart';

import '../screens/authorization_pages/login_page.dart';
import '../screens/authorization_pages/password_recovery.dart';
import '../screens/authorization_pages/registration_page.dart';
import '../screens/authorization_pages/registration_second_page.dart';
import '../screens/navigation_page/navigation_page.dart';
import '../screens/review_pages/inner_pages/cabinet_details.dart';
import '../screens/review_pages/inner_pages/contract_creating_page.dart';
import '../screens/review_pages/inner_pages/enrollment_history.dart';
import '../screens/review_pages/inner_pages/new_operation.dart';
import '../screens/review_pages/inner_pages/review_office.dart';
import '../screens/review_pages/inner_pages/review_profile.dart';
import '../screens/review_pages/inner_pages/review_statistics.dart';

class AppNavigation{


  static Future<void> checkCurrentUser() async {



    if(await SharedPreferencesOperator.containsCurrentUser()){
      initR = '/reviewStatistics';
    }
  }


  static String initR = '/loginPage';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorReview = GlobalKey<NavigatorState>(debugLabel: 'shellReview');
  static final _rootNavigatorFinance = GlobalKey<NavigatorState>(debugLabel: 'shellFinance');
  static final _rootNavigatorServices = GlobalKey<NavigatorState>(debugLabel: 'shellServices');
  static final _rootNavigatorReport = GlobalKey<NavigatorState>(debugLabel: 'shellReport');
  static final _rootNavigatorFavorite = GlobalKey<NavigatorState>(debugLabel: 'shellFavorite');
  static final _rootNavigatorFaq = GlobalKey<NavigatorState>(debugLabel: 'shellFaq');
  static final _rootNavigatorNews = GlobalKey<NavigatorState>(debugLabel: 'shellNews');


  // review inner pages
  static final _rootReviewStatistics = GlobalKey<NavigatorState>(debugLabel: 'shellReviewStatistics');
  static final _rootReviewOffice = GlobalKey<NavigatorState>(debugLabel: 'shellReviewOffice');
  static final _rootReviewProfile = GlobalKey<NavigatorState>(debugLabel: 'shellReviewProfile');

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

                  StatefulShellRoute.indexedStack(
                      builder: (context, state, navigationShell) {
                        return ReviewPage(
                          navigationShell: navigationShell,
                        );
                      },
                      branches: <StatefulShellBranch>[
                        StatefulShellBranch(
                          navigatorKey: _rootReviewStatistics,
                          routes: [
                            GoRoute(
                              path: '/reviewStatistics',
                              name: 'reviewStatistics',
                              builder: (context,state){
                                return ReviewStatistics(
                                  key: state.pageKey,
                                );
                              },
                            )
                          ],
                        ),
                        StatefulShellBranch(
                          navigatorKey: _rootReviewOffice,
                          routes: [
                            GoRoute(
                              path: '/reviewOffice',
                              name: 'reviewOffice',
                              builder: (context,state){
                                return ReviewOffice(
                                  key: state.pageKey,
                                );
                              },
                            )
                          ],
                        ),
                        StatefulShellBranch(
                          navigatorKey: _rootReviewProfile,
                          routes: [
                            GoRoute(
                              path: '/reviewProfile',
                              name: 'reviewProfile',
                              builder: (context,state){
                                return ReviewProfile(
                                  key: state.pageKey,
                                );
                              },
                              routes: [
                                GoRoute(
                                  path: 'contractCreatingPage',
                                  name: 'contractCreatingPage',
                                  builder: (context,state){
                                    return ContractCreatingPage(
                                      key: state.pageKey,
                                    );
                                  },
                                )

                              ]
                            )
                          ],
                        ),
                      ]
                  ),
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

              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/enrollmentHistory',
                    name: 'enrollmentHistory',
                    builder: (context,state){
                      return EnrollmentHistory(
                        key: state.pageKey,
                      );
                    },
                  ),
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: '/cabinetDetails',
                      name: 'cabinetDetails',
                      builder: (context,state){
                        return  CabinetDetails(
                          key: state.pageKey,
                        );
                      },
                  )
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/newOperation',
                    name: 'newOperation',
                    builder: (context,state){
                      return  NewOperation(
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
