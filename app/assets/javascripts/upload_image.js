$(function() {

  //イメージの挿入
  var dropzone = $('.dropzone-area');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var imageId = 0;
  var editImageId = 0;
  var updateImageIdArray = [];

  // 
  $(document).on('change', 'input[type= "file"].upload-image',function(event){
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $('<div class= "img_view"><img></div>');
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="upload-image__prev--btn"><div class="edit-btn">編集</div><div class="delete-btn">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    
    img.attr('data-image', imageId);
    preview.append(img);
    images.push(img);
    imageId += 1;
    dropzone.css({
      'width': `calc(100% - (124px * ${images.length}))`
    })

    if(images.length == 5) {
      $(".dropzone-area").attr('id', 'nothing');
    }
    // 新しいインプットの表示
    var new_image = $(`<input id="upload-image__btn" class="upload-image" data-image= ${imageId} type="file" name="item[images_attributes][${imageId}][image]">`);
    input_area.prepend(new_image);
  });

  // TODO:プレビュー画像の編集ボタン押下時
  

  // プレビュー画像の削除ボタン押下時
  $(document).on('click', '.delete-btn', function() {
    var target_image = $(this).parent().parent();
    var deleteImageId = target_image.data('image')

    var target_image1 = $(`[data-image="${deleteImageId}"]`)
    target_image1.remove();

    var splitImageNo = null;
    $.each(images, function(index, element){
      if(element.data('image') == deleteImageId){
        splitImageNo = index
      }
    })
    images.splice(splitImageNo, 1);

    var splitinputNo = null;
    $.each(inputs, function(index, element){
      if(element.data('image') == deleteImageId){
        splitinputNo = index
      }
    })
    inputs.splice(splitinputNo, 1);

    if(deleteImageId <= (editImageId - 1)){
      updateImageIdArray[deleteImageId] = 0

      // var update = $(`<div class="upload-image-array", data-image-array= [${updateImageIdArray}], name="item[images_attributes][${imageId}][image]"></div>`);
      var updateImageId = updateImageIdArray.join("");
      console.log(updateImageId)
      var update = $(`<input type="hidden" class="upload-image-array" name="item-image-array" id="item-image-array" value="${updateImageId}">`)
      $(".upload-image-array").remove()
      $(".input_area").prepend(update)
    }


    // $.each(inputs, function(index, input){
    //   console.log($(this))
    //   console.log(index)
    //   console.log(target_image.data('image'))
    //   if ($(this).data('image') == target_image.data('image')){
    //     $(this).remove();
    //     target_image.remove();
    //     var num = $(this).data('image');
    //     images.splice(num, 1);
    //     inputs.splice(num, 1);
    //     if(inputs.length == 0) {
    //       $('input[type= "file"].upload-image').attr({
    //         'data-image': 0
    //       })
    //     }
    //   }
    // })
    // $('input[type= "file"].upload-image:first').attr({
    //   'data-image': imageId
    // })
    // $.each(inputs, function(index, input) {
    //   var input = $(this)
    //   input.attr({
    //     'data-image': imageId
    //   })
    //   $('input[type= "file"].upload-image:first').after(input)
    // })
    dropzone.css({
      'display': 'block'
    })
    dropzone.css({
      'width': `calc(100% - (124px * ${images.length}))`
    })
  })

  $(document).ready(function(){
    var itemImages = $('.img_view')
    itemImages.each(function(index, element){
      images.push($(element));
      updateImageIdArray.push(1)
      editImageId += 1;
      imageId += 1;
    })
    var new_image = $(`<input id="upload-image__btn" class="upload-image" data-image= ${images.length} type="file" name="item[images_attributes][${images.length}][image]">`);
    $("#upload-image__btn").remove();
    input_area.prepend(new_image);
    dropzone.css({
      'display': 'block'
    })
    dropzone.css({
      'width': `calc(100% - (124px * ${images.length}))`
    })
  })
})