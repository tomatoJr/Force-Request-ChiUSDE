And /^I click Download button$/ do
    click_link('Download Force Request System Logs data (.csv)')
end   

And /^I click Download logs button$/ do
    click_link('Download Force Request System Logs data (.csv)')
end  
    
Then /^I should get a download with the All_force_requests.csv$/ do 
    page.response_headers['Content-Disposition'].should include("filename=\"#{"All_request_logs.csv"}\"")
end

Then /^I should get a download with the All_request_logs.csv$/ do 
    page.response_headers['Content-Disposition'].should include("filename=\"#{"All_request_logs.csv"}\"")
end