import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pon/core/enums/viewstate.dart';
import 'package:pon/core/models/customer.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/spacing.dart';
import 'package:pon/core/res/styles.dart';
import 'package:pon/router.dart';
import 'package:pon/screens/base_view.dart';
import 'package:pon/screens/pdf_creation/PaymentReportView.dart';
import 'package:pon/services/api.dart';
import 'package:pon/widgets/drop_down_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../locator.dart';
//import 'Services.dart';

class PaymentReport extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  //Employee _selectedProduct;
  //bool _isUpdating = true;
  String _titleProgress = "";

  //Services _services;
  final API _api = locator<API>();

  String url;

  @override
  Widget build(BuildContext context) {
    return BaseView<PaymentReportView>(
        onModelReady: (viewModel) async {
          //viewModel.getProducts(productDivId, 0);
          //viewModel.getBrand(productDivId, 0, productsubDivName);
          //viewModel.isUpdating = true;
          //_titleProgress = widget.title;
          _scaffoldKey =
              GlobalKey(); // key to get the context to show a SnackBar
          _firstNameController = TextEditingController();
          _lastNameController = TextEditingController();
          //_getEmployees();
          //viewModel.customerloading();
          viewModel.getCustPayBill(viewModel.formattedCurrentDate);
        },
        builder: (context, viewModel, child) => Scaffold(
              key: _scaffoldKey,
              drawer: _buildNavigationDrawer(context, viewModel),
              appBar: AppBar(
                backgroundColor: Colors.green[900],
                title: Text('Truck Running Details'),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    // headline6 is used for setting title's theme
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                // we show the progress in the title...
                actions: <Widget>[
                  /* IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ), */
                  /* IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      //_dataBody(viewModel);
                      // _getEmployees();
                      //viewModel.getProductDivision();
                    },
                  ) */
                ],
              ),
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /* Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'First Name',
                        ),
                      ),
                    ), */
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: getBirthDate(viewModel, context),
                    ),
                    // Add an update button and a Cancel Button
                    // show these buttons only when updating an employee
                    /*  _isUpdating
                        ? Row(
                            children: <Widget>[
                              OutlineButton(
                                child: Text('UPDATE'),
                                onPressed: () {
                                  //_updateEmployee(_selectedProduct);
                                },
                              ),
                              OutlineButton(
                                child: Text('CANCEL'),
                                onPressed: () {
                                  //_clearValues();
                                },
                              ),
                            ],
                          ) */
                    Container(),
                    Expanded(
                      child: viewModel.isUpdating
                          ? _dataBody(viewModel)
                          : _dataBody1(viewModel),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _buildNavigationDrawer(
      BuildContext context, PaymentReportView viewModel) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildDrawerItem(Icons.bookmark_border, "Enquiry", onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.enquire);
          }),
          _buildDrawerItem(Icons.bookmark_border, "View Enquiry",
              onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.getenquire);
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {Function onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: AppColor.primary,
            ),
            Spacing.large(
              type: SpacingType.Horizontal,
            ),
            Expanded(
                child: Text(
              title,
              textScaleFactor: 1,
              style: AppTextStyle.title,
            ))
          ],
        ),
      ),
    );
  }

  Widget getBirthDate(PaymentReportView viewModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      //showDemoDialog(context: context);
                      viewModel.selectBirthDate(context);
                      viewModel.notifyListeners();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 8, top: 4, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Select Date:\t\t\t',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green[800]),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            //'${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            '${DateFormat("dd/MM/yyyy").format(viewModel.currentDateBirth)} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _dataBody1(PaymentReportView viewModel) {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowHeight: 50,
          dividerThickness: 2,
          columnSpacing: 15.0,
          columns: [
            /* DataColumn(
              label: Text('Sl No.'),
            ), */
            DataColumn(
              label: Text(
                'Vehicle No',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Driver1',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Mobile No1',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Driver2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Mobile No2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Customer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Destination',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Rate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
          rows: viewModel.transportDriver
              .map(
                (proddiv) => DataRow(cells: [
                  /* DataCell(
                    Text(proddiv.sno),
                  ), */
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                  DataCell(
                    Text(
                      '',
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody(PaymentReportView viewModel) {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowHeight: 50,
          dividerThickness: 3,
          columnSpacing: 15.0,
          columns: [
            /* DataColumn(
              label: Text('Sl No.'),
            ), */
            DataColumn(
              label: Text(
                'Vehicle No',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Driver1',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Mobile No1',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Driver2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Mobile No2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Customer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Destination',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Rate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
          rows: viewModel.transportDriver
              .map(
                (proddiv) => DataRow(cells: [
                  /* DataCell(
                    Text(proddiv.sno),
                  ), */
                  DataCell(
                    Text(
                      proddiv.trailerno,
                    ),
                  ),
                  DataCell(
                    Text(
                      proddiv.operator,
                    ),
                  ),
                  DataCell(
                    Text(
                      proddiv.omobileno,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      _makingPhoneCall(viewModel, proddiv.omobileno);
                    },
                  ),
                  DataCell(
                    Text(
                      proddiv.operator1,
                    ),
                  ),
                  DataCell(
                    Text(
                      proddiv.mobileno1,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      _makingPhoneCall(viewModel, proddiv.mobileno1);
                    },
                  ),
                  DataCell(
                    Text(
                      proddiv.partyName,
                    ),
                  ),
                  DataCell(
                    Text(
                      proddiv.desitination,
                    ),
                  ),
                  DataCell(
                    Text(
                      proddiv.rtonne,
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  _makingPhoneCall(PaymentReportView viewModel, String mobileno) async {
    //const url = 'tel:9025056017';
    url = 'tel:$mobileno';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildCustomerDropDown(PaymentReportView viewModel) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: DropDownCard(
        "Select Customer",
        margin: EdgeInsets.zero,
        child: DropdownButton<Customer>(
          value: viewModel.selectedCustomer,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 18,
          elevation: 16,
          isExpanded: true,
          underline: Container(
            height: 0,
          ),
          onChanged: (Customer item) {
            viewModel.selectedCustomer = item;
            viewModel.getCustPayBill(item.custname);
            viewModel.notifyListeners();
            //price = double.parse(viewModel.selectedSize.price);
            //viewModel.updateProductBySize(viewModel.selectedSize);
            // products.prodnamesize =
            //products.prodname + viewModel.selectedSize.size;
            //viewModel.product.qty = 0;
          },
          items: viewModel.customerList
                  .map<DropdownMenuItem<Customer>>((Customer item) {
                return DropdownMenuItem<Customer>(
                  value: item,
                  child: Text(
                    item.custname,
                    textScaleFactor: 1,
                    style: AppTextStyle.text,
                  ),
                );
                viewModel.notifyListeners();
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
