module ApplicationHelper
  def icon_tag(name, options = {})
    if dom_class = options[:class]
      dom_class = ' ' << dom_class
    end

    case name
    when /\Aglyphicon-/
      "<span class='glyphicon #{name}#{dom_class}'></span>".html_safe
    when /\Afa-/
      "<i class='fa #{name}#{dom_class}'></i>".html_safe
    else
      raise "Unrecognized icon name: #{name}"
    end
  end
end
