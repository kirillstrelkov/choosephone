module RedisHelper
  def get(prefix, key)
    key = prepare_key(prefix, key)
    value = Rails.cache.read(key)
    Rails.logger.debug "RedisHelper.get(''#{prefix}', '#{key}') -> '#{value}'"
    value
  end

  def set(prefix, key, value)
    key = prepare_key(prefix, key)
    Rails.logger.debug "RedisHelper.set('#{prefix}', '#{key}', '#{value}')"
    Rails.cache.write(key, value)
  end

  private

  def prepare_key(prefix, key)
    [prefix, key].map(&:to_s).map(&:downcase).map do |e|
      e.gsub(/[\s-]+/, '_')
    end.join(':')
  end
end
