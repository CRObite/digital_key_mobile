import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/domain/service_operation.dart';
import 'package:web_com/screens/chat_pages/chat_page.dart';
import 'package:web_com/screens/faq_pages/faq_page.dart';
import 'package:web_com/screens/favourite_pages/favourite_page.dart';
import 'package:web_com/screens/finance_pages/finance_page.dart';
import 'package:web_com/screens/finance_pages/inner_pages/finance_documents.dart';
import 'package:web_com/screens/finance_pages/inner_pages/finance_payment.dart';
import 'package:web_com/screens/news_pages/news_page.dart';
import 'package:web_com/screens/report_pages/report_page.dart';
import 'package:web_com/screens/review_pages/review_page.dart';
import 'package:web_com/screens/service_pages/service_page.dart';

import '../domain/invoice.dart';
import '../screens/authorization_pages/login_page.dart';
import '../screens/authorization_pages/password_recovery.dart';
import '../screens/authorization_pages/registration_page.dart';
import '../screens/authorization_pages/registration_second_page.dart';
import '../screens/cabinet_replenishment/cabinet_replenishment.dart';
import '../screens/finance_pages/inner_pages/invoice_details.dart';
import '../screens/navigation_page/navigation_page.dart';
import '../screens/notification_page/notification_page.dart';
import '../screens/onboard_pages/onboard_page.dart';
import '../screens/profile_pages/profile_edit.dart';
import '../screens/profile_pages/profile_screen.dart';
import '../screens/review_pages/inner_pages/cabinet_details.dart';
import '../screens/review_pages/inner_pages/contract_creating_page.dart';
import '../screens/review_pages/inner_pages/enrollment_history.dart';
import '../screens/review_pages/inner_pages/new_operation.dart';
import '../screens/review_pages/inner_pages/review_office.dart';
import '../screens/review_pages/inner_pages/review_profile.dart';
import '../screens/review_pages/inner_pages/review_statistics.dart';
import '../screens/review_pages/inner_pages/statistic_details.dart';

class AppNavigation{


  static Future<void> changePathByStatus() async {

    if(await SharedPreferencesOperator.getOnBoardStatus()){
      if(await SharedPreferencesOperator.containsCurrentUser()){
        initR = '/reviewStatistics';
      }
    }else{
      initR = '/onboardPage';
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

  //finance inner pages
  static final _rootFinancePayments = GlobalKey<NavigatorState>(debugLabel: 'shellFinancePayments');
  static final _rootFinanceDocuments = GlobalKey<NavigatorState>(debugLabel: 'shellFinanceDocuments');

  BuildContext? navigationContext;



  static final GoRouter router = GoRouter(
      initialLocation: initR,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[


        GoRoute(
          path: '/onboardPage',
          name: 'onboardPage',
          builder: (context,state){
            return OnboardPage(
              key: state.pageKey,
            );
          },
        ),


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
          path: '/notificationPage',
          name: 'notificationPage',
          builder: (context,state){
            return NotificationPage(
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

                  StatefulShellRoute.indexedStack(
                      builder: (context, state, navigationShell) {
                        return FinancePage(
                          navigationShell: navigationShell,
                        );
                      },
                      branches: <StatefulShellBranch>[
                        StatefulShellBranch(
                          navigatorKey: _rootFinancePayments,
                          routes: [
                            GoRoute(
                              path: '/financePayment',
                              name: 'financePayment',
                              builder: (context,state){
                                return FinancePayment(
                                  key: state.pageKey,
                                );
                              },
                            )
                          ],
                        ),
                        StatefulShellBranch(
                          navigatorKey: _rootFinanceDocuments,
                          routes: [
                            GoRoute(
                              path: '/financeDocuments',
                              name: 'financeDocuments',
                              builder: (context,state){
                                return FinanceDocuments(
                                  key: state.pageKey,
                                );
                              },
                            )
                          ],
                        ),
                      ]
                  ),
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

                      ClientContractService? ccs;

                      if(state.extra != null){
                        final extras = state.extra as Map<String, dynamic>;
                        ccs = extras['ccs'] as ClientContractService;
                      }

                      return EnrollmentHistory(
                        key: state.pageKey,
                        ccs: ccs!,
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

                        ClientContractService? cabinet;

                        if(state.extra != null){
                          final extras = state.extra as Map<String, dynamic>;
                          cabinet = extras['cabinet'] as ClientContractService;
                        }

                        return  CabinetDetails(
                          key: state.pageKey,
                          ccs: cabinet!,
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

                      ServiceOperation? operation;

                      if(state.extra != null){
                        final extras = state.extra as Map<String, dynamic>;
                        operation = extras['operation'] as ServiceOperation;
                      }

                      return  NewOperation(
                        key: state.pageKey,
                        operation: operation,
                      );
                    },
                  )
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/statisticDetails',
                    name: 'statisticDetails',
                    builder: (context,state){
                      return StatisticDetails(
                        key: state.pageKey,
                      );
                    },
                  )
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/profileScreen',
                    name: 'profileScreen',
                    builder: (context,state){
                      return ProfileScreen(
                        key: state.pageKey,
                      );
                    },
                    routes: [
                      GoRoute(
                          path: 'profileEdit',
                          name: 'profileEdit',
                          builder: (context,state){
                            return ProfileEdit(
                              key: state.pageKey,
                            );
                          },
                      )
                    ]
                  )
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: '/cabinetReplenishment',
                      name: 'cabinetReplenishment',
                      builder: (context,state){
                        return CabinetReplenishment(
                          key: state.pageKey,
                        );
                      },
                  )
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/invoiceDetails',
                    name: 'invoiceDetails',
                    builder: (context,state){


                      Invoice? invoice;

                      if(state.extra != null){
                      final extras = state.extra as Map<String, dynamic>;
                        invoice = extras['invoice'] as Invoice;
                      }

                      return InvoiceDetails(
                        key: state.pageKey,
                        invoice: invoice!,
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
