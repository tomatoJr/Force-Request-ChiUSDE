# spec/mailers/student_mailer_spec.rb
# example for how to write this test can be found at
# https://www.lucascaton.com.br/2010/10/25/how-to-test-mailers-in-rails-with-rspec/
# Please rake db:test:prepare before testing!!!
require 'spec_helper'

RSpec.describe StudentMailer, type: :mailer do
  describe 'registration_confirmation' do
    before :each do
      @student = Student.new( name: 'Bernard Lowe', email: 'blowe@westworld.com', password: 'IAmArnorld', uin: 12345678)
      @student.save
    end

    let(:mail) { described_class.registration_confirmation(@student).deliver_now }

    it 'renders the subject' do
      StudentMailer.registration_confirmation(@student)
      expect(mail.subject).to eq('Registration Confirmation')
      expect(mail.to).to eq(['blowe@westworld.com'])
    end

    after :each do
      @student.destroy
    end
  end

  describe 'update_force_state' do
    before :each do
      @student = Student.new( name: 'Sulav Adhikari', email: 'saberMonkey47@tamu.edu', password: 'welcome1', uin: 12345678)
      @fake_student_request = FactoryGirl.create(:student_request)
      @fake_admin = FactoryGirl.create(:admin)
      @student.save
    end
    let(:mail) { described_class.update_force_state(@student,@fake_student_request,"Sample Message").deliver_now }

    it 'renders the subject' do
      StudentMailer.update_force_state(@student, @fake_student_request,"Sample Message")
      expect(mail.subject).to eq('Updates on Your Force Request')
      expect(mail.to).to eq(['saberMonkey47@tamu.edu'])
      expect(mail.bcc).to eq(['IAmSchaeffer@tamu.edu'])
    end
  end

  describe 'confirm_force_request' do
    before :each do
      @fake_student_request = FactoryGirl.create(:student_request)
      @student = Student.new( name: 'Bernard Lowe', email: 'blowe@westworld.com', password: 'IAmArnorld', uin: 12345678)
      @student.save
    end

    let(:mail) { described_class.confirm_force_request(@student, @fake_student_request).deliver_now }

    it 'renders the subject' do
      StudentMailer.confirm_force_request(@student, @fake_student_request)
      expect(mail.subject).to eq('Request Confirmation')
      expect(mail.to).to eq(['blowe@westworld.com'])
    end

    after :each do
      @student.destroy
    end
  end
end
