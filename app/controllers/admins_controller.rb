class AdminsController < ApplicationController
    include SessionHelper
    include ScrapeHelper
    require "openssl"
    require "digest"
    require 'digest/md5'
    
    
  def encrypt(data)
    
  end
  
  def aes256_decrypt(key, data)
    key = Digest::SHA256.digest(key) if(key.kind_of?(String) && 32 != key.bytesize)
    aes = OpenSSL::Cipher.new('AES-256-CBC')
    aes.decrypt
    aes.key = Digest::SHA256.digest(key)
    aes.update(data) + aes.final
  end
  
  
  
  def addAdmin
    # puts 123
    # #@puts aes256_encrypt('0B2A0BE4BCB0976BFB9D1E5EA8D24500833D6FBD74F6D297464B8FFB17AE5264', params[:admin_request][:password])
    
    # puts aes256_decrypt('0B2A0BE4BCB0976BFB9D1E5EA8D24500833D6FBD74F6D297464B8FFB17AE5264', aes256_encrypt('0B2A0BE4BCB0976BFB9D1E5EA8D24500833D6FBD74F6D297464B8FFB17AE5264', 'jiang'))
    # puts 312
    
    
    admin_request_params = {:uin => params[:admin_request][:uin],
                            :name => params[:admin_request][:name],
                            
                            :password => Digest::MD5.hexdigest(params[:admin_request][:password]),
                            :email => params[:admin_request][:email]}
    
    
                            
    @admin_request = Admin.new(admin_request_params)
    if @admin_request.save
      flash[:notice] = "Admin was successfully created."
      redirect_to student_requests_adminview_path
    else
      flash[:warning] = @admin_request.errors.full_messages.join(",")
      redirect_to student_requests_adminview_path
    end
  end


end