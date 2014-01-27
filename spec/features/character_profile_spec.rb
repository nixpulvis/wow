require "spec_helper"

describe WoW::Character do
  subject { WoW::Character.new("Stormreaver", "Epicgrim", [:talents]) }

  describe "#initialize" do
    it "is valid server, and name" do
      expect {
        subject
      }.not_to raise_error
    end

    it "is valid with special characters in name" do
      expect {
        WoW::Character.new("Stormreaver", "Disciplíne")
      }.not_to raise_error
    end

    it "is invalid server" do
      expect {
        WoW::Character.new("Notaserver", "Epicgrim")
      }.to raise_error
    end

    it "is invalid name" do
      expect {
        WoW::Character.new("Stormreaver", "Imnotaguyatalllolplz")
      }.to raise_error
    end

    it "is invalid server and name" do
      expect {
        WoW::Character.new("Notaserver", "Imnotaguyatalllolplz")
      }.to raise_error
    end

    it "raises WoW::APIError when given nil or server" do
      expect {
        WoW::Character.new(nil, "Imnotaguyatalllolplz")
      }.to raise_error
    end

    it "raises WoW::APIError when given blank or server" do
      expect {
        WoW::Character.new("", "Imnotaguyatalllolplz")
      }.to raise_error
    end
  end

  describe "#[]" do
    it "acts as a hash with strings" do
      subject["name"].should eq("Epicgrim")
    end

    it "doesn't act as a hash with symbols" do
      subject[:name].should_not eq("Epicgrim")
    end
  end

  describe "#gets" do
    it "returns an array" do
      subject.gets.should be_an(Array)
    end

    it "contains strings that are valids arguments to #get" do
      subject.gets.each do |name|
        expect { subject.get(name) }.not_to raise_error
      end
    end
  end

  describe "#get?" do
    it "returns true when calling #get would succeed" do
      subject.get?("class").should be_true
    end

    it "returns false when calling #get would fail" do
      subject.get?("foo").should be_false
    end
  end

  describe "#get" do
    it "gets the characters class" do
      subject.get("class").should eq("druid")
    end

    it "gets the characters active spec" do
      spec_name = subject.get("active_spec")["spec"]["name"]
      ["Balance", "Guardian"].should include(spec_name)
    end

    it "gets the characters inactive spec" do
      spec_name = subject.get("inactive_spec")["spec"]["name"]
      ["Balance", "Guardian"].should include(spec_name)
    end

    it "gets the characters thumbnail" do
      subject.get("thumbnail").should match(/http.*/)
    end
  end
end
