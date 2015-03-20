module MainpageHelper

  def self.nil_to_zero(val)
    if val.nil?
      0
    else
      val
    end
  end

end
