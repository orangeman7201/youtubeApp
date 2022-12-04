require 'rails_helper'

RSpec.describe 'Movie', type: :model do
  describe 'today' do
    before do
      create :movie, user: user, created_at: Date.today
      create :movie, user: user, created_at: Date.today - 1.day
      create :movie, user: user, created_at: Date.today + 1.day
    end

    let(:user) { create :user }

    it '今日作成されたものだけ取得できること' do
      expect(Movie.today.count).to eq 1
    end
  end

  describe 'this_week' do
    before do
      create :movie, user: user, created_at: Date.today
      create :movie, user: user, created_at: Date.today - 7.day
      create :movie, user: user, created_at: Date.today + 1.day
    end

    let(:user) { create :user }

    it '先週～今日までに作成されたものだけ取得できること' do
      expect(Movie.this_week.count).to eq 2
    end
  end
end