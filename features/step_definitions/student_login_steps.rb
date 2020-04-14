Given /the following activators exist/ do |students_table|
    students_table.hashes.each do |student|
        @tmp = Student.create student
    end
end

When(/^I am on the Login Page$/) do
  visit('/')
  page.should have_content("Login Page")
end

When(/^I login in with a account doesn't exsit$/) do
  @user_info = {:email => "789789789@hotmail.com",  :password => "456789"}
  fill_in('Enter your Email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  click_button('Login')
end

When(/^I enter wrong login information$/) do
  @user_info = {:email => "adb3649@tamu.edu",  :password => "111111"}
    page.should have_content("Login Page")
  fill_in('Enter your Email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  click_button('Login')
end

When(/^I login in with account has not been activate$/) do
  @user_info = {:email => "notActivate@tamu.edu",  :password => "NOTACTIVATE"}
  fill_in('Enter your Email', :with => @user_info[:email])
  fill_in('Enter your password', :with => @user_info[:password])
  click_button('Login')
end


When(/^I should stay at the same page$/) do
  page.should have_content("Login Page")
end

Then(/^I should see a non-account exsits message$/) do
  page.should have_content("The account doesn't exist. Please sign up first.")
end

Then(/^I should see a error message$/) do
  page.should have_content("Entered Email and Password didn't match. Try again.")
end

Then(/^I should see a not-activated message$/) do
  page.should have_content("The account has not been activated.")
end




