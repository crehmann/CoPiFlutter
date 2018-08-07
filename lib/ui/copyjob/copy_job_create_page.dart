import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/ui/copyjob/copy_job_create_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CopyJobCreatePage extends StatelessWidget {
  CopyJobCreatePage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CopyJobCreatePageViewModel>(
      distinct: true,
      converter: (store) => CopyJobCreatePageViewModel.fromStore(store),
      builder: (_, viewModel) => CopyJobCreatePageContent(viewModel),
    );
  }
}

class CopyJobCreatePageContent extends StatelessWidget {
  CopyJobCreatePageContent(this.viewModel);

  final CopyJobCreatePageViewModel viewModel;

  Widget _buildDriveDropDown(
      {@required Drive selectedDrive,
      @required ValueChanged<Drive> onChanged}) {
    return DropdownButton<Drive>(
      value: selectedDrive,
      items: viewModel.drives
          .map((drive) => new DropdownMenuItem<Drive>(
              value: drive, child: new Text(drive.device.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDropDownTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create a CopyJob"),
          centerTitle: Platform.isIOS,
        ),
        body: Scrollbar(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildDropDownTitle("Source"),
                SizedBox(height: 16.0),
                _buildDriveDropDown(selectedDrive: null, onChanged: (_) {}),
                _buildDropDownTitle("Destination:"),
                _buildDriveDropDown(selectedDrive: null, onChanged: (_) {}),
                SizedBox(height: 16.0),
                CheckboxListTile(
                  onChanged: (_) {},
                  title: Text("Dry-Run"),
                  value: true,
                ),
                SizedBox(height: 16.0),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
