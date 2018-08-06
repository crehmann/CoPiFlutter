import 'package:flutter/material.dart';
import 'package:flutter_app/models/copy_job.dart';
import 'package:flutter_app/models/copy_job_state.dart';
import 'package:flutter_app/ui/copyjob/copy_job_details_page.dart';

class CopyJobListTile extends StatelessWidget {
  CopyJobListTile(
    this.copyJob,
  );

  final CopyJob copyJob;

  void _navigateToEventDetails(BuildContext context) {
    Navigator.push<Null>(
      context,
      MaterialPageRoute(
        builder: (_) => CopyJobDetailsPage(),
      ),
    );
  }

  Widget _buildStateInfo() {
    switch (copyJob.status) {
      case CopyJobStatus.Completed:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      case CopyJobStatus.Canceled:
        return Icon(
          Icons.cancel,
          color: Colors.grey,
        );
      case CopyJobStatus.InProgress:
        return Column(
          children: <Widget>[
            CircularProgressIndicator(),
            const SizedBox(height: 16.0),
            Text(copyJob.progress.toString() + "%")
          ],
        );
      default:
        return Icon(
          Icons.error_outline,
          color: Colors.red,
        );
    }
  }

  Widget _buildDetailedInfo() {
    var progress = Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      child: Text(
        "flags: " +
            copyJob.flags.toString() +
            ", options: " +
            copyJob.options.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("S: " + copyJob.source),
          const SizedBox(height: 4.0),
          Text("D: " + copyJob.destination),
          progress,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => _navigateToEventDetails(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 38.0, child: Center(child: _buildStateInfo())),
              const SizedBox(width: 20.0),
              _buildDetailedInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
