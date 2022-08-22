import 'package:bid/presentation/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterMenu extends StatefulWidget {
  const FilterMenu({Key? key}) : super(key: key);

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  bool _activateBidsFlag = true;
  bool _archiveFlag = false;
  bool _notificationsFlag = false;
  bool _catalogFlag = false;
  bool _accountFlag = false;

  final ButtonStyle activeButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      Colors.black,
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );

  final ButtonStyle notActiveButtonStyle = OutlinedButton.styleFrom(
    side: BorderSide(
      color: Colors.transparent,
    ),
  );

  final Color activateButtonTextColor = Colors.white;
  final Color notActivateButtonTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final _filterProvider = Provider.of<FilterProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <OutlinedButton>[
          OutlinedButton(
            onPressed: () {
              setState(() {
                _filterProvider.updateFilterIndex(newIndex: 0);
                _activateBidsFlag = true;
                _archiveFlag = false;
                _notificationsFlag = false;
                _catalogFlag = false;
                _accountFlag = false;
              });
            },
            style: _activateBidsFlag ? activeButtonStyle : notActiveButtonStyle,
            child: Text(
              "Activities Bids(20)",
              style: GoogleFonts.cuprum(
                color: _activateBidsFlag
                    ? activateButtonTextColor
                    : notActivateButtonTextColor,
                fontSize: 18.0,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _filterProvider.updateFilterIndex(newIndex: 1);

                _activateBidsFlag = false;
                _archiveFlag = true;
                _notificationsFlag = false;
                _catalogFlag = false;
                _accountFlag = false;
              });
            },
            style: _archiveFlag ? activeButtonStyle : notActiveButtonStyle,
            child: Text(
              "Archive",
              style: GoogleFonts.cuprum(
                color: _archiveFlag
                    ? activateButtonTextColor
                    : notActivateButtonTextColor,
                fontSize: 18.0,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _filterProvider.updateFilterIndex(newIndex: 2);

                _activateBidsFlag = false;
                _archiveFlag = false;
                _notificationsFlag = true;
                _catalogFlag = false;
                _accountFlag = false;
              });
            },
            style:
                _notificationsFlag ? activeButtonStyle : notActiveButtonStyle,
            child: Text(
              "Notification",
              style: GoogleFonts.cuprum(
                color: _notificationsFlag
                    ? activateButtonTextColor
                    : notActivateButtonTextColor,
                fontSize: 18.0,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _filterProvider.updateFilterIndex(newIndex: 3);

                _activateBidsFlag = false;
                _archiveFlag = false;
                _notificationsFlag = false;
                _catalogFlag = true;
                _accountFlag = false;
              });
            },
            style: _catalogFlag ? activeButtonStyle : notActiveButtonStyle,
            child: Text(
              "Catalog",
              style: GoogleFonts.cuprum(
                color: _catalogFlag
                    ? activateButtonTextColor
                    : notActivateButtonTextColor,
                fontSize: 18.0,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _filterProvider.updateFilterIndex(newIndex: 4);

                _activateBidsFlag = false;
                _archiveFlag = false;
                _notificationsFlag = false;
                _catalogFlag = false;
                _accountFlag = true;
              });
            },
            style: _accountFlag ? activeButtonStyle : notActiveButtonStyle,
            child: Text(
              "Account",
              style: GoogleFonts.cuprum(
                color: _accountFlag
                    ? activateButtonTextColor
                    : notActivateButtonTextColor,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class FilterSingleButton extends StatelessWidget {
//   Function callback;
//   bool currentScreen;

//   FilterSingleButton({
//     Key? key,
//     required this.callback,
//     required this.currentScreen,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: callback(),
//       child: Text("catalog"),
//     );
//   }
// }
