enum ComplaintStatus {
  /// opens mean that the complaint is not yet resolved and is still open
  open,
  /// closes mean it is not resolved and is closed
  /// the is a case for duplicate complaint or spam or anything unappropriate
  closed,
  /// resolved means that the complaint is resolved and closed
  completed
}
