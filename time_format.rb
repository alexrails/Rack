class TimeFormat

  attr_reader :invalid

  VALID_FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  def initialize(params)
    @valid = []
    @invalid = []
    @formats = params['format'].split(',')
  end

  def valid?
    invalid.empty?
  end

  def result
    Time.now.strftime(@valid.join('-'))
  end

  def call
    @formats.each do |format|
      if VALID_FORMATS[format]
        @valid << VALID_FORMATS[format]
      else
        @invalid << format
      end
    end
  end

end
