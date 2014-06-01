require 'spec_helper'

describe 'Livestatus' do
  it "get module livestatus initialized" do 
    Livestatus.should be_a_kind_of Module
  end

  context "checking system installation" do
    before(:each) do
      @unix = ENV['LIVESTATUS_SOCKET']
    end

    it "livestatus socket should exist" do
      expect(File.exists?(@unix)).to be_true
      expect(File.socket?(@unix)).to be_true
    end

    it "livestatus socket should be writable" do
      expect(File.writable?(@unix)).to be_true
    end
  end
end
