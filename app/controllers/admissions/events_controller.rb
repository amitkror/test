class Admissions::EventsController < Admissions::AdmissionsController
  before_filter :set_event, except: [:index, :new, :create]
  load_resource find_by: :permalink
  authorize_resource

  def index
    respond_to do |format|
      format.html {
        @order = params[:order]
        @status_id = params[:status_id]
        @dir = (params[:dir].blank? || params[:dir] == "asc") ? "asc" : "desc"
        @events = Event.paginate page: params[:page], per_page: @per_page

        unless @status_id.blank?
          @events = @events.where(status_id: @status_id)
        end

        unless @order.blank?
          @events = @events.order("#{@order} #{@dir}")
        else
          @events = @events.reverse_ordered
        end
      }
      format.csv {
        send_data Event.to_csv(request.host_with_port),
                  type: 'text/csv; charset=iso-8859-1; header=present',
                  disposition: "attachment; filename=events-#{DateTime.now}.csv"
      }
    end
  end

  def show
  end

  def new
    @event = Event.new({ start_datetime: DateTime.now })
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to admin_events_path,
        notice: event_flash(@event).html_safe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      @event.clear_boroughs if params[:event][:borough_ids].blank?
      @event.clear_audiences if params[:event][:audience_ids].blank?
      @event.clear_subway_lines if params[:event][:subway_line_ids].blank?
      redirect_to admin_events_path,
        notice: event_flash(@event).html_safe
    else
      render :edit
    end
  end

  def confirm_destroy
  end

  def destroy
    @event.destroy
    redirect_to admin_events_path,
      notice: "Successfully destroyed #{@event.name}."
  end

  private
    def set_event
      @event = Event.find_by_permalink!(params[:id])
    end

    def event_flash(event)
      render_to_string partial: "flash",
        locals: { event: event }
    end
end
