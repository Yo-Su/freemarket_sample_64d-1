$(function(){

  // 親カテゴリーを選択した際に、子カテゴリーを表示させる
  $(document).on('change', '#category_parent', function(){
    var parent_id = $(this).val()
    $('#category_children').parent().removeClass('display_none')
    $('#category_grandchild').parent().addClass('display_none')
    $.ajax({
      type: 'GET',
      url: '/categories/set_children_category',
      data: {parent_id: parent_id},
      dataType: 'json'
    })
    .done(function(categories){
      $("#category_children").empty()
      $("#category_children").append('<option value="" selected>---</option>')
      $.each(categories, function(i, category){
        var children_category = `<option value="${category.id}">${category.name}</option>`
        $("#category_children").append(children_category)
      })
    })
    .fail(function(){
      alert('error')
    })
  })

  // 子カテゴリーを選択した際に、孫カテゴリーを表示させる
  $(document).on('change', '#category_children', function(){
    var children_id = $(this).val()
    $('#category_grandchild').parent().removeClass('display_none')
    $.ajax({
      type: 'GET',
      url: '/categories/set_grandchild_category',
      data: {children_id: children_id},
      dataType: 'json'
    })
    .done(function(categories){
      $("#category_grandchild").empty()
      $("#category_grandchild").append('<option value="" selected>---</option>')
      $.each(categories, function(i, category){
        var grandchild_category = `<option value="${category.id}" name="category">${category.name}</option>`
        $("#category_grandchild").append(grandchild_category)
      })
    })
    .fail(function(){
      alert('error')
    })
  })
  $(document).on('click','#item_button', function(){
    var category_id = $('#category_grandchild').val()
    if (category_id.length !== 0) {
      $("#category_parent").empty()
      var category_grandchild = `<option value='${category_id}'></option>`
      $('#category_parent').append(category_grandchild)
      }
  })
})