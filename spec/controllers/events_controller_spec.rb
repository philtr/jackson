require "rails_helper"

describe EventsController do
  context "An unauthenticated user" do
    it "views an event" do
      event = create(:event)

      get :show, id: event.to_param

      assert_response :success
      assert_template :show
      assert assigns(:event).present?
    end

    it "does not have a new event page" do
      get :new
      assert_redirected_to sign_in_path
    end
  end

  context "An authenticated user" do
    before do
      @user = create(:user)
      signin_as(@user)
    end

    it "has a new event page" do
      get :new

      assert_response :success
      assert_template :new
      assert assigns(:event).new_record?
    end

    it "creates a new valid event" do
      assert_equal @user, @controller.send(:current_user)

      expect do
        post :create, event: attributes_for(:event)
      end.to change(Event, :count).by(1)

      assert_redirected_to event_path(assigns(:event))
    end

    it "edits event page for their own events" do
      event = create(:event, creator: @user)
      get :edit, id: event.to_param

      assert_response :success
      assert_template :edit
      assert_equal event, assigns(:event)
    end

    it "does not have an edit event page for other events" do
      event = create(:event, created_by: 999)
      get :edit, id: event.to_param

      assert_redirected_to root_path
    end

    it "updates their own events" do
      event = create(:event, creator: @user)
      patch :update, id: event.to_param, event: { description: "hi" }

      assert_equal "hi", event.reload.description
    end

    it "does not update other events" do
      event = create(:event, created_by: 999, description: "no")
      patch :update, id: event.to_param, event: { description: "hi" }

      assert_equal "no", event.reload.description
      assert_redirected_to root_path
    end
  end
end

