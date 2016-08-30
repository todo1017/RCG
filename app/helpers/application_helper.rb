module ApplicationHelper

  def is_login
    return (params[:controller] == 'sessions' && (params[:action] == 'new' || params[:action] == 'create')) ? true : false
  end

  def get_random_background
    backgrounds = [image_path('login-background-1.jpg'), image_path('login-background-2.jpg'), image_path('login-background-3.jpg')]
    return backgrounds[rand(0..2)]
  end

  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end

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
