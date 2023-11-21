
# BidApp



- UPDATE (V1.0): New design<br>

<br><br>
SEND BID IN EMAIL (OR SMS) DEMO:
<br>
Send Bid Live Demo: https://www.youtube.com/watch?v=Z_tD7wl4Bvc
<br>
ADMIN PANEL DEMO: https://www.youtube.com/watch?v=0zgNTF5M7XM
<br>



The link that will be sent to the customer: <a href="https://lproject-a1460.web.app/?tenant=XMqoQLgYxIi1u9Bfwh6U&bid=l9MURjFO95gRSTONymmi&creator=lhDqqZZPHMUExcOa5YfQCEtg70p2">here</a>
<br>
^^^^ 
<br>
This flutter web project source code: <a href = "https://github.com/DorDorel/bid-client"> BidClient</a>


<strong> This project using: </strong> <br>
Authentcation and Storage with Firebase.
<br>
Sreveless with Firebase Cloud Function (node.js v14).
<br>
Remote Database(nosql): Firebase Firestore.
<br>
Local Database(nosql): Hive.
<br>
State architecture and di : Provider(v 6.0).
<br>

TREE:
── app
│   ├── providers.dart
│   ├── routes.dart
│   └── theme.dart
├── auth
│   ├── auth_firestore_const.dart
│   ├── auth_repository.dart
│   └── tenant_repository.dart
├── data
│   ├── local
│   │   ├── local_reminder.dart
│   │   └── tenant_cache_box.dart
│   ├── models
│   │   ├── bid.dart
│   │   ├── company.dart
│   │   ├── models_diagram.png
│   │   ├── product.dart
│   │   ├── reminder.dart
│   │   └── user.dart
│   ├── networking
│   │   ├── bids_db.dart
│   │   ├── connection
│   │   │   └── db_test_conection.dart
│   │   ├── constants
│   │   │   ├── bids_firestore_constants.dart
│   │   │   ├── products_firestore_constants.dart
│   │   │   └── shared_firestore_constants.dart
│   │   ├── firestore.md
│   │   ├── products_db.dart
│   │   ├── shared_db.dart
│   │   └── user_data_db.dart
│   └── providers
│       ├── bids_provider.dart
│       ├── new_bids_provider.dart
│       ├── products_provider.dart
│       ├── reminder_provider.dart
│       ├── tenant_provider.dart
│       └── user_info_provider.dart
├── extensions
│   ├── clean_null.dart
│   └── if_debug_mode.dart
├── generated_plugin_registrant.dart
├── logic
│   ├── bid_flow_runner.dart
│   ├── create_bid_logic.dart
│   └── product_bid_logic.dart
├── logs
│   └── console_logger.dart
├── main.dart
├── presentation
│   ├── providers
│   │   └── filter_provider.dart
│   ├── screens
│   │   ├── admin
│   │   │   ├── add_new_product_screen.dart
│   │   │   ├── admin_screen.dart
│   │   │   ├── create_new_user.dart
│   │   │   └── products
│   │   │       ├── products_screen.dart
│   │   │       └── single_product_list.dart
│   │   ├── bids
│   │   │   ├── bid_info.dart
│   │   │   ├── bids_archive_screen.dart
│   │   │   ├── create_bid_screen.dart
│   │   │   ├── open_bids_screen.dart
│   │   │   ├── product_selection_screen.dart
│   │   │   └── widgets
│   │   │       ├── bids_info_table.dart
│   │   │       ├── bids_list_tile.dart
│   │   │       ├── open_bid_card_menu.dart
│   │   │       ├── product_list.dart
│   │   │       ├── product_list_tile.dart
│   │   │       └── view_current_bid.dart
│   │   ├── catalog
│   │   │   ├── catalog.dart
│   │   │   └── single_list_catalog.dart
│   │   ├── constants
│   │   │   └── strings.dart
│   │   ├── home
│   │   │   ├── main_dashboard.dart
│   │   │   └── widgets
│   │   │       ├── home_dashboard_header.dart
│   │   │       └── home_dashboard_widget_selector.dart
│   │   ├── reminders
│   │   │   ├── reminders_screen.dart
│   │   │   └── widgets
│   │   │       ├── favorite_reminders_home.dart
│   │   │       └── reminder_list_tile.dart
│   │   ├── system
│   │   │   └── about.dart
│   │   ├── tenant
│   │   │   └── company_onboarding
│   │   │       └── add_new_company.dart
│   │   └── user
│   │       ├── account_info_screen.dart
│   │       └── login_screen.dart
│   └── widgets
│       ├── admin_button_text_style.dart
│       ├── const_widgets
│       │   ├── app_bar_title_style.dart
│       │   ├── background_color.dart
│       │   ├── card_tile_color.dart
│       │   └── lotti
│       │       ├── lottie_animation_view.dart
│       │       └── models
│       │           └── lottie_animation.dart
│       ├── dialog_manger.dart
│       ├── filter_menu.dart
│       ├── next_button.dart
│       └── text_filed_type_one.dart
└── services
    ├── call_service.dart
    ├── email_service.dart
    └── storage_service.dart

