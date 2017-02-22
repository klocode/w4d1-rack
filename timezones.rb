module Timezones

  require "tzinfo"

  def tzinfo
    TZInfo::Timezone.get(@timezone)
  end

  def utc_offset
    period = tzinfo.current_period
    period.offset.utc_total_offset
  end

  def current
    now.getlocal(utc_offset)
  end


end
