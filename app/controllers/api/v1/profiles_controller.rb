class Api::V1::ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!
  authorize_resource User, user: @current_resource_owner

  respond_to :json

  def me
    respond_with current_resource_owner
  end

  def list
    respond_with(@users = User.where('id != ?', @current_resource_owner))
  end

  protected

  def current_ability
    @ability ||= Ability.new(current_resource_owner)
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end
