$(function(){

  //  商品詳細画面の画像を切り替える
  $('.content__item-data__photo__sub-images__sub-image').on('mouseover', function(e){
    e.preventDefault();
    // 商品の画像一覧（ピックアップ画像、サブ画像）
    const pickupImages = $('.content__item-data__photo__main-image__pickupimage')
    const pickupSubImages = $('.content__item-data__photo__sub-images__sub-image')
    // 選択した(ピックアップしたい)画像のID
    let pickupImageId = $(this).children().attr("data-sub-image-id")
    // 詮索されたピックアップ画像、サブ画像
    let pickupImage = $(`[data-image-id="${pickupImageId}"]`).parent()
    let pickupSubImage = $(`[data-sub-image-id="${pickupImageId}"]`).parent()

    // 全部の画像を非表示にする
    pickupImages.each(function(index, element){
      $(element).addClass("image-hidden")
    })
    // ピックアップしたい画像を表示する(非表示クラスを除去する)
    pickupImage.removeClass("image-hidden")

    // 全部の画像に透明度を設定する
    pickupSubImages.each(function(index, element){
      $(element).addClass("image-opacity")
    })
    // 選択したサブ画像の透明度を解除する(透明度クラスを除去する)
    pickupSubImage.removeClass("image-opacity")
  })

})