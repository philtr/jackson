module EventParams
  def event_params
    params.require(:event).
      permit(
        :name,
        :description,
        :starts_at,
        :starts_at_date,
        :starts_at_time,
        :starts_at_am_pm,
        :ends_at,
        :ends_at_date,
        :ends_at_time,
        :ends_at_am_pm,
        :location
      )
  end
end
