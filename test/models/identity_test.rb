require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  context "The Identity class" do
    should "authorize from an auth object" do
      auth = Auth.new({ provider:    'identity_test',
                        uid:         '1234',
                        info:        { name:   'Test Identity', email:  'testuser@h4q.me' },
                        credentials: { token: '1234567890' } })

      @identity = Identity.authorize(auth)

      assert_equal true, @identity.valid?
    end
  end

end
