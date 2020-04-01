class StudentsController < ApplicationController
    include SessionHelper
    include ScrapeHelper
    require 'digest/md5'
    
    #show the student dashboard page
    def show
        @majorList = StudentRequest::MAJOR_LIST
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        if session_get(:uin) == nil
            redirect_to root_path
        else
            @student_requests = StudentRequest.where(:uin => session_get(:uin))
        end 
    end
    
    def signup
        @majorList = StudentRequest::MAJOR_LIST
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        @student = Student.new
    end
    
    def update_profile
        @student = Student.where(:uin => session_get(:uin))
        @student_new_email = Student.where("email =?", params[:student_request][:email])
        @student_new_uin =  Student.where("uin = ?", params[:student_request][:uin])
        record = scrape_info(@student[0].lastname, @student[0].firstname, params[:student_request][:major] , params[:student_request][:email] )
        
        if @student[0].email != params[:student_request][:email]
            if !@student_new_email[0].nil?
                flash[:warning] = "The new email has already been taken."
                redirect_to students_profile_path      
                return                
            end
        end
        
        if @student[0].uin != params[:student_request][:uin]
            if !@student_new_uin[0].nil?
                flash[:warning] = "The new UIN has already been taken."
                redirect_to students_profile_path
                return
            end      
        end
        
        @student[0].uin = params[:student_request][:uin]
        @student[0].email = params[:student_request][:email]
        @student[0].minor = params[:student_request][:minor]
        if record.length() != 0
            @student[0].major = record['Major']
            @student[0].classification = record['Classification']
            @student[0].isVerified = true
            @student[0].save
        else
            @student[0].major = params[:student_request][:major]
            @student[0].classification = params[:student_request][:classification]
            @student[0].isVerified = false
            @student[0].save
        end
        session_update(:name, @student[0][:name])
        session_update(:current_state, "student")
        session_update(:uin, @student[0].uin)
        flash[:notice] = "The change has been applied."
        redirect_to students_show_path
    end
    
    
    def add_student_to_database(id)
        record = scrape_info(params[:session][:lastname], params[:session][:firstname], params[:session][:major], params[:session][:email])
        # if  record.length() != 0 #scrape the record check disabled
        # sign up email confirm feature
        if(id.nil?)
            #puts "====================" + params[:session][:password] + "====================================="
            if(record.length() != 0)
                @newStudent = Student.new(:name => record['First Name']+' '+record['Last Name'], :firstname => record['First Name'], :lastname => record['Last Name'],  :uin => params[:session][:uin], :email => record['Email Address'], :password => Digest::MD5.hexdigest(params[:session][:password]),
                                          :major => record['Major'], :classification => record['Classification'], :minor => params[:session][:minor], :isVerified => true)
            else
                @newStudent = Student.new(:name => params[:session][:firstname]+' '+params[:session][:lastname], :firstname => params[:session][:firstname], :lastname => params[:session][:lastname],  :uin => params[:session][:uin], :email => params[:session][:email], :password => Digest::MD5.hexdigest(params[:session][:password]),
                                          :major => params[:session][:major], :classification => params[:session][:classification], :minor => params[:session][:minor], :isVerified => false)
            end
        else
            @newStudent = Student.find(id)
        end
        @newStudent.email_confirm_sent_at = DateTime.now
        
        if @newStudent.save#succeed to create the account of student
            StudentMailer.registration_confirmation(@newStudent).deliver
            flash[:notice] = "An account has been created. A email has been sent to the provided email address, click the link to activate your account."
            redirect_to root_path
        else
            flash[:warning] = "Something went wrong, try again."
            redirect_to root_path
        end
        #below directory check bypassed 
        # else#can't scrape the record 
        #     flash[:warning] = "Your name and email didn't match the record in the TAMU system. Please visit: https://services.tamu.edu/directory-search/#adv-search for details"
        #     redirect_to students_signup_path
        # end  
    end
    
    # create a new student
    def create
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        @majorList = Major.pluck(:major_id)
        #check the reenter uin and email is same
        if params[:session][:uin2] == params[:session][:uin] and params[:session][:password2] == params[:session][:password]
            #use the uin and email to check if the student has signed up
            @student = Student.where("email = ? OR uin = ?",params[:session][:email],params[:session][:uin] )
            if @student[0].nil?#the student hasn't signed up before
                add_student_to_database(nil)
            #the student has signed up
            else
                if @student[0].email_confirmed?
                    flash[:warning] = "An account associated with "+params[:session][:uin]+" has been created. Please contact your ADMIN if you think this is a mistake."
                    redirect_to root_path
                elsif !@student[0].email_confirmed? and ((@student[0].email_confirm_sent_at.nil?? DateTime.new(1970,1,1) :@student[0].email_confirm_sent_at ) + 20.minute < DateTime.now)
                   add_student_to_database(@student[0].id)
                else
                    flash[:warning] = "Activation link already sent to Email "+ @student[0].email+" Please confirm the activation link."
                    redirect_to root_path
                end
            end
        else            
            flash[:warning] = "Those UINs or passwords didn't match. Try agagin."
            redirect_to students_signup_path
        end
    end
    
    def confirm_email
        @student = Student.where("confirm_token = '#{params[:id]}'")
        if @student[0]
            @student[0].email_activate
            flash[:notice] = "Welcome to Force Request System! Your email has been confirmed. Please sign in to continue."
            redirect_to root_path
        else
            flash[:warning] = "Sorry. The link is expired!"
            redirect_to root_path
        end
    end
    #after login to update the password(create new password)
    def update_password
        @student = Student.where(:uin => session_get(:uin))
        if @student[0].password == params[:session][:oldPassword]
            if params[:session][:password] == params[:session][:password2]
               
                @student[0].update_attribute(:password, Digest::MD5.hexdigest(params[:session][:password]))
                flash[:notice] = "Your password has been changed!"
                redirect_to students_show_path
            else
                flash[:warning] = "The twice entered new password must be same!"
                redirect_to students_edit_password_path 
            end
        else
            flash[:warning] = "The old password you entered is wrong!"
            redirect_to students_edit_password_path 
        end
    end
    #sent the reset forgotten password mail to student email
    def sent_reset_password_mail
        @student = Student.where("email ='#{params[:session][:email]}'")
        if @student[0].nil?#case : the UIN is not signed up
            flash[:warning] = "There is no account associated with the given email."
            redirect_to '/students/forget_password'  
        else
            @student[0].reset_password_confirmation_token#create the reset password confirmation token and the reset email sent time
            StudentMailer.reset_password(@student[0]).deliver
            flash[:notice] = "Please check your tamu email to reset your password!"
            redirect_to root_path
        end
    end
    #before login(forget the password) to update the password(create password)
    def reset_password 
        @student = Student.where("reset_password_confirm_token = '#{params[:id]}'")
        if @student[0] and !(@student[0].password_reset_expired?)
            session_update(:name, @student[0][:name])
            session_update(:current_state, "student")
            session_update(:uin, @student[0][:uin])
        else#case 1. the link expire; case 2. the link has been used
            flash[:warning] = "Sorry. The link is expired!"
            redirect_to root_path
        end
    end
    
    def update_reset_password
        @student = Student.where(:uin => session_get(:uin))
        if params[:session][:password] == params[:session][:password2]
            @student[0].update_attribute(:password, Digest::MD5.hexdigest(params[:session][:password]))
            @student[0].password_reset_done#finish the reset password
            session_update(:name, @student[0][:name])
            session_update(:current_state, "student")
            session_update(:uin, @student[0][:uin])
            flash[:notice] = "Your password has been changed!"
            redirect_to root_path
        else
            flash[:warning] = "The twice entered new password must be same!"
            redirect_to reset_password_url(@student[0].reset_password_confirm_token)
        end
    end
    
    def profile
        @majorList = StudentRequest::MAJOR_LIST
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        @students = Student.where(:uin => session_get(:uin))
    end
    
    def initForNewForceRequest
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        @YearSemester = StudentRequest::YEAR_SEMESTER
        @requestSemester = StudentRequest::REQUEST_SEMESTER
        @majorList = Major.pluck(:major_id)
    end
    
    def add_new_student
        initForNewForceRequest
    end
    
    def add_student
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        @majorList = Major.pluck(:major_id)
        if params[:session][:uin2] == params[:session][:uin]
          @students = Student.where("uin = '#{params[:session][:uin]}'")
          if @students[0].nil?
            #if scrape_info(params[:session][:name], params[:session][:email]) != {}
              # record = scrape_info(params[:session][:name], params[:session][:email])
              @newStudent = Student.create!(:name => params[:session][:name], :uin => params[:session][:uin], :email => params[:session][:email], :password => Digest::MD5.hexdigest(params[:session][:password]),
                                                  :major => params[:session][:major], :classification => params[:session][:classification])
              flash[:notice] = "Name:#{@newStudent.name}, UIN: #{@newStudent.uin}, Email: #{@newStudent.email} signed up successfully."
              StudentMailer.registration_confirmation(@newStudent).deliver
              redirect_to student_requests_adminprivileges_path
            #else
              #flash[:notice] = "Student information is incorrect!\nPlease use TAMU email!\nUse name as which is on Student ID!"
              #redirect_to student_requests_adminprivileges_path
            #end
          else
            flash[:notice] = "Student record is already there"
            redirect_to student_requests_adminprivileges_path
          end
        else
          flash[:notice] = "The twice entered UIN must be same!"
          redirect_to student_requests_adminprivileges_path
        end
    end
end