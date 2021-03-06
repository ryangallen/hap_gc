require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:Ryan).profile_name

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name:'Ryan', last_name: 'Allen', email: 'allenryan14@gmail.com')
    user.password = user.password_confirmation = 'password'
    user.profile_name = "PN with spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly. (No Spaces)")
  end

  test "a user should have a correctly formatted profile name" do
    user = User.new(first_name:'Ryan', last_name: 'Allen', email: 'allenryan14@gmail.com')
    user.password = user.password_confirmation = 'password'

    user.profile_name = 'ryangallen'
    assert user.valid?
  end
end
