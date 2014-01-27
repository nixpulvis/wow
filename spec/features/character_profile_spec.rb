require "spec_helper"

describe WoW::CharacterProfile do
  subject { WoW::CharacterProfile.new("Stormreaver", "Epicgrim") }

  describe "#initialize" do
    it "is valid server, and name" do
      expect {
        subject
      }.not_to raise_error
    end

    it "is valid with special characters in name" do
      expect {
        WoW::CharacterProfile.new("Stormreaver", "Disciplíne")
      }.not_to raise_error
    end

    it "is invalid server" do
      expect {
        WoW::CharacterProfile.new("Notaserver", "Epicgrim")
      }.to raise_error
    end

    it "is invalid name" do
      expect {
        WoW::CharacterProfile.new("Stormreaver", "Imnotaguyatalllolplz")
      }.to raise_error
    end

    it "is invalid server and name" do
      expect {
        WoW::CharacterProfile.new("Notaserver", "Imnotaguyatalllolplz")
      }.to raise_error
    end

    it "raises WoW::APIError when given nil or server" do
      expect {
        WoW::CharacterProfile.new(nil, "Imnotaguyatalllolplz")
      }.to raise_error(WoW::APIError)
    end

    it "raises WoW::APIError when given blank or server" do
      expect {
        WoW::CharacterProfile.new("", "Imnotaguyatalllolplz")
      }.to raise_error(WoW::APIError)
    end
  end

  describe "#lookup" do
    it "looks up class" do
      subject.lookup(:class).should eq(:druid)
    end
  end

  describe "#[]" do
    it "acts as a hash" do
      subject[:name].should eq("Epicgrim")
    end
  end

end