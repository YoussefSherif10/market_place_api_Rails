require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'valid user is valid' do
    user = User.new(email: 'qfJ0t@example.com', password_digest: '1234567')
    assert user.valid?
  end

  test 'invalid user is invalid' do
    user = User.new(email: 'joe', password_digest: '1234567')
    assert_not user.valid?
  end

  test 'duplicate email is invalid' do
    other_user = users(:one)
    user = User.new(email: 'youssef@gmail.com', password_digest: '1234567')
    assert_not user.valid?
  end
end
