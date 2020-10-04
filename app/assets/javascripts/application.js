// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

//プレビュー表示
$(function(){
    // inputのidから情報の取得
    $('#item_image').on('change', function (e) {
// ここから既存の画像のurlの取得
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".image").attr('src', e.target.result);
    }
// ここまで
    reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
});
});

// $(document).ready(function () {
//   $("#multiple-items").slick({
//     autoplay: true,
//     infinite: true,
//   slidesToShow: 3,
//   slidesToScroll: 1,
//   });
// });

// $(function(){
//     $('.slick-prev').css({
//         'display': 'none'
//     });
// });

// $(function(){
//     $('.slick-next').css({
//         'display': 'none'
//     });
// });
