import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/drive.dart';
import 'package:flutter_app/models/loading_status.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/redux/copyjob/copy_job_actions.dart';
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

class CopyJobCreatePageContent extends StatefulWidget {
  CopyJobCreatePageContent(this.viewModel);

  final CopyJobCreatePageViewModel viewModel;

  @override
  State<StatefulWidget> createState() {
    return CopyJobCreatePageContentState(viewModel);
  }
}

class CopyJobCreatePageContentState extends State<CopyJobCreatePageContent> {
  Drive source;
  Drive destination;
  bool dryRun = true;
  bool isLoading = false;
  bool showError = false;

  final CopyJobCreatePageViewModel viewModel;

  CopyJobCreatePageContentState(this.viewModel);

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

  Widget _buildErrorText() {
    return showError
        ? Container(
            padding: EdgeInsets.all(16.0),
            color: const Color(0xFF781C18),
            child: Row(children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              SizedBox(width: 4.0),
              Text(
                "Failed to create CopyJob",
                style: TextStyle(color: Colors.white),
              )
            ]))
        : Container();
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildDropDownTitle("Source"),
          _buildDriveDropDown(
              selectedDrive: source,
              onChanged: (d) {
                setState(() {
                  source = d;
                });
              }),
          SizedBox(height: 16.0),
          _buildDropDownTitle("Destination:"),
          _buildDriveDropDown(
              selectedDrive: destination,
              onChanged: (d) {
                setState(() {
                  destination = d;
                });
              }),
          SizedBox(height: 16.0),
          CheckboxListTile(
            onChanged: (x) {
              setState(() {
                dryRun = x;
              });
            },
            title: Text("Dry-Run"),
            value: dryRun,
          ),
          SizedBox(height: 16.0),
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
                onPressed: _isButtonEnabled()
                    ? () {
                        _createJob(context);
                      }
                    : null,
                child:
                    isLoading ? CircularProgressIndicator() : Text('Create')),
          ),
        ],
      ),
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
          child: Column(
            children: <Widget>[_buildErrorText(), _buildForm()],
          ),
        ));
  }

  bool _isButtonEnabled() {
    return source != null && destination != null && !isLoading;
  }

  void _createJob(BuildContext context) {
    var action = CreateCopyJobAction(
        sourceDevicePath: source.devicePath,
        destinationDevicePath: destination.devicePath,
        flags: dryRun ? ["n", "a"] : ["a"],
        options: []);
    StoreProvider.of<AppState>(context).dispatch(action);
    setState(() {
      isLoading = true;
      showError = false;
    });
    action.completer.future.then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      setState(() {
        isLoading = false;
        showError = true;
      });
    });
  }
}
