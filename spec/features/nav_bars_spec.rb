require 'spec_helper'

describe "NavBars" do
  
  it "should have the right buttons" do
    visit '/'
    page.should have_content('Home')
  end
  
end
