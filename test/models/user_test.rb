require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '     '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'emailに含まれる文字は大文字と小文字区別しないことを確認するテスト' do
    @user.save
    uppercase_email_user = User.new(name: 'Example User', email: 'User@example.com', password: 'password', password_confirmation: 'password')
    assert_not uppercase_email_user.valid?
  end

  test 'email should be unique' do
    same_email_user = @user.dup
    @user.save
    assert_not same_email_user.valid?
  end

  test 'passwordが空白でないことを確認するテスト' do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test 'passwordが5文字以上であることを確認するテスト' do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
