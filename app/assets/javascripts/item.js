$(function(){

  //  商品詳細画面の画像を切り替える
  $('.content__item-data__photo__sub-images__sub-image').on('mouseover', function(e){
    e.preventDefault();
    // 上から、商品の画像一覧、選択した(ピックアップしたい)画像のID、非表示から表示に切り替えたい画像
    const pickupImages = $('.content__item-data__photo__main-image__pickupimage')
    let pickupImageId = $(this).children().attr("data-sub-image-id")
    let pickupImage = $(`[data-image-id="${pickupImageId}"]`).parent()
    // 全部の画像を非表示にする
    pickupImages.each(function(index, element){
      console.log(element)
      $(element).addClass("image-hidden")
    })
    // ピックアップしたい画像を表示する(非表示クラスを除去する)
    pickupImage.removeClass("image-hidden")
  })

})