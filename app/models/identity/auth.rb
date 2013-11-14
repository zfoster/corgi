class Identity::Auth
  def initialize(auth)
    @auth = auth
  end

  def extract
    { credentials: @auth['credentials'], info: @auth['info'].reject{ |key, value| value.is_a?(Hash)} }
  end
end