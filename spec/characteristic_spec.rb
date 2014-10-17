require 'spec_helper'
PROJECT_ROOT="./"


describe "Characteristic test" do


  (1..10).each do |seed|
    it "should produce the same output for the seed: #{seed}" do
      expected_output = File.read File.expand_path(File.join(PROJECT_ROOT, "spec/outputs/#{seed}.txt"))
      actual_output = `SEED=#{seed} #{PROJECT_ROOT}/bin/trivia`

      expect(actual_output).to eq expected_output
    end
  end

end



