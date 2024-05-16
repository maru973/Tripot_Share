class PlansController < ApplicationController
  def index
    @plans = Plan.includes(:owner).order(created_at: :desc).page(params[:page])
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build(plan_params)
    @plan.owner_id = current_user.id
    if @plan.save
      @plan.users << current_user
      @location = Spot.find_or_initialize_by(name: @plan.location)
      if @location.new_record?
        results = Geocoder.search(@plan.location)
        @latlng = results.first.coordinates
        @location.latitude = @latlng[0]
        @location.longitude = @latlng[1]
        @location.address = results.first.address
        @location.save
      end
      redirect_to new_spots_plan_path(@plan), notice: t('defaults.flash_message.created', item: @plan.name)
    else
      flash.now[:alert] = t('defaults.flash_message.not_created', item: Plan.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def new_spots
    @plan = Plan.find(params[:id])
    @location = Spot.find_by(name: @plan.location)
    @users = @plan.users
    @user_spots = {}

    # 各ユーザーのスポットをハッシュに入れる
    @users.each do |user|
      @user_spots[user.id] = Spot.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, user_id: user.id })
    end

    # memberのみ編集可
    if current_user.member?(@plan.id)
      @spot = Spot.new
      @spots = @plan.spots
    else
      redirect_to plan_path(@plan), alert: "あなたはこのプランのメンバーではないため、スポットの登録はできません"
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @location = Spot.find_by(name: @plan.location)
    @users = @plan.users
    @spots = @plan.spots # マーカーを表示に使用
    @user_spots = {}

    @users.each do |user|
      @user_spots[user.id] = Spot.joins(:planned_spots).where(planned_spots: { plan_id: @plan.id, user_id: user.id })
    end
    @user = User.new
    @resource_name = @user.class.name.underscore
    @invite_link = accept_plan_url(invitation_token: @plan.invitation_token) if @plan.invitation_token.present?
  end

  def edit
    @plan = current_user.plans.find(params[:id])
  end

  def update
    @plan = current_user.plans.find(params[:id])
    if current_user.id === @plan.owner_id
      @plan.update(plan_params)
    else
      redirect_to plans_path, alert: "あなたはこのプランのオーナーではないため編集できません"
    end
  end

  def destroy
    @plan = current_user.plans.find(params[:id])
    if current_user.id === @plan.owner_id
      @plan.destroy!
      redirect_to plans_path, status: :see_other, notice: "プランが削除されました"
    else
      redirect_to plans_path, alert: "あなたはこのプランのオーナーではないため削除できません"
    end
  end

  def invitation
    @plan = Plan.find(params[:id])
    @plan.generate_token
  end

  def accept
    @plan = Plan.find_by(invitation_token: params[:invitation_token])
    
    if @plan.present?
      
      session[:plan_id] = @plan.id
      if user_signed_in? && !current_user.member?(@plan.id)
        @plan.users << current_user
        session[:plan_id] = nil
        @plan.update(invitation_token: nil)

        redirect_to plan_path(@plan), notice: t('defaults.flash_message.added', item: @plan.name)

      elsif user_signed_in? && current_user.member?(@plan.id)
        session[:plan_id] = nil
        @plan.update(invitation_token: nil)

        redirect_to plan_path(@plan), notice:t('defaults.flash_message.already_registered_plan', item: @plan.name)
      end

    else
      redirect_to root_path, alert: t('defaults.flash_message.invitation_token_invalid')
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :start_date, :end_date, :invitation_token, :location)
  end
end
