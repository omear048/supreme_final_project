ready_post = ->
  # Display the image to be uploaded.
  $('.photo_upload_1').on 'change', (e) ->
    readURL(this);

  readURL = (input) ->
    if (input.files && input.files[0])
      reader = new FileReader()

    reader.onload = (e) ->
      $('.image_to_upload_1').attr('src', e.target.result).removeClass('hidden');
      $swap = $('.swap')
      if $swap
        $swap.removeClass('hidden')

    reader.readAsDataURL(input.files[0]);


$(document).ready(ready_post)
$(document).on('turbolinks:load', ready_post)



ready_post = ->
  # Display the image to be uploaded.
  $('.photo_upload_2').on 'change', (e) ->
    readURL(this);

  readURL = (input) ->
    if (input.files && input.files[0])
      reader = new FileReader()

    reader.onload = (e) ->
      $('.image_to_upload_2').attr('src', e.target.result).removeClass('hidden');
      $swap = $('.swap')
      if $swap
        $swap.removeClass('hidden')

    reader.readAsDataURL(input.files[0]);


$(document).ready(ready_post)
$(document).on('turbolinks:load', ready_post)



ready_post = ->
  # Display the image to be uploaded.
  $('.photo_upload_3').on 'change', (e) ->
    readURL(this);

  readURL = (input) ->
    if (input.files && input.files[0])
      reader = new FileReader()

    reader.onload = (e) ->
      $('.image_to_upload_3').attr('src', e.target.result).removeClass('hidden');
      $swap = $('.swap')
      if $swap
        $swap.removeClass('hidden')

    reader.readAsDataURL(input.files[0]);


$(document).ready(ready_post)
$(document).on('turbolinks:load', ready_post)




