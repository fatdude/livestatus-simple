require 'spec_helper'

describe 'Hosts' do
  before(:each) do
    @unix = ENV['LIVESTATUS_SOCKET']
    @conn = Livestatus::Connection.new({uri: "unix://" + @unix})
  end

  it "get a list of hosts" do
    status = @conn.get(Livestatus::Host)
    status.should be_a_kind_of Array
    status[0].should be_a_kind_of Livestatus::Host
    status[0].should respond_to(:data)
  end

  it "get filtered host #{ENV['HOST']}" do
    options = {filter: ["host_name = #{ENV['HOST']}"]}
    status = @conn.get(Livestatus::Host, options)
  end

  it "restrict attributes with columns" do
    options = {columns: 'host_name'}
    status = @conn.get(Livestatus::Host, options)
    expect {status[0].host_name}.to_not raise_error
    expect {status[0].alias }.to raise_error(KeyError)
  end

end
