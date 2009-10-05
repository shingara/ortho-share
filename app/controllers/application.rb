class Application < Merb::Controller
  def need_admin
    unless session.user && session.user.global_admin?
      raise Unauthenticated
    end
  end
end
