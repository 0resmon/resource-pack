var currentIndex = 0
var totalItems = $('.item').length;
var screenFocus = false;
var totalItemsPerPage = 2; 
var totalPages = 0; 
var allData = [];
var lastData = [];
var colorArr = []
var color = "blue";
var page = {
  ["1"] : [1,2],
  ["2"] : [3,4],
  ["3"] : [5,6]
}

window.onload = function(e) {
window.addEventListener("message", function (e) {
    e = e.data
    switch (e.action) {
      case "open":
        return open(e.data,e.coords,e.dist,e.color,e.colorData)
      case "close":
        append = false
        return $("body").fadeOut(500);
      case "key":
        return changeItem(e.key);
      default:
        return;
    }
});
}

append = false
function open(data,coords,distance,colour,colorData) {
  $('page-count').html("1");
  color = colour;
  colorArr = colorData;
  var bg = colorData["keybox"];
  var keyColor = colorData["color"];
  var border = colorData["border"];
  var background = colorData["background"];
  var iconcolor = colorData["iconcolor"];

  $('.key-box').css({ 'background-color': bg , 'color' : keyColor, 'border' : border});
  $('.key-box-border').css({'background': color});
  $('.borderr').css({'border' : border , 'background-color': bg});
  $('.item-right').css({'background': background});
  $('.item-right i').css({'color' : iconcolor , 'filter' : colorData["filterShadow"]});
  if (distance < 1.5) {
    $('.right-box , .direction , .page-count').show();
    $('.key-box').html(`<div class="key-box-border"><div class="progress"></div></div>E`)
  }else{
    $('.right-box , .direction , .page-count').hide();
    $('.key-box').html(`<div class="key-box-border"><div class="progress"></div></div>E`)
  }

  totalPages = Math.ceil(data["item"].length / totalItemsPerPage);
    
  $(".main-box").css("top", coords.y-10 + "%");
  $(".main-box").css("left", coords.x + "%");
    // if (JSON.stringify(data) === JSON.stringify(lastData)) return;
    // lastData = data;

    if (append) return;

    allData = data;
    $('.right-box').empty();
    $.each(data["item"], function (index, value) {
        append = true;
        $('.right-box').append(`
        
        <div id="${index+1}" class="item">   
          <div class="item-right">
          <div class="square">
          <div class="borderr"></div>
          </div>
          <i class="${value.icon}"></i>${value.name}</div>
        </div>

        `)
    });
    $('.item:not([id="1"]):not([id="2"])').hide();
    totalItems = $('.item').length;
    $("body").fadeIn(500);
    append = true;
}

function resetStyles(index) {
    // $('.item').eq(index).find('.item-right,.border').css('background', 'rgb(53, 53, 53,0.29)');
    $('.item').eq(index).find('.border,.item-right,.square').css('border', 'none')
    $('.item').eq(index).find('.borderr').css('display', 'none');
}

function applyStyles(index) {
  currentPage = Math.floor(index / totalItemsPerPage);
  $('.page-count').html(currentPage+1);
  bg = colorArr["background"]
  border = colorArr["border"]
  // $('.item').eq(index).find('.item-right,.border').css('background', bg);
  $('.item').eq(index).find('.square').css('width', '12%');
  $('.item').eq(index).find('.square').css('height', '75%');

  $('.item').eq(index).find('.border,.item-right').css('border', border)
  $('.item').eq(index).find('.borderr').css('display', 'block');
  
  $(".item").hide();

  $.each(page[currentPage+1], function (index, value) {
      $("#"+(value)).show();
  });
}

function changeItem(direction) {
    resetStyles(currentIndex);
    if (direction == "down") {
        currentIndex = (currentIndex + 1) % totalItems;
        $('.down').css('color', 'rgb(1, 104, 76)');
        $('.up').css('color','rgb(255 ,255 ,255 ,0.7)')
        setTimeout(() => {
          $('.down').css('color','rgb(255 ,255 ,255 ,0.7)')
        }, 100);
        applyStyles(currentIndex);
    } else if (direction == "up") {
        currentIndex = (currentIndex - 1 + totalItems) % totalItems;
        $('.down').css('color', 'rgb(255 ,255 ,255 ,0.7)');
        $('.up').css('color','rgb(1, 104, 76)')
        setTimeout(() => {
          $('.up').css('color', 'rgb(255 ,255 ,255 ,0.7)');
        }, 100);
        applyStyles(currentIndex);
    } else if (direction == "enter") {
        $.post(`http://frkn-text/enter`, JSON.stringify({currentIndex:currentIndex }), function (x) {});
    } else if (direction == "backspace") {
        $('body').fadeOut(500);
    } else if (direction == "e") {
        screenFocus = true
        // $('.item-right,.border').css('background', 'rgb(53, 53, 53,0.29)');
        // $('.border,.item-right').css('border', ' 2px solid #353535')
    }
}

$(document).ready(function() {
  $('.right-box').on('mouseenter', '.item', function() {
    var $item = $(this);
    bg = colorArr["background"]
    border = colorArr["border"]
    leftBox = colorArr["keybox"]

    $item.find('.item-right, .border').css({
      'background': bg ,
      'border': border
    });

    $item.find('.left-box').css('background', leftBox);
  });

  $('.right-box').on('mouseleave', '.item', function() {
    var $item = $(this);

    $item.find('.item-right, .border').css({
      'background': '',
      'border': ''
    });

    $item.find('.left-box').css('background', '');
  });
});


$(document).on('click', '.item', function (e) {
  currentIndex = $(this).index();
  resetStyles(currentIndex)
  applyStyles(currentIndex);
  $.post(`http://frkn-text/enter`, JSON.stringify({currentIndex:currentIndex }), function (x) {});
});

$(document).on('click', '.direction', function (e) {
  direction = $(this).data('direction');
  changeItem(direction);
});

$(document).on('keydown', function (e) {
  if (e.key == "Escape" || e.key == "Backspace" && screenFocus) {
    $.post(`http://frkn-text/exit`, JSON.stringify({}), function (x) {});
  }
});



