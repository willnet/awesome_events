class WelcomeController < ApplicationController
  PER = 10

  def index
    @q = Event.page(params[:page]).per(PER).order(:start_time).search(search_params)

    @events = @q.result(distinct: true)
  end

  private

  def search_params
    params.require(:q).permit!
  rescue
    { start_time_gteq: Time.zone.now }
  end
end
