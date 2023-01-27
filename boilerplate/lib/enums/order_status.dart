enum OrderStatus {
  /// The order is being matched with a service provider
  underProcessing,

  /// The order has been accepted by a service provider
  accepted,

  /// The service provider is in his way to the customer
  inTheWay,

  /// The order is being handled by the service provider
  beingHandled,

  /// The order is completed
  completed,

  /// The order is cancelled by the client
  cancelled,

  /// The order is rejected by the service provider
  rejected,

  /// When the order is not paid within 5 minutes
  deleted,
}
