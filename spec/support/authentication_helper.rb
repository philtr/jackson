module AuthenticationHelper
  def signin_as(user)
    @controller.send(:sign_in_as, user)
  end
end
