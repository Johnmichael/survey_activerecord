require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_expections, false)

describe('the surveys path', {:type => :feature}) do
  it('takes a user input, creates a new survey and display as list') do
    visit('/designer')
    fill_in('survey', :with => 'what is your favorite color')
    click_button('Create Survey')
    expect(page).to have_content('What Is Your Favorite Color')
  end
end
