class Api::V1::ProfilesController < Api::V1::BaseController
  authorize_resource User, user: @current_resource_owner
  
  def me
    respond_with current_resource_owner
  end

  def list
    respond_with(@users = User.where.not(id: @current_resource_owner))
  end
end
