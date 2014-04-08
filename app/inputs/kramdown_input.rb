require 'securerandom'

class KramdownInput < Formtastic::Inputs::TextInput
  def div(div_options, &block)
    template.content_tag(:div, template.capture(&block), div_options)
  end

  # Override this so that we can render it elsewhere.
  def hint_html
  end

  def to_html
    input_wrapping do
      label_html <<
      div(class: 'tab-container') do
        id = SecureRandom.uuid

        div(class: 'tab-content') do
          div(id: "#{id}_input_field", class: 'tab-pane active textarea-padding') do
            builder.text_area(method, input_html_options)
          end <<

          div(id: "#{id}_preview", class: 'clearfix bootstrap tab-pane') do
          end
        end <<

        div(class: 'tab-nav') do
          "<ul class='nav nav-pills'>
            <li><a class='active' href='##{id}_input_field' data-input-field-id='#{id}'>Input</a></li>
            <li><a href='##{id}_preview' data-preview-id='#{id}'>Preview</a></li>
          </ul>".html_safe <<
          div(class: 'hint') do
            if hint?
              Formtastic::Util.html_safe(hint_text)
            else
              """
<b>kramdown hints</b>

<pre>
*Italics*
**Bold**

[Link](/my/address)
![Hint](/my/image)

{:.center}
{:.float-left}
{:.float-right}
{:style='width: 100px;'}
</pre>
              """.html_safe
            end
          end
        end
      end
    end
  end
end
