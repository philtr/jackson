require "rails_helper"

describe Avatar do
  let(:user) { build(:user) }

  subject { Avatar.new(user) }

  describe "#url" do
    it "returns a url" do
      expect { URI.parse(subject.url) }.not_to raise_error
    end
  end

  describe "#gravatar" do
    it "returns a gravatar url" do
      expect(subject.gravatar).to match(%r{^https://www.gravatar.com})
    end
  end

  describe "#to_s" do
    it "calls #url" do
      expect(subject).to receive(:url)
      subject.to_s
    end
  end
end
