module FriendlyDatetime
  extend ActiveSupport::Concern

  included do
    before_save :friendly_datetime_combine_components
    after_initialize :friendly_datetime_split_components
  end

  def friendly_datetime_combine_components
    self.class.friendly_datetime_fields.each do |field|
      next if send("#{ field }_changed?")

      month, day, year = send("#{field}_date").split("/").map(&:to_i)
      hours, minutes = send("#{field}_time").split(":").map(&:to_i)
      hours += 12 if send("#{field}_am_pm") == "PM"

      send("#{field}=", Time.new(year, month, day))
      send("#{field}=", send(field) + hours.to_i.hours + minutes.to_i.minutes)
    end
  end

  def friendly_datetime_split_components
    self.class.friendly_datetime_fields.each do |field|
      next unless send(field).present?
      time, am_pm = send(field).strftime("%-I:%M|%p").split("|")
      send("#{ field }_time=", time)
      send("#{ field }_am_pm=", am_pm)

      unless send("#{ field }_date").present?
        send("#{ field }_date=", send(field).beginning_of_day.strftime("%m/%d/%Y")) rescue nil
      end
    end
  end

  module ClassMethods
    def friendly_datetime(*fields)
      @friendly_datetime_fields ||= []
      @friendly_datetime_fields.concat(fields)

      fields.each do |field|
        class_eval do
          attr_accessor "#{ field }_time", "#{ field }_date", "#{ field }_am_pm"
        end
      end
    end

    def friendly_datetime_fields
      @friendly_datetime_fields
    end
  end
end
