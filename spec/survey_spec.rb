require 'spec_helper'

describe(Survey) do

  describe '#titlecase_survey' do
     it 'converts inputted string to titlecase' do
       test_survey = Survey.create({:survey => 'what is your favorite color'})
       expect(test_survey.survey).to eq 'What Is Your Favorite Color'
     end
   end
end
