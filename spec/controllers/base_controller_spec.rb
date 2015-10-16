require "rails_helper"

describe BaseController do
  context "for an authenticated user" do
    let(:user) { create(:user) }

    before do
      signin_as(user)
    end

    it "redirects to the dashboard path" do
      get :home
      expect(response).to redirect_to(dashboard_path)
    end
  end

  context "for a signed out user" do
    describe "GET home" do
      it "sets the page title" do
        get :home
        expect(@controller.send(:page_title)).to eq("Home")
      end

      it "renders the home template" do
        expect(get :home).to render_template(:home)
      end
    end
  end
end
