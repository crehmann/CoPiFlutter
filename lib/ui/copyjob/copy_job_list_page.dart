import 'package:flutter/cupertino.dart';
import 'package:flutter_app/redux/app/app_state.dart';
import 'package:flutter_app/ui/common/info_message_view.dart';
import 'package:flutter_app/ui/common/loading_view.dart';
import 'package:flutter_app/ui/copyjob/copy_job_list.dart';
import 'package:flutter_app/ui/copyjob/copy_job_list_page_view_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CopyJobListPage extends StatelessWidget {
  CopyJobListPage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CopyJobListPageViewModel>(
      distinct: true,
      converter: (store) => CopyJobListPageViewModel.fromStore(store),
      builder: (_, viewModel) => CopyJobListPageContent(viewModel),
    );
  }
}

class CopyJobListPageContent extends StatelessWidget {
  CopyJobListPageContent(this.viewModel);

  final CopyJobListPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      status: viewModel.status,
      loadingContent: Text("Loading..."),
      errorContent: ErrorView(
        description: 'Error loading events.',
        onRetry: viewModel.refreshCopyJobs,
      ),
      successContent: CopyJobList(
        copyJobs: viewModel.copyJobs,
        onReloadCallback: viewModel.refreshCopyJobs,
      ),
    );
  }
}
