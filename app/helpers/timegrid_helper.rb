#coding:utf-8

module TimegridHelper


  # @param date [Date]
  def self.get_day_title(date)
    rslt = 'Понедельник'
    if date.tuesday?
      rslt = 'Вторник'
    elsif date.wednesday?
      rslt = 'Среда'
    elsif date.thursday?
      rslt = 'Четверг'
    elsif date.friday?
      rslt = 'Пятница'
    elsif date.saturday?
      rslt = 'Суббота'
    elsif date.sunday?
      rslt = 'Воскресенье'
    end
    rslt
  end



  # @param date [Date]
  def self.get_weekday(date)
    rslt = date.wday
    if rslt == 0
        rslt = 7
    end
    rslt
  end



  # @param time_start [Time]
  # @param time_finish [Time]
  # @param visit_time [Integer]
  def self.get_count_visit(time_start,time_finish,visit_time)
    count = time_finish - time_start
    count = (count / (visit_time*60)).to_int
    count
  end



  # @param arr [Array]
  # @param item [Time]
  def self.array_is_content(arr, item)
    rslt = false
    arr.each do |d|
      if d == item
        rslt = true
      end
    end
    rslt
  end
end
