class PlansController < ApplicationController
  def index
    @plans = current_user.plans.page(params[:page])
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build(plan_params)
    @plan.owner_id = current_user.id
    if @plan.save
      @plan.users << current_user
      redirect_to new_spots_path(@plan), notice: t('defaults.flash_message.created', item: @plan.name)
    else
      flash.now[:alert] = t('defaults.flash_message.not_created', item: Plan.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def new_spots
    @plan = Plan.find(params[:id])
    @plna.generate_token
    @spot = Spot.new
    @spots = @plan.spots
  end

  def show
    @plan = Plan.find(params[:id])
    @spots = @plan.spots
    @user = User.new
    @resource_name = @user.class.name.underscore
    @invite_link = accept_plan_url(invitation_token: @plan.invitation_token) if @plan.invitation_token.present?
  end

  def invitation
    @plan = Plan.find(params[:id])
    @plan.generate_token
  end

  def accept
    @plan = Plan.find_by(invitation_token: params[:invitation_token])
    
    if @plan.present?
      
      session[:plan_id] = @plan.id
      if user_signed_in? && !Member.find_by(plan_id: @plan.id, user_id: current_user.id).present?
        @plan.users << current_user
        session[:plan_id] = nil
        @plan.update(invitation_token: nil)

        redirect_to plans_path, notice: t('defaults.flash_message.added', item: @plan.name)
      elsif user_signed_in? && Member.find_by(plan_id: @plan.id, user_id: current_user.id).present?
        session[:plan_id] = nil
        @plan.update(invitation_token: nil)
        redirect_to plan_path(@plan), notice:t('defaults.flash_message.already_registered_plan', item: @plan.name)
      else
        redirect_to new_user_registration_path
      end
    else
      redirect_to root_path, alert: t('defaults.flash_message.invitation_token_invalid')
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :start_date, :end_date, :invitation_token)
  end
end
