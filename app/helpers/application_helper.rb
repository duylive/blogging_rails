module ApplicationHelper
  def flash_class(key)
    case key
    when "notice" then "alert-info"
    when "success" then "alert-success"
    when "error" then "alert-danger"
    when "alert" then "alert-warning"
    else "alert-info"
    end
  end
end
