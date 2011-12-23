class Livestatus::Status < Livestatus::Base
  table_name 'status'

  boolean_attributes :accept_passive_host_checks,
    :accept_passive_service_checks, :check_external_commands,
    :check_host_freshness, :check_service_freshness, :enable_event_handlers,
    :enable_flap_detection, :enable_notifications, :execute_host_checks,
    :execute_service_checks, :external_commands, :obsess_over_hosts,
    :obsess_over_services, :process_performance_data

  time_attributes :program_start, :last_log_rotation, :last_command_check
end
