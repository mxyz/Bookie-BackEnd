class Api::V1::MembersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
	respond_to :json

  def show
    respond_with Member.find(params[:id])
  end

  def create
    member = Member.new(member_params)
    if member.save
      render json: member, status: 201, location: [:api, member]
    else
      render json: { errors: member.errors }, status: 422
    end
  end

  def update
    member = current_user

    if member.update(member_params)
      render json:  member, status: 200, location: [:api, member]
    else
      render json: { errors: member.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

    def member_params
      params.require(:member).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :identification_number)
    end
end
