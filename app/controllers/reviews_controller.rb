class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @station = Station.find(params["station_id"].to_i)
  end

  def create
    @review = Review.new(reviews_params)
    @station = Station.find(params["station_id"].to_i)
    @review.station = @station
    @review.user = current_user
    if @review.save
      redirect_to station_path(@station)
      current_user.score.increment!(:reviews_submitted, 2)
      current_user.calculate_total_score
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to station_path, notice: "Review deleted successfully"
  end

  private

  def reviews_params
    params.require(:review).permit(:rating, :description, photos: [])
  end
end
