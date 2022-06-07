class NepaliCalendar::FiscalYear

    attr_accessor :start_year, :end_year

    def initialize(start_year, end_year)
        @start_year = start_year
        @end_year = end_year
    end
        
        # returns start of fiscal year date in BS
    def beginning_of_year
        start_date = start_year.to_s.prepend('20')
        NepaliCalendar::Calendar.new(nil, {year: start_date, month: 4, day: 1})
    end
        
        # returns end of fiscal year date in BS
    def end_of_year
        end_date = end_year.to_s.prepend('20')
        NepaliCalendar::Calendar.new(nil, {year: end_date, month: 3, day: NepaliCalendar::BS[end_date.to_i][3]})
    end


        # returns fiscal year date in AD
    def self.fiscal_year_for_ad_date(ad_date)
        bs_date = NepaliCalendar::BsCalendar.ad_to_bs(ad_date.year.to_s, ad_date.month.to_s, ad_date.day.to_s)
        if bs_date.month < 4
          fiscal_year = ((ad_date.year - 1).to_s.slice(2,2)).to_s + ad_date.year.to_s.slice(2,2).to_s
        else
          fiscal_year =ad_date.year.to_s.slice(2,2).to_s + ((ad_date.year + 1).to_s.slice(2,2)).to_s
        end
    end
        # returns fiscal year date in BS
    def self.fiscal_year_for_bs_date(date) # (2079, 2, 12) ==> 7879
      bs_date = NepaliCalendar::Calendar.new(date)
        if bs_date.month < 4 
          fiscal_year = (bs_date.year - 1).to_s.slice(2,2).to_s + bs_date.year.to_s.slice(2,2).to_s
        else
          fiscal_year = bs_date.year.to_s.slice(2,2).to_s + (bs_date.year + 1).to_s.slice(2,2).to_s
        end
    end

    # [date] -> This is a Date object (and obviously represents AD date)
    # Returns the fiscal year represented as a string in the form of 7778.
    def self.fiscal_year_in_bs_for_ad_date(date)
        bs_date = NepaliCalendar::BsCalendar.ad_to_bs(date.year.to_s, date.month.to_s, date.day.to_s)
        if bs_date.month < 4
          fiscal_year = ((bs_date.year - 1).to_s.slice(2,2)).to_s + bs_date.year.to_s.slice(2,2).to_s
        else
          fiscal_year =bs_date.year.to_s.slice(2,2).to_s + ((bs_date.year + 1).to_s.slice(2,2)).to_s
        end
    end

        # Returns the fiscal year represented as a string in the form of 7778.
    def self.get_fiscal_year_from_bs(bs_date) # "20790218" represents 18th Jestha 2079
        year = bs_date.slice(0,4).to_i
        month = bs_date.slice(4, 2).to_i
        day = bs_date.slice(6, 2).to_i
        if month < 4 
          fiscal_year = (year - 1).to_s.slice(2,2).to_s + year.to_s.slice(2,2).to_s
        else
          fiscal_year = year.to_s.slice(2,2) + (year + 1).to_s.slice(2,2)
        end
    end
        # Returns the  current fiscal year represented as a string in the form of 7778.
    def self.current_fiscal_year
      bs_date_today = NepaliCalendar::BsCalendar.ad_to_bs(Date.today.year, Date.today.month, Date.today.day)
      if bs_date_today.month < 4
        fiscal_year = (bs_date_today.year-1).to_s.slice(2,2) + bs_date_today.year.to_s.slice(2,2)
      else
        fiscal_year = bs_date_today.year.to_s.slice(2,2) + (bs_date_today.year+1).to_s.slice(2,2)
      end

      NepaliCalendar::FiscalYear.new(fiscal_year.to_s.slice(0,2), fiscal_year.to_s.slice(2,2))
    end
        
        # Should return the '7879' form of string.
    def to_s
        start_year.to_s + end_year.to_s
    end

end