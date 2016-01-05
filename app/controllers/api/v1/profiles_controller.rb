module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      def me
        respond_with current_resource_owner
      end

      def list
        respond_with(@users = User.where('id != ?', @current_resource_owner))
      end
    end
  end
end
