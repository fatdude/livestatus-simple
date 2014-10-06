require 'spec_helper'

describe 'Connection' do
  context "with wrong setup" do
    it "raise an ArgumentError on unknown handlers" do
      conn = LivestatusSimple::Connection.new({uri: "fun:///nowhere/nonexistent"})
      expect {
        conn.get(LivestatusSimple::Status)
      }.to raise_error(ArgumentError)
    end

    it "raise an Error on nonexistent unix socket" do
      conn = LivestatusSimple::Connection.new({uri: "unix:///nowhere/nonexistent"})
      expect {
        conn.get(LivestatusSimple::Status)
      }.to raise_error
    end
  end

  context "with functional livestatus socket" do
    before(:each) do
      @unix = ENV['LIVESTATUS_SOCKET']
      @conn = LivestatusSimple::Connection.new({uri: "unix://" + @unix})
    end

    it "livestatus socket should exist" do
      expect(@conn).to be_a_kind_of(LivestatusSimple::Connection)
    end

    it "get LivestatusSimple::Status should deliver some status data" do
      status = @conn.get(LivestatusSimple::Status)[0]
      expect(status).to be_a_kind_of(LivestatusSimple::Status)
      expect(status).to respond_to(:accept_passive_host_checks)
      expect(status).to respond_to(:program_start)
      expect(status.data).to include(:livestatus_version)
      expect(status.livestatus_version).to match(/\d+\.\d+\.\d+/)
    end

    it "get livestatus instance should raise an error on non existent attributes" do
      status = @conn.get(LivestatusSimple::Status)[0]
      expect { status.nonexistent }.to raise_error(KeyError)
    end
  end
end
