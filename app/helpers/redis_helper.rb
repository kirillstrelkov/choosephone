module RedisHelper
  def get(prefix, key)
    key = prepare_key(prefix, key)
    value = Rails.cache.read(key)
    value.nil? ? value : JSON.parse(value)
  end

  def set(prefix, key, value)
    key = prepare_key(prefix, key)
    value = JSON.dump(value) if value.is_a?(Hash)
    Rails.cache.write(key, value)
  end

  private

  def prepare_key(prefix, key)
    [prefix, key].map(&:to_s).map(&:downcase).map { |e| e.gsub(/\s+/, '_') }.join(':')
  end
end
