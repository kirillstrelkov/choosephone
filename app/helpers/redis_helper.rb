module RedisHelper
  def get(prefix, key)
    key = prepare_key(prefix, key)
    Rails.cache.read(key)
  end

  def set(prefix, key, value)
    key = prepare_key(prefix, key)
    Rails.cache.write(key, value)
  end

  private

  def prepare_key(prefix, key)
    [prefix, key].map(&:to_s).map(&:downcase).map do |e|
      e.gsub(/[\s-]+/, '_')
    end.join(':')
  end
end
