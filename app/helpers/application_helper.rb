module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.append "flash_messages", partial: "shared/flash"
  end
end
