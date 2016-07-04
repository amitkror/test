module EventsHelper

  def set_req_date
    if %w{year month day}.all? { |v| params.has_key?(v) }
      dt = DateTime.new(*params.values_at('year', 'month', 'day').map(&:to_i))
    elsif %w{year month}.all? { |v| params.has_key?(v) }
      dt = DateTime.new(*params.values_at('year', 'month').map(&:to_i))
    else
      dt = DateTime.now
    end
    dt.strftime('%m/%d/%Y')
  end

  def event_duration(e)
    duration = l e.start_datetime, format: :full
    unless e.end_datetime.blank?
      if e.start_datetime.to_date == e.end_datetime.to_date
        duration << " - " + l(e.end_datetime, format: :ampm)
      else
        duration << " - " + l(e.end_datetime, format: :full)
      end
    end
    duration
  end

end
