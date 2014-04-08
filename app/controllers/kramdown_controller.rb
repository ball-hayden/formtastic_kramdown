##
# Controller to render a kramdown preview.
#
# Use POST /kramdown/preview with the post body set to the content
# to be rendered.
##

class KramdownController < ApplicationController
  def kd_options
    {
      header_offset: 3,
      autoids: true,
      html_to_native: true
    }
  end

  def render_kramdown(kd)
    return '' if kd == nil
    return Kramdown::Document.new(kd, kd_options).to_html.html_safe
  end

  def preview
    body = ActiveSupport::JSON.decode(request.body.read)
    input_html = URI.unescape(body['input_html'])

    response = { rendered_kd: render_kramdown(input_html) }

    render json: response
  end
end
