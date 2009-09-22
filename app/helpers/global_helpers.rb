module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    def title_header
      'Ortho-Partage'
    end

    def authenticated?
      session.user
    end
  end
end
