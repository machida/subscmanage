module ApplicationHelper
  def flash_css_class(key)
    base = "toast w-72 rounded-xl shadow-lg px-4 py-3 border transition-all duration-300"
    case key.to_sym
    when :notice
      "#{base} bg-green-50 text-green-800 border-green-200"
    when :alert
      "#{base} bg-red-50 text-red-800 border-red-200"
    else
      "#{base} bg-blue-50 text-blue-800 border-blue-200"
    end
  end
end
