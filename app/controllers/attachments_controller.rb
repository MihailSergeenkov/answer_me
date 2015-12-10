class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :set_attachment, only: :destroy

  def destroy
    if current_user.author_of?(@attachment.attachable)
      @attachment.destroy
    end
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end
