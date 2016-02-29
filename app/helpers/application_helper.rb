module ApplicationHelper

  def cell_color(field)
    if field == nil || field == "" then " class=yellow-td" end
  end

  def dollar_monthly(field)
    if field != nil && field != ""
      return "$" + field.round.to_s + "/mo"
    end
    return ""
  end
  def dollar_yearly(field)
    if field != nil && field != ""
      return "$" + field.round.to_s + "/yr"
    end
    return ""
  end
  def dollar_onetime(field)
    if field != nil && field != ""
      return "$" + field.round.to_s + " one-time"
    end
    return ""
  end
  def number_weeks(field)
    if field != nil && field != ""
      return field.to_s + " months"
    end
    return ""
  end

end
