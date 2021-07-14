import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pon/core/res/colors.dart';
import 'package:pon/core/res/spacing.dart';
import 'package:pon/core/res/styles.dart';
import 'package:pon/router.dart';
import 'package:pon/screens/base_view.dart';
import 'package:pon/screens/pdf_creation/enquirydisplayview.dart';
import 'package:pon/services/api.dart';
import '../../locator.dart';
//import 'Services.dart';

class EnquiryDisplay extends StatelessWidget {
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
    return BaseView<EnquiryDisplayView>(
        onModelReady: (viewModel) async {
          _scaffoldKey = GlobalKey();
          _firstNameController = TextEditingController();
          _lastNameController = TextEditingController();
          viewModel.getCustPayBill();
        },
        builder: (context, viewModel, child) => Scaffold(
              key: _scaffoldKey,
              drawer: _buildNavigationDrawer(context, viewModel),
              appBar: AppBar(
                backgroundColor: Colors.green[900],
                title: Text('Enquiry'),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    // headline6 is used for setting title's theme
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                // we show the progress in the title...
                actions: <Widget>[],
              ),
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(),
                    Expanded(
                      child: _dataBody(viewModel),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _buildNavigationDrawer(
      BuildContext context, EnquiryDisplayView viewModel) {
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

  Widget getBirthDate(EnquiryDisplayView viewModel, BuildContext context) {
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

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody(EnquiryDisplayView viewModel) {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowHeight: 50,
          dividerThickness: 3,
          columnSpacing: 35.0,
          columns: [
            /* DataColumn(
              label: Text('Sl No.'),
            ), */
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Message',
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
                      proddiv.name,
                    ),
                  ),
                  DataCell(
                    Text(
                      proddiv.qry,
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}
