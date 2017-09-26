class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:survey, {:presence => true, :length => {:maximum => 50}})
  before_save(:titlecase_survey)

private

  def titlecase_survey
    words = self.survey.split
    words.each do |word|
      unless (word.include?("of")) || (word.include?("the")) && (word.first "the")
        word.capitalize!
      end
    end
    self.survey = words.join(" ")
  end
end
