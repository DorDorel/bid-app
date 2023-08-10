import 'package:flutter/widgets.dart' show Widget, BuildContext;

import '../presentation/screens/admin/admin_screen.dart';
import '../presentation/screens/admin/create_new_user.dart';
import '../presentation/screens/admin/products/products_screen.dart';
import '../presentation/screens/bids/create_bid_screen.dart';
import '../presentation/screens/home/main_dashboard.dart';
import '../presentation/screens/user/login_screen.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  CreateNewUser.routeName: (context) => CreateNewUser(),
  MainDashboard.routeName: (context) => MainDashboard(),
  CreateBidScreen.routeName: (context) => CreateBidScreen(),
  AdminScreen.routeName: (context) => AdminScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
};
