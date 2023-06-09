part of 'management_bloc.dart';

enum SubmitStatus { submitting, success, failed, init }

class ManagementState extends Equatable {
  final SubmitStatus status;
  const ManagementState({this.status = SubmitStatus.init});

  ManagementState copyWith({SubmitStatus? status}) {
    return ManagementState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
