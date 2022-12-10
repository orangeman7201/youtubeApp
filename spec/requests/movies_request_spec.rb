require 'rails_helper'

RSpec.describe "moviesコントローラーのテスト", type: :request do
  describe 'index' do
    let(:user) { create :user }
    let!(:movies) { create_list(:movie, 11, user: user) }
    
    context "ログイン済みの時" do
      before do
        sign_in user
        get movies_path
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
  
      it '10件動画が返却されること' do
        expect(JSON.parse(response.body)["movies"].length).to eq 10
      end
    end
  end

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