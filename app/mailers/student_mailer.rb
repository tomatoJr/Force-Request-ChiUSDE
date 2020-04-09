class StudentMailer < ActionMailer::Base
    # default :from => 'shadowc962@gmail.com'
    default :from => 'forcerequestspring19@gmail.com'

    def registration_confirmation(student)
        @student = student
        # mail(:to => "#{student.name} <#{student.email}>", :subject => "Registration Confirmation")
        mail(:to => @student.email, :subject => "Registration Confirmation")
    end

    def confirm_force_request(student, req)
        @student = student
        @req = req
        mail(:to => @student.email, :subject => "Request Confirmation")
    end

    def reset_password(student)
        @student = student
        mail(:to => @student.email, :subject => "Reset Your Password")
    end
    
    def update_force_state(student, req, message)
        @student = student
        @req =req
        @message = message
        @message.gsub! '<NAME_PLACE_HOLDER>', @student.name
        @message.gsub! '<COURSE_ID_PLACE_HOLDER>', @req.course_id
        @message.gsub! '<SECTION_ID_PLACE_HOLDER>', @req.section_id
        @message.gsub! '<STATUS_PLACE_HOLDER>', @req.state
        @admins = Admin.all
        @admin_emails = Array.new
        @admins.each do |admin|
            @admin_emails.push(admin.email)
        end
        mail(:to => @student.email, :bcc => @admin_emails,  :subject => "Updates on Your Force Request")
    end
end