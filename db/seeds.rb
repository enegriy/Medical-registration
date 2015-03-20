#coding:utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    
    if Rails.env != "production"
        _specs1 = Spec.create([{name: "Уролог"}])
        _specs2 = Spec.create([{name: "Терапевт"}])
        _specs3 = Spec.create([{name: "Хирург"}])
        _specs4 = Spec.create([{name: "Педиатр"}])
    end
    
    _role1 = Role.create([{name:"Администратор"}])
    _role2 = Role.create([{name:"Врач"}])
    _role3 = Role.create([{name:"Пользователь"}])

    _menu1 = Menu.create([{title: "Запись на прием", controller: "mainpage", action: "index"}])
    _menu2 = Menu.create([{title: "Личный кабинет", controller: "personal_room", action: "index"}])
    _menu3 = Menu.create([{title: "Профиль", controller: "doctor_manager", action: "show"}])
    _menu4 = Menu.create([{title: "Список записавшихся", controller: "ticket_manager", action: "list_tickets"}])
    _menu5 = Menu.create([{title: "Администрирование", controller: "admin", action: "index"}])

    _link_menu = MenuLinkRole.create([{role_id:_role3.first.id, menu_id:_menu1.first.id},
                                      {role_id:_role3.first.id, menu_id:_menu2.first.id},
                                      {role_id:_role2.first.id, menu_id:_menu1.first.id},
                                      {role_id:_role2.first.id, menu_id:_menu2.first.id},
                                      {role_id:_role2.first.id, menu_id:_menu3.first.id},
                                      {role_id:_role2.first.id, menu_id:_menu4.first.id},
                                      {role_id:_role1.first.id, menu_id:_menu1.first.id},
                                      {role_id:_role1.first.id, menu_id:_menu5.first.id}])

    _daytype1 = Daytype.create([{name:"Рабочий"}])
    _daytype2 = Daytype.create([{name:"Выходной"}])

    _dayofweek1 = Dayofweek.create([{name:"Понедельник"}])
    _dayofweek2 = Dayofweek.create([{name:"Вторник"}])
    _dayofweek3 = Dayofweek.create([{name:"Среда"}])
    _dayofweek4 = Dayofweek.create([{name:"Четверг"}])
    _dayofweek5 = Dayofweek.create([{name:"Пятница"}])
    _dayofweek6 = Dayofweek.create([{name:"Суббота"}])
    _dayofweek7 = Dayofweek.create([{name:"Воскресенье"}])

    Absence.create([{title: "Командировка"}])
    Absence.create([{title: "Больничный"}])
    Absence.create([{title: "Причина не указана"}])
