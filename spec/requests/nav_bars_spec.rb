require 'spec_helper'

describe "NavBars" do
  
  it "should have the Home," do
    visit '/'
    page.should have_content('Home')
    page.should have_content('Fixtures')
  end
  
end
