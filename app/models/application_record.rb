# frozen_string_literal: true

# application_record
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def secret
    Rails.application.credentials[:secret_key_base]
  end

  def encoding
    Rails.application.credentials[:encoding]
  end
end
