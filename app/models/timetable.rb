#coding:utf-8

class Timetable < ActiveRecord::Base

  attr_accessible :time_for, :time_to, :time_of_visit

  belongs_to :doctor
  belongs_to :daytype
  belongs_to :dayofweek

  validate :valid_timeofvisit,
           :valid_date_for


  private
  #Выходной
  WeekEnd = 2
  #Строковые константв для валидации
  FieldTimeOfVisit = "Длительность приема: "
  FieldTimeFor = "Начало работы"

  MessageNotNull = "необходимо заполнить"
  MessageNotMore120 = "не может быть более 120 минут"
  MessageMoreZero = "не может быть отрицательным числом"
  MessageTimeFor = " не может быть больше окончания работы"


  #Валидаторы
  def valid_timeofvisit
    if daytype_id != WeekEnd and time_of_visit.nil?
      errors.add(FieldTimeOfVisit, MessageNotNull)
    end

    if not time_of_visit.nil? and time_of_visit > 120
      errors.add(FieldTimeOfVisit, MessageNotMore120)
    end

    if not time_of_visit.nil? and time_of_visit < 0
      errors.add(FieldTimeOfVisit, MessageMoreZero)
    end
  end

  def valid_date_for
    if time_for > time_to
      errors.add(FieldTimeFor, MessageTimeFor)
    end
  end

end
