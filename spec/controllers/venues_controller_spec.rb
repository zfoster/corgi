require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe VenuesController do

  # This should return the minimal set of attributes required to create a valid
  # Venue. As you add validations to Venue, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # VenuesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all venues as @venues" do
      venue = Venue.create! valid_attributes
      get :index, {}, valid_session
      assigns(:venues).should eq([venue])
    end
  end

  describe "GET show" do
    it "assigns the requested venue as @venue" do
      venue = Venue.create! valid_attributes
      get :show, {:id => venue.to_param}, valid_session
      assigns(:venue).should eq(venue)
    end
  end

  describe "GET new" do
    it "assigns a new venue as @venue" do
      get :new, {}, valid_session
      assigns(:venue).should be_a_new(Venue)
    end
  end

  describe "GET edit" do
    it "assigns the requested venue as @venue" do
      venue = Venue.create! valid_attributes
      get :edit, {:id => venue.to_param}, valid_session
      assigns(:venue).should eq(venue)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Venue" do
        expect {
          post :create, {:venue => valid_attributes}, valid_session
        }.to change(Venue, :count).by(1)
      end

      it "assigns a newly created venue as @venue" do
        post :create, {:venue => valid_attributes}, valid_session
        assigns(:venue).should be_a(Venue)
        assigns(:venue).should be_persisted
      end

      it "redirects to the created venue" do
        post :create, {:venue => valid_attributes}, valid_session
        response.should redirect_to(Venue.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved venue as @venue" do
        # Trigger the behavior that occurs when invalid params are submitted
        Venue.any_instance.stub(:save).and_return(false)
        post :create, {:venue => { "name" => "invalid value" }}, valid_session
        assigns(:venue).should be_a_new(Venue)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Venue.any_instance.stub(:save).and_return(false)
        post :create, {:venue => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested venue" do
        venue = Venue.create! valid_attributes
        # Assuming there are no other venues in the database, this
        # specifies that the Venue created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Venue.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => venue.to_param, :venue => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested venue as @venue" do
        venue = Venue.create! valid_attributes
        put :update, {:id => venue.to_param, :venue => valid_attributes}, valid_session
        assigns(:venue).should eq(venue)
      end

      it "redirects to the venue" do
        venue = Venue.create! valid_attributes
        put :update, {:id => venue.to_param, :venue => valid_attributes}, valid_session
        response.should redirect_to(venue)
      end
    end

    describe "with invalid params" do
      it "assigns the venue as @venue" do
        venue = Venue.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Venue.any_instance.stub(:save).and_return(false)
        put :update, {:id => venue.to_param, :venue => { "name" => "invalid value" }}, valid_session
        assigns(:venue).should eq(venue)
      end

      it "re-renders the 'edit' template" do
        venue = Venue.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Venue.any_instance.stub(:save).and_return(false)
        put :update, {:id => venue.to_param, :venue => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested venue" do
      venue = Venue.create! valid_attributes
      expect {
        delete :destroy, {:id => venue.to_param}, valid_session
      }.to change(Venue, :count).by(-1)
    end

    it "redirects to the venues list" do
      venue = Venue.create! valid_attributes
      delete :destroy, {:id => venue.to_param}, valid_session
      response.should redirect_to(venues_url)
    end
  end

end