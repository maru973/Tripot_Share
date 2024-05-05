module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :info  then "bg-info text-base-content"
    when :notice then "bg-success text-base-content"
    when :warning then "bg-warning text-base-content"
    when :alert  then "bg-error"
    when :error  then "bg-error text-base-content"
    else "bg-gray-500"
    end
  end
end
