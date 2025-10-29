part of 'login_with_email_link_bloc.dart';

abstract class LoginWithEmailLinkEvent extends Equatable {
  const LoginWithEmailLinkEvent();
}

class LoginWithEmailLinkSubmitted extends LoginWithEmailLinkEvent
    with AnalyticsEventMixin {
  const LoginWithEmailLinkSubmitted(this.user);

  final User user;

  @override
  AnalyticsEvent get event =>
      const AnalyticsEvent('LoginWithEmailLinkSubmitted');

  @override
  List<Object> get props => [user, event];
}
