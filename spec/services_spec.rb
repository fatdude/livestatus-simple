require 'spec_helper'

describe 'Services' do
  before(:each) do
    @unix = ENV['LIVESTATUS_SOCKET']
    @conn = Livestatus::Connection.new({uri: "unix://" + @unix})
  end

  it "get a list of services" do
    status = @conn.get(Livestatus::Service)
    status.should be_a_kind_of Array
    status[0].should be_a_kind_of Livestatus::Service
    status[0].should respond_to(:data)
  end

  it "get only services for host #{ENV['HOST']}" do
    options = {filter: ["host_name = #{ENV['HOST']}"]}
    status = @conn.get(Livestatus::Service, options)
    status.each do |s|
      s.host_name.should == ENV['HOST']
    end
  end

  it "restrict attributes with columns" do
    options = {columns: 'host_name description'}
    status = @conn.get(Livestatus::Service, options)
    expect {status[0].host_name}.to_not raise_error
    expect {status[0].description}.to_not raise_error
    expect {status[0].host_status }.to raise_error(KeyError)
  end

end
