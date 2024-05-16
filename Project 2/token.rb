# A token class that includes type, token, and start/end indices
class Token
  attr_reader :type, :token, :start_i, :end_i
  attr_reader :token

  def initialize(type, token, start_i, end_i)
    @type = type
    @token = token
    @start_i = start_i
    @end_i = end_i
  end
end