import 'package:p2pbookshare/app_init_handler.dart';
import 'package:p2pbookshare/pages/addbook/addbook_handler.dart';
import 'package:p2pbookshare/pages/request_book/request_book_viewmodel.dart';
import 'package:p2pbookshare/pages/search/search_viewmodel.dart';
import 'package:p2pbookshare/services/providers/authentication/authentication.dart';
import 'package:p2pbookshare/services/providers/firebase/book_fetch_service.dart';
import 'package:p2pbookshare/services/providers/firebase/book_request_service.dart';
import 'package:p2pbookshare/services/providers/firebase/book_upload_service.dart';
import 'package:p2pbookshare/services/providers/firebase/user_service.dart';
import 'package:p2pbookshare/services/providers/others/connectivity_service.dart';
import 'package:p2pbookshare/services/providers/others/gemini_service.dart';
import 'package:p2pbookshare/services/providers/others/location_service.dart';
import 'package:p2pbookshare/services/providers/others/permission_service.dart';
import 'package:p2pbookshare/services/providers/shared_prefs/ai_summary_prefs.dart';
import 'package:p2pbookshare/services/providers/shared_prefs/app_theme_prefs.dart';
import 'package:p2pbookshare/services/providers/shared_prefs/user_data_prefs.dart';
import 'package:p2pbookshare/services/providers/theme/app_theme_service.dart';
import 'package:p2pbookshare/services/providers/userdata_provider.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider> appProviders = [
  // Authorization Service Provider
  ChangeNotifierProvider<AuthorizationService>(
      create: (_) => AuthorizationService()),
  // App Theme Shared Preferences Provider
  ChangeNotifierProvider<AppThemePrefs>(create: (_) => AppThemePrefs()),
  // Firebase User Related Services Provider
  ChangeNotifierProvider<FirebaseUserService>(
      create: (_) => FirebaseUserService()),
  // Firebase Book Request Services Provider
  ChangeNotifierProvider<BookRequestService>(
      create: (_) => BookRequestService()),
  // Firebase Book Upload Services Provider
  ChangeNotifierProvider<BookUploadService>(create: (_) => BookUploadService()),
  // User Data Provider Provider
  ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
  // Book Fetch Services Provider
  ChangeNotifierProvider<BookFetchService>(create: (_) => BookFetchService()),
  // User Data Shared Preferences Provider
  ChangeNotifierProvider<UserDataPrefs>(create: (_) => UserDataPrefs()),
  // App Theme Service Provider
  ChangeNotifierProvider<AppThemeService>(create: (_) => AppThemeService()),
  // Connectivity Provider
  ChangeNotifierProvider<ConnectivityProvider>(
      create: (_) => ConnectivityProvider()),
  // Location Service Provider
  ChangeNotifierProvider<LocationService>(
    create: (context) => LocationService(),
  ),
  // Permission Service Provider
  ChangeNotifierProvider<PermissionService>(
    create: (context) => PermissionService(),
  ),
  // Gemini Service Provider
  ChangeNotifierProvider<GeminiService>(
    create: (context) {
      return GeminiService();
    },
  ),
  // AI Summary Shared Preferences Provider
  ChangeNotifierProvider<AISummaryPrefs>(
    create: (context) => AISummaryPrefs(),
  ),
  // Search View Model Provider
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(),
  ),
  // Add Book Handler Provider
  ChangeNotifierProvider<AddbookHandler>(
    create: (context) {
      final fbBookServices =
          Provider.of<BookUploadService>(context, listen: false);
      final userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      return AddbookHandler(fbBookServices, userDataProvider);
    },
  ),
  // App Initialization Handler Provider
  ChangeNotifierProvider<AppInitHandler>(
    create: (context) {
      final authProvider =
          Provider.of<AuthorizationService>(context, listen: false);
      final userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      final appThemeSharedPrefsServices =
          Provider.of<AppThemePrefs>(context, listen: false);
      final themeProvider =
          Provider.of<AppThemeService>(context, listen: false);
      return AppInitHandler(authProvider, userDataProvider,
          appThemeSharedPrefsServices, themeProvider);
    },
  ),
  // RequestBook ViewMdoel
  ChangeNotifierProvider<RequestBookViewModel>(
    create: (context) {
      return RequestBookViewModel();
    },
  ),
];
