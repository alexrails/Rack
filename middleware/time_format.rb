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
    check_format
  end

  def call
    Time.now.strftime(@valid.join('-'))
  end

  def valid?
    invalid.empty?
  end

  private

  def check_format
    @formats.each do |format|
      if VALID_FORMATS[format]
        @valid << VALID_FORMATS[format]
      else
        @invalid << format
      end
    end
  end
end
