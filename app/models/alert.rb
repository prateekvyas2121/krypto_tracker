class Alert < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  enum status: {
    created: 0,
    triggered: 1,
    deleted: 2
  }

  # after_commit :update_status, on: [:create, :destroy]
  before_destroy :update_status

  scope :filtered_alerts, ->(user, status) { 
      if status.eql?('created')
          @alerts = user.alerts
      elsif status.eql?('deleted')
          @alerts = user.alerts.only_deleted
      else
        @alerts = user.alerts.only_deleted + user.alerts
      end
  }

  def update_status
    debugger
    update(status: 2)
  end

end
