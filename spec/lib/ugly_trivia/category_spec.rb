require 'spec_helper'
require_relative '../../../lib/ugly_trivia/category'


describe UglyTrivia::Category do

  subject { described_class.new 'Pop' }

  describe "#initialize" do
    it "should have no questions" do
      expect(subject.questions).to eq []
    end


    it "should have a name" do
      expect(subject.name).to eq 'Pop'
    end


    it "should set the value if it's provided" do
      subject = described_class.new 'Pop', 5

      expect(subject.value).to eq 5
    end


    it "should have the default value 1" do
      expect(subject.value).to eq 1
    end
  end


  describe "#add_question" do
    it "should add the question" do
      subject.add_question 'One question'
      subject.add_question 'Another question'

      expect(subject.questions).to eq [
                                        'One question',
                                        'Another question'
                                      ]

    end
  end


  describe "#next_question" do

    it "should retrieve the next question" do
      subject.add_question 'One question'
      subject.add_question 'Another question'

      expect(subject.next_question).to eq 'One question'
      expect(subject.next_question).to eq 'Another question'

    end
  end


end