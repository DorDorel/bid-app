import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../auth/auth_repository.dart';
import '../data/providers/bids_provider.dart';
import '../data/providers/new_bids_provider.dart';
import '../data/providers/products_provider.dart';
import '../data/providers/reminder_provider.dart';
import '../data/providers/tenant_provider.dart';
import '../data/providers/user_info_provider.dart';
import '../presentation/providers/filter_provider.dart';

List<SingleChildWidget> appProviders = [
  Provider<AuthenticationRepositoryImpl>(
    create: (_) => AuthenticationRepositoryImpl(),
  ),
  StreamProvider(
    create: (context) => Provider.of<AuthenticationRepositoryImpl>(
      context,
      listen: false,
    ).authStateChanges,
    initialData: null,
  ),
  ChangeNotifierProvider<ProductProvider>(
    create: (context) => ProductProvider(),
  ),
  ChangeNotifierProvider<TenantProvider>(
    create: (context) => TenantProvider(),
  ),
  ChangeNotifierProvider<BidsProvider>(
    create: (context) => BidsProvider(),
  ),
  ChangeNotifierProvider<NewBidsProvider>(
    create: (context) => NewBidsProvider(),
  ),
  ChangeNotifierProvider<ReminderProvider>(
    create: (context) => ReminderProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => FilterProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => UserInfoProvider(),
  )
];
