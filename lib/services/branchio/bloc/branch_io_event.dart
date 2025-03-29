part of 'branch_io_bloc.dart';

abstract class BranchIoEvent extends Equatable {
  const BranchIoEvent();

  @override
  List<Object> get props => [];
}

class BranchIoEventSuscribe extends BranchIoEvent {
  const BranchIoEventSuscribe();
}

class BranchIoEventCancellAllSuscriptions extends BranchIoEvent {
  const BranchIoEventCancellAllSuscriptions();
}
