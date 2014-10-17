require 'spec_helper'
require_relative '../../../lib/ugly_trivia/player'


describe UglyTrivia::Player do
  subject { described_class.new "Gunesh" }


  describe "#initialize" do
    it "should setup the player's name" do
      expect(subject.name).to eq "Gunesh"
    end


    it "should setup the player's purse" do
      expect(subject.coins).to eq 0
    end


    it "should setup the player's position" do
      expect(subject.position).to eq 0
    end


    it "should setup the player's in_penalty flag" do
      expect(subject.in_penalty?).to eq false
    end
  end


  describe "#in_penalty!" do
    it "should send the player to penalty" do
      subject.in_penalty!

      expect(subject.in_penalty?).to eq true
    end
  end

  end