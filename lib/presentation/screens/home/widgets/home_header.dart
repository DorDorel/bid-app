import 'package:bid/data/providers/tenant_provider.dart';
import 'package:bid/data/providers/user_info_provider.dart';
import 'package:bid/presentation/screens/admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.read<UserInfoProvider>();

    return userData.userData == null
        ? CircularProgressIndicator(
            color: Colors.black,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(),
                child: Text(
                  "${userData.userData!.name} Live Dashboard",
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black87,
                    fontSize: 38,
                  ),
                ),
              ),
              TenantProvider.checkAdmin
                  ? IconButton(
                      icon: Icon(
                        Icons.admin_panel_settings_outlined,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AdminScreen.routeName,
                        );
                      },
                    )
                  : Text('')
            ],
          );
  }
}
