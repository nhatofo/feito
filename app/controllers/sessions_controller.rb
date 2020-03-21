class SessionsController < Devise::SessionsController

    # GET /resource/sign_in
    def build_resource(hash=nil)
        self.resource = resource_class.new_with_session(hash || {}, session)
      end

      def new
        build_resource
        yield resource if block_given?
        respond_with resource
      end
  
end