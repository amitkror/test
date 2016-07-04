class EventsController < ApplicationController

  before_filter :set_page
  before_filter :set_upcoming, only: :show
  helper_method :extract_dates, :date_in_url

  def index
    @events = []
    future_events =  Event.active.skinny.future.ordered
    @events << future_events

     # get city state  from reqest ip
    @city = request.location.city
    @state = request.location.state
    @events << future_events.where(["name like ? or body like ? or city like ?", "%#{@city}%", "%#{@city}%", "%#{@city}%"]) 
    @events << future_events.where(["name like ? or body like ? or state like ?", "%#{@state}%", "%#{@state}%", "%#{@state}%"])

    if current_user.present?
      audience_ids = current_user.audiences

      audience_ids.each do |audience|
        @events << future_events.joins(:audiences).where(:audiences => {:id => audience.id})
      end

      unless cookies[:signin_events].nil?
        cookies[:signin_events].split.uniq.each do |event|
          @events << future_events.find_by_permalink(event)
        end
      end
    else
      unless cookies[:recent_events].nil?
        cookies[:recent_events].split.uniq.each do |event|
          @events << future_events.find_by_permalink(event)
        end
      end
    end    
    
    @events.compact!
    @events.flatten!
    @events.reverse!
    @events.uniq! 
    
    respond_to do |format|
      
      format.html do
        @events = @events.paginate(page: params[:page] || 1)
      end
      
      format.json do
        render json: { dates: extract_dates(@events) }
      end
    end
  
  end

  def show
    if user_signed_in? && current_user.verified?
      @event = Event.includes(:subway_lines).find_by_permalink!(params[:id])
      unless (@event.active? || @event.hidden?)
        flash.now[:notice] = ("This event is not published yet. " +
                  "You can view this because you are logged in staff.")
      end
      cookies[:signin_events] = ''  if cookies[:signin_events].nil?
      cookies[:signin_events] = cookies[:signin_events] + " " + "#{@event.permalink}"
    else
      @event = Event.active_or_hidden.find_by_permalink!(params[:id])
      cookies[:recent_events] = ''  if cookies[:recent_events].nil?
      cookies[:recent_events] = cookies[:recent_events] + " " + "#{@event.permalink}"
    end
  end

  def date
    @events = Event.active.skinny
    respond_to do |format|
      format.html do
        @events = @events.ordered.by_day(date_in_url).paginate(page: params[:page] || 1)
        render 'events/index'
      end
      format.json { render json: { dates: extract_dates(@events) } }
    end
  end

  def monthdate
    @events = Event.active.skinny
    respond_to do |format|
      format.html do
        @events = @events.ordered.by_month(monthdate_in_url).paginate(page: params[:page] || 1)
        render 'events/index'
      end
      format.json { render json: { dates: extract_dates(@events) } }
    end
  end

  private
    def set_upcoming
      @upcoming = Event.future_events(params[:id])
    end

    def set_page
      @page = Page.find_by_absolute_url!("/events",
        select: "id, title, meta_description, teaser, copy, permalink")
    end

    def date_in_url
      DateTime.new(*params.values_at('year', 'month', 'day').map(&:to_i))
    end

    def monthdate_in_url
      DateTime.new(*params.values_at('year', 'month').map(&:to_i))
    end

    def extract_dates(records)
      result = []
      records.each do |event|
        start = event.start_datetime
        fin = event.end_datetime || event.start_datetime

        # the start date (possibly also end date, we determine that next)
        result << start.strftime('%m/%d/%Y')
        duration = ((start.day - fin.day).abs.days / 1.day).to_i
        if (duration > 0)
          duration.times do |i|
            result << ((start + (i + 1).days).strftime('%m/%d/%Y'))
          end
        end
      end
      result
    end
end
