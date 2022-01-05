import 'package:bid/models/bid.dart';
import 'package:flutter/material.dart';

Widget bidsInfoTable(BuildContext context, Bid bid) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: [
        DataColumn(
            label: Text(
          "Item",
        )),
        DataColumn(label: Text("quantity")),
        DataColumn(label: Text("warranty month")),
        DataColumn(label: Text("Price peer unit")),
        DataColumn(label: Text("Final Price"))

        // DataColumn(label: Text("Price peer unit \n(without tax)")),
        // DataColumn(
        //     label: Text(
        //   "Price peer unit",
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // )),
        // DataColumn(label: Text("Final price \n(without tax)")),
        // DataColumn(
        //   label: Text("Final price",
        //       style: TextStyle(fontWeight: FontWeight.bold)),
        // )
      ], rows: _getTableRows(bid)));
}

List<DataRow> _getTableRows(Bid bid) {
  List<DataRow> products = [];
  bid.selectedProducts.forEach((element) {
    final DataRow dataRow = DataRow(cells: [
      DataCell(Text(element.product.productName)),
      DataCell(Text(element.quantity.toString())),
      DataCell(Text(element.warrantyMonths.toString())),
      DataCell(Text(element.product.price.toString())),
      DataCell(
          Text((element.product.price * element.quantity).toStringAsFixed(2)))
    ]);
    products.add(dataRow);
  });

  return products;
}
