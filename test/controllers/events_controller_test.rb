require "test_helper"

class EventsControllerTest < ActionController::TestCase
  context "An unauthenticated user" do
    should "be able to view an event" do
      event = create(:event)

      get :show, id: event.to_param

      assert_response :success
      assert_template :show
      assert assigns(:event).present?
    end

    should "not have a new event page" do
      get :new
      assert_redirected_to sign_in_path
    end
  end

  context "An authenticated user" do
    setup do
      @user = create(:user)
      signin_as(@user)
    end

    should "have a new event page" do
      get :new

      assert_response :success
      assert_template :new
      assert assigns(:event).new_record?
    end

    should "be able to create a new valid event" do
      assert_equal @user, @controller.send(:current_user)

      assert_difference "Event.count", 1 do
        post :create, event: attributes_for(:event)
      end

      assert_redirected_to event_path(assigns(:event))
    end

    should "have an edit event page for their own events" do
      event = create(:event, creator: @user)
      get :edit, id: event.to_param

      assert_response :success
      assert_template :edit
      assert_equal event, assigns(:event)
    end

    should "not have an edit event page for other events" do
      event = create(:event, created_by: 999)
      get :edit, id: event.to_param

      assert_redirected_to root_path
    end

    should "be able to update their own events" do
      event = create(:event, creator: @user)
      patch :update, id: event.to_param, event: { description: "hi" }

      assert_equal "hi", event.reload.description
    end

    should "not update other events" do
      event = create(:event, created_by: 999, description: "no")
      patch :update, id: event.to_param, event: { description: "hi" }

      assert_equal "no", event.reload.description
      assert_redirected_to root_path
    end
  end
end

