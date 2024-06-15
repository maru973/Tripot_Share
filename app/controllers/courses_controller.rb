class CoursesController < ApplicationController


  def new
    @plan = Plan.find(params[:plan_id])
    @course = Course.new
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @course = @plan.create_course(course_params)
    @start_location_results = Geocoder.search(@course.start_location)
    @end_location_results = Geocoder.search(@course.end_location)
    @start_location = Spot.find_or_initialize_by(place_id: @start_location_results.first.place_id)
    @end_location = Spot.find_or_initialize_by(place_id: @end_location_results.first.place_id)
    
    if @course.start_location.present? && @start_location.new_record?
      @latlng =  @start_location_results.first.coordinates
      @start_location.place_id = @start_location_results.first.place_id
      @start_location.name = course_params[:start_location]
      @start_location.latitude = @latlng[0]
      @start_location.longitude = @latlng[1]
      @start_location.address =  @start_location_results.first.address
      spot_details = @start_location.get_spot_details(@start_location.place_id)

      if spot_details
        @start_location.opening_hours = spot_details[:opening_hours].split(",").join("\n") if spot_details[:opening_hours].present?
        @start_location.website = spot_details[:website]
        @start_location.phone_number = spot_details[:phone_number]
      end
      @start_location.save
    end

    if @course.end_location.present? && @end_location.new_record?
      @latlng = @end_location_results.first.coordinates
      @end_location.place_id = @end_location_results.first.place_id
      @end_location.name = course_params[:end_location]
      @end_location.latitude = @latlng[0]
      @end_location.longitude = @latlng[1]
      @end_location.address = @end_location_results.first.address
      spot_details = @end_location.get_spot_details(@end_place_id)

      if spot_details
        @end_location.opening_hours = spot_details[:opening_hours].split(",").join("\n") if spot_details[:opening_hours].present?
        @end_location.website = spot_details[:website]
        @end_location.phone_number = spot_details[:phone_number]
      end
      @end_location.save
    end

    @course.save
    redirect_to course_path(@course), notice: 'コースを作成しました'
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
    planned_spot.update(row_order: params[:row_order_position])
  end

  private

  def course_params
    params.require(:course).permit(:start_location, :end_location)
  end

  def get_ranking(plan)
    @spot_points = SpotPoint.ranking_spots_with_point(plan.id)
    spot_ids = @spot_points.keys
    @ranking_spots = Spot.ranking_spots(plan.id, spot_ids)
  end
end
