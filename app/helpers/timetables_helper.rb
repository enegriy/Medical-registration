module TimetablesHelper


  #param date [Date]
  #param doctor_id [int]
  #param num_day [int]
  def self.get_tickets_more_date(doctor_id,date,num_day)

    date_start = date
    date_finish = date + 14

    all_tickets = []
    @tickets = nil

    while date_start < date_finish do

      if date_start.cwday == num_day.to_i
        @tickets = Ticket.where("doctor_id = ? and cast(visit_date as date) = ?",doctor_id,date_start)
      end

      if not @tickets.nil? and @tickets.count > 0
        all_tickets += @tickets
        @tickets = nil
      end

      date_start += 1

    end

    all_tickets
  end


end
