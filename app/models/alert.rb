# frozen_string_literal: true

# Alert model
class Alert < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  enum status: {
    created: 0,
    triggered: 1,
    deleted: 2
  }

  before_destroy :update_status

  scope :filtered_alerts, lambda { |user, status|
    @alerts = case status
              when 'created'
                user.alerts
              when 'deleted'
                user.alerts.only_deleted
              when 'triggered'
                user.alerts.where(status: 'triggered')
              else
                user.alerts.only_deleted + user.alerts
              end
  }

  def update_status
    update(status: 2)
  end
end
