require 'rails_helper'

RSpec.describe "moviesコントローラーのテスト", type: :request do
  describe 'ログイン済み' do
    before do
      @user = create(:user)
      sign_in @user
    end
    context "動画一覧ページが正しく表示される" do
      before do
        get movies_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'タイトルが正しく表示されていること' do
        expect(response.body).to eq movie.title
      end
    end
  end
end