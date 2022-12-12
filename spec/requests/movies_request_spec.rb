require 'rails_helper'

RSpec.describe "moviesコントローラーのテスト", type: :request do
  describe 'create' do
    subject { post movies_path, params: { title: "test", user: user } }
    let(:user) { create :user }

    context '未ログイン時' do
      it 'movieが作成されないこと' do
        expect{subject}.to change(Movie, :count).by(0)
      end
    end
    
    context "ログイン済みの時" do
      before do
        sign_in user
      end

      it 'リクエストは201 OKとなること' do
        subject
        expect(response.status).to eq 201
      end
  
      it '動画が１件登録されること' do
        expect{subject}.to change(Movie, :count).from(0).to(1)
      end
    end
  end
end