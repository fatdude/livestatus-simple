class LivestatusSimple::Host < LivestatusSimple::Base
  include LivestatusSimple::CheckType
  include LivestatusSimple::State

  boolean_attributes :accept_passive_checks, :acknowledged,
    :active_checks_enabled, :checks_enabled, :event_handler_enabled,
    :flap_detection_enabled, :has_been_checked, :in_check_period,
    :in_notification_period, :is_executing, :is_flapping,
    :notifications_enabled, :obsess_over_host, :pending_flex_downtime,
    :process_performance_data

  time_attributes :last_check, :last_hard_state, :last_hard_state_change,
    :last_notification, :last_state_change, :last_time_down,
    :last_time_unreachable, :last_time_up, :next_check, :next_notification

  def services
    @data[:services_with_state].map do |service|
      LivestatusSimple::Service.new({
        :display_name => service[0],
        :state => service[1],
      })
    end
  end
end
