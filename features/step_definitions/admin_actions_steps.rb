And /^I click Download button$/ do
    click_link('Download the entire Force Request System data as an Excel Sheet')
end   

And /^I click Download logs button$/ do
    click_link('Download the entire Force Request System Logs data as an Excel Sheet')
end  
    
Then /^I should get a download with the All_force_requests.csv$/ do 
    page.response_headers['Content-Disposition'].should include("filename=\"#{"All_force_requests.csv"}\"")
end

Then /^I should get a download with the All_request_logs.csv$/ do 
    page.response_headers['Content-Disposition'].should include("filename=\"#{"All_request_logs.csv"}\"")
end