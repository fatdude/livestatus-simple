require 'spec_helper'

describe 'LivestatusSimple' do
  it "get module livestatus initialized" do 
    expect(LivestatusSimple).to be_kind_of(Module)
  end

  context "checking system installation" do
    before(:each) do
      @unix = ENV['LIVESTATUS_SOCKET']
    end

    it "livestatus socket should exist" do
      expect(File.exists?(@unix)).to be(true)
      expect(File.socket?(@unix)).to be(true)
    end

    it "livestatus socket should be writable" do
      expect(File.writable?(@unix)).to be(true)
    end
  end
end
