require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the schools instance variable' do
      get :index
      expect(assigns(:schools)).to eq([])
    end

    it 'has schools in the instance variable' do
      School.create(name: 'test', type: false)
      get :index
      expect(assigns(:schools).length).to eq(1)
      expect(assigns(:schools).first.name).to eq('test')
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      school = School.create(name: 'test', type: false)
      get :show, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      school = School.create(name: 'test', type: false)
      get :show, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it "renders the show template" do
      school = School.create(name: 'test', type: false)
      get :show, id: school.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      get :new
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school).class).to eq(School)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      school = School.create(name: 'test', type: false)
      get :edit, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      school = School.create(name: 'test', type: false)
      get :edit, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it "renders the edit template" do
      school = School.create(name: 'test', type: false)
      get :edit, id: school.id
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    it "successfully creates a school" do
      school_params = {school: {name: 'test',type: false} }

      post :create, school_params
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(school_params[:school][:name])
    end

    it "renders the new template on unsuccessful create" do
      school_params = {school: {name: '',type: false} }
      post :create, school_params
      expect(School.count).to eq(0)
      expect(response).to render_template(:new)
    end

    it "redirects to the school path on success" do
      school_params = {school: {name: 'test', type: false} }
      post :create, school_params
      expect(response).to redirect_to school_path(School.first)
    end
  end

  describe "PUT #update" do
    it "successfully updates a school" do
      school = School.create(name: 'test', type: false)
      school_params = {name: 'updated by a test'}
      put :update, {id: school.id, school: school_params}
      # reload goes to the database and refreshes the values
      # of the variable
      expect(school.reload.name).to eq('updated by a test')
    end

    it "redirects to the school path on success" do
      school = School.create(name: 'updated by a test', type: false)
      school_params = {school: {name: '',type: false} }
      put :update, school_params
      expect(response).to redirect_to school_path(School.first)
    end

    it "renders the edit template on fail" do
      school = School.create(name: 'updated by a test', type: false)
      school_params = {school: {name: '',type: false} }
      put :update, school_params
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "sets the school instance variable" do
     school = School.create(name: 'name', type: false)
     delete :destroy, id: school.id
     expect(assigns(:school)).to eq(school)
   end

   it 'destroys the school sucessfully' do
     school = School.create(name: 'name', type: false)
     expect(School.count).to eq(1)
     delete :destroy, id: school.id
     expect(School.count).to eq(0)
   end

   it 'sets the flash success message' do
     school = School.create(name: 'name', type: false)
     delete :destroy, id: school.id
     expect(flash[:success]).to eq('School has been deleted!')
   end

   it 'redirects to the index path after destroy' do
     school = School.create(name: 'name', type: false)
     delete :destroy, id: false.id
     expect(response).to redirect_to(schools_path)
   end
  end
end
