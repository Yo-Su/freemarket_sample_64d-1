$(function() {

  //イメージの挿入
  var dropzone = $('.dropzone-area');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  // 追加する画像にデータ属性を加える際に使用 0スタートで数値を減少させない(削除時の不具合対策)
  var imageId = 0;
  // 既に登録してある画像数
  var editImageId = 0;
  // 既に登録してある画像を削除する場合のフラグ管理用、配列で管理（0:削除, 1:変更なし）
  var updateImageIdArray = [];


  // 画像追加時の処理
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
    // 削除ボタンする画像のカスタムデータの番号
    var deleteImageId = $(this).parent().parent().data('image');
    // 削除ボタンを押した画像をプレービューから消す
    $(`[data-image="${deleteImageId}"]`).remove();

    // 配列imagesから削除画像のデータを消すために変数を設定
    var splitImageNo = null;
    $.each(images, function(index, element){
      if(element.data('image') == deleteImageId){
        splitImageNo = index
      }
    });
    // 配列imagesから削除する画像データを削除
    images.splice(splitImageNo, 1);

    // 配列inputsから削除画像のデータを消すために変数を設定
    var splitinputNo = null;
    $.each(inputs, function(index, element){
      if(element.data('image') == deleteImageId){
        splitinputNo = index
      }
    });
    // 配列inputsから削除する画像データを削除
    inputs.splice(splitinputNo, 1);

    // 削除ボタンが押されたのが既存の登録画像の場合の処理、削除フラグを追加
    if(deleteImageId <= (editImageId - 1)){
      updateImageIdArray[deleteImageId] = 0

      // コントローラ側で処理しやすいように配列を結合する
      var updateImageId = updateImageIdArray.join("");
      // paramsにデータを送るためにhidden属性でデータを付与
      var update = $(`<input type="hidden" class="upload-image-array" name="item-image-array" id="item-image-array" value="${updateImageId}">`)
      $(".upload-image-array").remove()
      $(".input_area").prepend(update)
    }
    dropzone.css({
      'display': 'block'
    })
    dropzone.css({
      'width': `calc(100% - (124px * ${images.length}))`
    })
  })


  // 商品編集画面を開いた時の処理。既に登録されている画像が削除される場合の準備を行う
  $(document).ready(function(){
    var itemImages = $('.img_view')
    itemImages.each(function(index, element){
      images.push($(element));
      // 既に登録してある画像の数だけ「1」を配列に加える(この1が0になった画像を削除する)
      updateImageIdArray.push(1)
      // 既に登録してある画像数を数える
      editImageId += 1;
      // 商品編集画面を開いた段階ではeditImageIdと同じ
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