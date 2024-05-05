module ApplicationHelper
  def flash_color(type)
    case type.to_sym
    when :info  then "bg-info text-base-content"
    when :notice then "bg-success text-base-content"
    when :warning then "bg-warning text-base-content"
    when :alert  then "bg-error text-white"
    else "bg-gray-500"
    end
  end
end
