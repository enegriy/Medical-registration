// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .


//Создание объекта AJAX
function createHttpRequest()
{
	var httpRequest;
	var browser = navigator.appName;

	if (browser == "Microsoft Internet Explorer")
	{
		httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else
	{
		httpRequest = new XMLHttpRequest();
	}
	return httpRequest;
}


//Обновление городов
function update_cities(val_region,id)
{
	var httpRequest = createHttpRequest();
	httpRequest.open('get','/service/get_cities?region='+val_region,true);
	httpRequest.onreadystatechange = function()
	{
		if (httpRequest.readyState == 4)
		{
			if (httpRequest.status == 200)
			{
				//Получаю новый список городов
				hash_cities = eval(httpRequest.responseText);
				set_select_option(document.getElementById("city"),hash_cities,true);

				if(httpRequest.responseText == null || httpRequest.responseText == "")
				{
					update_organizations(0,null);
				}

				if(id != 0 || id != null)
				{
					document.getElementById("city").value = id;
				}
			}
			else
			{
				alert("Ошибка!");
			}
		}
	}
	httpRequest.send(null);
}


function update_organizations(val_city,id)
{
	var httpRequest = createHttpRequest();
	httpRequest.open('get','/service/get_organizations?city='+val_city,true);
	httpRequest.onreadystatechange = function()
	{
		if (httpRequest.readyState == 4)
		{
			if (httpRequest.status == 200)
			{
				hash_orgs = eval(httpRequest.responseText);
				set_select_option(document.getElementById("doctor_organization_id"),hash_orgs, false);

				if(id != 0 || id != null)
				{
					document.getElementById("doctor_organization_id").value = id;
				}
			}
			else
			{
				alert("Ошибка!");
			}
		}
	}
	httpRequest.send(null);
}


function update_cities_filter(val_region,id)
{
	//alert("update_cities_filter "+val_region+" "+id)
	var httpRequest = createHttpRequest();
	httpRequest.open('get','/service/get_cities?region='+val_region,true);
	httpRequest.onreadystatechange = function()
	{
		if (httpRequest.readyState == 4)
		{
			if (httpRequest.status == 200)
			{
				//Получаю новый список городов
				hash_cities = eval(httpRequest.responseText);
				set_select_option(document.getElementById("filter_city"),hash_cities,true);

				if(httpRequest.responseText == null || httpRequest.responseText == "")
				{
					update_organizations_filter(0,null);
				}

				if(id != 0 || id != null)
				{
					document.getElementById("filter_city").value = id;
				}
			}
			else
			{
				alert("Ошибка!");
			}
		}
	}
	httpRequest.send(null);
}


function update_organizations_filter(val_city,id)
{
	//alert("update_cities_filter "+val_city+" "+id)
	var httpRequest = createHttpRequest();
	httpRequest.open('get','/service/get_organizations?city='+val_city,true);
	httpRequest.onreadystatechange = function()
	{
		if (httpRequest.readyState == 4)
		{
			if (httpRequest.status == 200)
			{
				hash_orgs = eval(httpRequest.responseText);
				set_select_option(document.getElementById("org"),hash_orgs,true);

				if(id != 0 || id != null)
				{
					document.getElementById("org").value = id;
				}
			}
			else
			{
				alert("Ошибка!");
			}
		}
	}
	httpRequest.send(null);
}


function set_select_option(select, hash_options, isShowAll)
{
	//Удаляю предыдущие данные
	for(i=select.length;i>=0;i--)
	{
		select.remove(i);
	}

	//Заполнить селект
	if(isShowAll == true)
	{
		select.options.add(new Option("Все",0));
	}

	for(i=0; i<hash_options.length;i++)
	{
		var select_item = hash_options[i];
		select.options.add(new Option(select_item["name"], select_item["id"]));
	}
}


//Сбрасываю значения фильтра
function clear_filter()
{
	document.getElementById("filter_region").selectedIndex=0;
	document.getElementById("filter_city").selectedIndex=0;
	document.getElementById("org").selectedIndex=0;
	document.getElementById("spec").selectedIndex=0;
}


function locateFooter()
{
	var offsetHeight = 34

	var bodyHeight = $(document.body).height();
	var winHeight = $(this).height();

	if(bodyHeight < winHeight)
	{
		$('.footer').css({
			position: 'absolute',
			top: winHeight-offsetHeight
		});
	}
}

function GetLicense()
{
	if(navigator.appName == "Opera")
	{
		window.open("/user/license");
	}
	else
	{
		$.ajax({
			url: '/service/get_license',
			dataType: "html",
			success: function(data)
			{
				ShowWindow(data);
			}
		});
	}
}

$('document').ready(function(){

	locateFooter();
	$(window).resize(locateFooter);

});
