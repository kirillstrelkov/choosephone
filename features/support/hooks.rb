# frozen_string_literal: true

Before do
  $dunit ||= false
  unless $dunit
    Rails.cache.clear
    $dunit = true
  end
end
