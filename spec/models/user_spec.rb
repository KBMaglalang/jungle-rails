require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before :each do
      @test_user = User.new({ first_name: 'test_fn', last_name: 'test_ln', email: 'test@test.com',
                              password: 'password', password_confirmation: 'password' })
    end

    it 'create user succesfully' do
      expect(@test_user).to be_valid
    end

    it 'validate: first name' do
      @test_user.first_name = nil
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include("First name can't be blank")
    end

    it 'validate: last name' do
      @test_user.last_name = nil
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'validate: email' do
      @test_user.email = nil
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include("Email can't be blank")
    end

    it 'validate: email is already exists' do
      @test_user.save
      another_test_user = User.new({ first_name: 'another_test_fn', last_name: 'another_test_ln',
                                     email: 'test@test.com', password: 'password', password_confirmation: 'password' })
      another_test_user.save
      expect(another_test_user).to be_invalid
      expect(another_test_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'validate: email is unique and case insensitive' do
      @test_user.save
      another_test_user = User.new({ first_name: 'another_test_fn', last_name: 'another_test_ln',
                                     email: 'TEST@TEST.com', password: 'password', password_confirmation: 'password' })
      another_test_user.save
      expect(another_test_user).to be_invalid
      expect(another_test_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'validate: password and mismatch with password confirmation' do
      @test_user.password = nil
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include("Password can't be blank")
    end

    it 'validate: password confirmation and mismatch with password' do
      @test_user.password_confirmation = nil
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include('Password confirmation is too short (minimum is 4 characters)')
    end

    it 'validate: password and confirmation blank' do
      @test_user.password = nil
      @test_user.password_confirmation = nil
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include("Password can't be blank")
    end

    it 'validate: password minimum length of 4' do
      @test_user.password_confirmation = 'pas'
      @test_user.password = 'pas'
      expect(@test_user).to be_invalid
      expect(@test_user.errors.full_messages).to include('Password is too short (minimum is 4 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @test_user = User.new({ first_name: 'test_fn', last_name: 'test_ln', email: 'test@test.com',
                              password: 'password', password_confirmation: 'password' })
      @test_user.save
    end
    it 'authentication class method - valid information' do
      expect(User.authenticate_with_credentials('test@test.com', 'password')).to eq(@test_user)
    end
    it 'authentication nil arguments' do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end
    it 'authentication nil arguments - email nil' do
      expect(User.authenticate_with_credentials(nil, 'password')).to eq(nil)
    end
    it 'authentication nil arguments - password nil' do
      expect(User.authenticate_with_credentials('test@test.com', nil)).to eq(nil)
    end
    it 'authentication email does not exist' do
      expect(User.authenticate_with_credentials('a@a.com', 'password')).to eq(nil)
    end
    it 'authentication wrong password' do
      expect(User.authenticate_with_credentials('test@test.com', 'asdfqwer')).to eq(nil)
    end
    it 'authentication spaces before and after email' do
      expect(User.authenticate_with_credentials('   test@test.com   ', 'password')).to eq(@test_user)
    end
    it 'authentication wrong case' do
      expect(User.authenticate_with_credentials('TeST@TeST.CoM', 'password')).to eq(@test_user)
    end
  end
end
