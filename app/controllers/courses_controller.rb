class CoursesController < ApplicationController
  def new
    @plan = Plan.find(params[:plan_id])
    @course = Course.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @course = @plan.create_course(course_params)

    unless @course.start_location.present? && @course.end_location.present?
      return redirect_to plan_path(@plan), alert: 'ルートを作成できませんでした'
    end

    @start_location = Spot.save_spot(course_params[:start_location])
    @end_location = Spot.save_spot(course_params[:end_location])

    @course.save
    redirect_to course_path(@course), notice: 'ルートを作成しました'
  end

  def show
    @course = Course.find(params[:id])
    @plan = @course.plan
    if current_user.member?(@plan.id)
      @start_location = Spot.find_by(name: @course.start_location)
      @end_location = Spot.find_by(name: @course.end_location)
      @spot_subscribers = {}
      
      get_ranking(@plan)
      
      @ranking_spots.each do |spot|
        @spot_subscribers[spot.id] = User.spot_subscriber(@plan.id, spot.id)
      end
    else
      redirect_to plan_path(@plan), alert: 'あなたはこのプランのメンバーではないためこのページは開けません'
    end
  end

  def create_position
    @plan = Course.find(params[:id]).plan
    # JSのルート検索で出てきた結果のplace_idを取得
    place_ids = params[:place_ids]

    # 配列の最初(出発地のplace_id)と最後(到着地のplace_id)を削除
    place_ids.shift
    place_ids.pop
    
    place_ids.each_with_index do |place_id, index|
      spot = Spot.find_by(place_id: place_id)
      if spot
        planned_spot = PlannedSpot.find_by(spot_id: spot.id, plan_id: @plan.id)
        planned_spot.update(row_order: index + 1) # 1から始めるためにindexに1を足す
      end
    end
    redirect_to course_path(params[:id])
  end

  def reserach_course
    @course = Course.find(params[:id])
    @plan = @course.plan
    get_ranking(@plan)
    
    render json: @ranking_spots.map { |spot| { place_id: spot.place_id } }
  end

  def rank
    plan = Course.find(params[:id]).plan
    spot = Spot.find(params[:spot_id])
    planned_spot = PlannedSpot.find_by(spot_id: spot.id, plan_id: plan.id)
    planned_spot.update(row_order_position: params[:row_order_position])
  end

  private

  def course_params
    params.require(:course).permit(:start_location, :end_location)
  end

  def get_ranking(plan)
    @spot_points = SpotPoint.ranking_spot_ids_with_point(plan.id)
    spot_ids = @spot_points.keys
    @ranking_spots = Spot.ranking_spots_in_order_of_course(plan.id, spot_ids)
  end
end
