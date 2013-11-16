class WelcomeController < ApplicationController
  PER = 10

  def index
    @events = Event.page(params[:page]).per(PER).
      where('start_time > ?', Time.zone.now).order(:start_time)
  end
end
