# frozen_string_literal: true

class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by_email(invitation_params[:email])
    unless user
      user = User.invite!(email: invitation_params[:email])
    end
    Invitation.find_or_create_by!(invited_by_id: current_user.id, invited_id: user.id)
    redirect_to friends_path
  end

  def accept
    invitation = current_user.received_invitations.find(params[:id])
    invitation.accept!
    if invitation.accepted?
      current_user.friends << invitation.inviting_user
      invitation.inviting_user.friends << current_user
    end
    redirect_to invitations_path
  end

  def reject
    invitation = current_user.received_invitations.find(params[:id])
    invitation.reject!
    redirect_to invitations_path
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
