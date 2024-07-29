module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.append "flash_messages", partial: "shared/flash"
  end

  def button_group_classes(active)
    if active
      "text-blue-700 font-semibold"
    else
      "text-gray-900 font-medium"
    end
  end
end
