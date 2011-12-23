module Livestatus
  OPERATORS = {
    :eq => '=',
    :eqi => '=~',
    :ge => '>=',
    :gt => '>',
    :le => '<=',
    :lt => '<',
    :match => '~',
    :matchi => '~~',
    :neq => '!=',
    :neqi => '!=~',
    :nmatch => '!~',
    :nmatchi => '!~~',
  }
end
