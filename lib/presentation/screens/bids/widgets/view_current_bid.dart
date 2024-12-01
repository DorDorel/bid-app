import 'package:QuoteApp/data/providers/new_bids_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCurrentBid extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ViewCurrentBidState createState() => _ViewCurrentBidState();
}

class _ViewCurrentBidState extends State<ViewCurrentBid> {
  @override
  Widget build(BuildContext context) {
    final currentBidData = Provider.of<NewBidsProvider>(context);
    // final List<String> columns = ['Product Name', 'Quantity', 'Price/unit'];

    // List<DataColumn> getColumns(List<String> columns) =>
    //     columns.map((String col) => DataColumn(label: Text(col))).toList();
    //     return DataTable(columns: getColumns(columns), rows: rows)

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: currentBidData.getCurrentBidProduct.length,
      itemBuilder: (_, index) => Column(
        children: [
          Text(
            currentBidData.getCurrentBidProduct[index].product.productName,
          )
        ],
      ),
    );
  }
}
