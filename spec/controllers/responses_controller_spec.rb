require "rails_helper"

describe ResponsesController do
  let(:event) { create(:event) }

  context "for a signed out user" do
    describe "GET index" do
      it "redirects to the sign in path" do
        get :index, event_id: event.to_param
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "POST create" do
      it "redirects to the sign in path" do
        post :create, event_id: event.to_param
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "PATCH update" do
      it "redirects to the sign in path" do
        patch :update, event_id: event.to_param, id: 1
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects to the sign in path" do
        delete :destroy, event_id: event.to_param, id: 1
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  context "for a signed in user" do
    let(:user) { create(:user) }
    before { signin_as(user) }

    describe "GET index" do
      it "redirects to the event page" do
        get :index, event_id: event.to_param
        expect(response).to redirect_to(event_path(event))
      end
    end

    describe "POST create" do
      it "creates a new response for the event" do
        expect do
          post :create,
               event_id: event.to_param,
               response: attributes_for(:response)
        end.to change { event.reload.responses.count }.by(1)
      end

      it "redirects to the event page" do
        post :create,
             event_id: event.to_param,
             response: attributes_for(:response)
        expect(response).to redirect_to(event_path(event))
      end

      context "when the user is already going to the event" do
        it "doesn't create another response" do
          create(:response, event: event, user: user)

          expect do
            post :create,
                 event_id: event.to_param,
                 response: attributes_for(:response, user: user, event: event)
          end.not_to change { event.reload.responses.count }
        end
      end
    end

    describe "PATCH update" do
      let(:event_response) { create(:response, event: event, user: user) }

      it "updates the user's response" do
        expect do
          patch :update,
                event_id: event.to_param,
                id: event_response.to_param,
                response: {
                  additional_guests: event_response.additional_guests + 1
                }
        end.to change { event_response.reload.additional_guests }.by(1)
      end

      it "redirects to the event path" do
        patch :update,
              event_id: event.to_param,
              id: event_response.to_param,
              response: { additional_guests: 100 }
        expect(response).to redirect_to(event_path(event))
      end
    end

    describe "DELETE destroy" do
      let!(:event_response) { create(:response, event: event, user: user) }

      it "destroys the user's response" do
        expect do
          delete :destroy, event_id: event.to_param, id: event_response.to_param
        end.to change { event.reload.responses.count }.by(-1)
      end

      it "redirects to the event path" do
        delete :destroy, event_id: event.to_param, id: event_response.to_param
        expect(response).to redirect_to(event_path(event))
      end
    end
  end
end
