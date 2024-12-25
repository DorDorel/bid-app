import 'package:QuoteApp/data/providers/bids_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterMenu extends StatelessWidget {
  const FilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final bidsData = Provider.of<BidsProvider>(context);

    final TextStyle tabStyle = GoogleFonts.bebasNeue(
      fontSize: 18.0,
    );

    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        child: TabBar(
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: Colors.black,
          ),
          tabs: [
            Tab(
              child: Text("Activities (${bidsData.openBidsCounter.toString()})",
                  style: tabStyle),
            ),
            Tab(
              child: Text("Archive", style: tabStyle),
            ),
            Tab(
              child: Text("Reminders", style: tabStyle),
            ),
          ],
        ),
      ),
    );
  }
}
