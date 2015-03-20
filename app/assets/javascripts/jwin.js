
//--------Interface Function------------

function ShowWindow(text)
{
	//Указать рабочую область в процентах
	var hashCoord = GetCoordinate(80);

	$divBackground = GetBackgroundDiv();
	$divWindow = GetWindowDiv(
		hashCoord.left,
		hashCoord.top,
		hashCoord.width,
		"auto");

	SetContent($divWindow,text);
	
	$(document.body).append($divBackground);
	$(document.body).append($divWindow);

	$('body,html').animate({scrollTop: 0}, 1000);
	$("body").css({"overflow":"hidden"});

}

function HideWindow()
{

	$('#background_div, #window_div').remove();
	$("body").css({"overflow":"auto"});
	
}




//--------Service Function------------

function GetBackgroundDiv()
{
	return $('<div id="background_div" />').css({
			'position'	: 'absolute',
			'left'		: '0px',
			'top'		: '0px',
			'width'		: '100%',
			'height'	: '100%',
			'background': 'white',
			'opacity'	:  0.7
		});
}

function GetWindowDiv(x, y, width, height)
{
	$div = $('<div id="window_div" />').css({
		'position'	: 'absolute',
		'left'		: x,
		'top'		: y,
		'width'		: width,
		'height'	: height,
		'background': 'white',
		'border'	: 'solid 1px black',
		'opacity'	:  1,
		'padding'	: '4px',
		'padding'	: '0.4rem'
	});

	$span_close = $('<span />')
		.css({
			'cursor': 'pointer',
			'color': '#205791'
			})
		.html('<b>[закрыть]</b>')
		.click(HideWindow);

	$div.append($('<div />')
		.css({
			'width':'100%',
			'border': '0px',
			'text-align':'right'})
		.append($span_close));

	return $div;
}

function GetCoordinate(perc)
{
	var rslt = new Object();

	//Определение размера окна
	var win_width = $(window).width();
	var win_height = $(window).height();

	rslt_width  = (win_width/100 ) * perc;
	rslt_height = (win_height/100) * perc;

	start_x = (win_width - rslt_width)   / 2;
	start_y = (win_height - rslt_height) / 2;

	rslt['width']  = rslt_width ;
	rslt['height'] = rslt_height;
	rslt['left']   = start_x;
	rslt['top']	   = start_y;

	return rslt;
}

function SetContent($win, $content)
{
	$win.append($content);
}