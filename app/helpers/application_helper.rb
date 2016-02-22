module ApplicationHelper

  def cell_color(field)
    if field == nil || field == "" then " class=yellow-td" end
  end

end
