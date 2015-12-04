require "rails_helper"

describe User do
  let(:user) { User.new }

  it 'capitalizes name' do
    user.name = 'adam pahlevi baihaqi'
    user.email = 'adam@example.com'
    user.password = 'Password123'
    user.save!

    user.reload
    expect(user.name).to eq('Adam Pahlevi Baihaqi')
  end

  it 'has password' do
    user.name = 'adam pahlevi baihaqi'
    user.email = 'adam@example.com'
    user.save

    expect(user.errors).to include(:password)
  end

  it 'has name' do
    user.name = nil
    user.password = 'Password123'
    user.save

    expect(user.errors).to include(:name)
  end
end