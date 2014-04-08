# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

addHandlers = ->
  jQuery(".kramdown a[href$=\"input_field\"]").click (e) ->
    e.preventDefault()

    id = $(e.currentTarget).data("input-field-id")

    $input   = $("##{id}_input_field")
    $preview = $("##{id}_preview")

    $preview.removeClass("active")
    $("a[href=\"##{id}_preview\"]").removeClass("active")
    $input.addClass("active")
    $("a[href=\"##{id}_input_field\"]").addClass("active")

    return false

  jQuery(".kramdown a[href$=\"preview\"]").click (e) ->
    e.preventDefault()

    id = undefined
    input = undefined
    id = $(e.currentTarget).data("preview-id")
    input = $("#" + id + "_input_field textarea")

    $("#" + id + "_input_field").removeClass("active")
    $("a[href=\"##{id}_input_field\"]").removeClass("active")
    $("##{id}_preview").addClass("active")
    $("a[href=\"##{id}_preview\"]").addClass("active")

    $("#" + id + "_preview").html('<b>Please Wait</b>');

    $.ajax({
      type: 'POST',
      url: '/kramdown/preview.json',
      data: JSON.stringify({ input_html: encodeURIComponent(input.val()) }),
      success: (data) ->
        preview = $("#" + id + "_preview")
        preview.html(data.rendered_kd);

        # Catch image errors, and try to fix them from attachments...
        jQuery(".md-editor img").on 'error', ->
          $img = $(this);
          src = $img.attr('src')

          # Get out if not an attachment image... there's nothing we can do
          return if src.indexOf('attachment') == -1

          $fieldsets = $('.has_many.attachments fieldset')

          slug = src.replace("/attachments/", "")

          if src.indexOf("/thumb") != -1
            slug = slug.replace("/thumb", "")
            $img.css
              width:  192
              height: 100
            $img.addClass "img-polaroid"

          if src.indexOf("/display") != -1
            slug = slug.replace("/display", "")
            $img.css
              width:  700
              height: 700

          $fieldset = null

          $fieldsets.each (i, set) ->
            $set   = $(set)
            $input = $set.find('input[name$="[slug]"]')
            if $input.val() == slug
              $fieldset = $set

          return unless $fieldset?

          file_input = $fieldset.find('input[name$="[file]"]')[0]

          $img.attr 'src', window.URL.createObjectURL(file_input.files[0])
        return
      error: (jqXHR, textStatus, errorThrown) ->
        error_data = JSON.parse(jqXHR.responseText)
        error_html =  """
                      <b>There was an error rendering your kramdown.</b>
                      <pre>#{error_data.error}</pre>
                      """
        $("#" + id + "_preview").html(error_html);
    });

    return false

jQuery ->
  addHandlers()
