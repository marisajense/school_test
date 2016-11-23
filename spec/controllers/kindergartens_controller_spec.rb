require 'rails_helper'

RSpec.describe KindergartensController, type: :controller do
  let(:kindergarten) { FactoryGirl.create(:kindergarten)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the kindergantens instance variable' do
      get :index
      expect(assigns(:kindergartens)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has kindergartens in the kindergartens instance variable' do
      3.times { |index| Kindergarten.create(name: "name_#{index}", students: 10, open: true) }
      get :index
      expect(assigns(:kindergartens).length).to eq(3)
      expect(assigns(:kindergartens).last.name).to eq('name_2')
    end
  end
  # ---------NEW------------
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "sets the new instance variable" do
      get :new
      expect(assigns(:kindergarten)).to_not eq(nil)
      expect(assigns(:kindergarten).id).to eq(nil)
    end
  end
  # -----------CREATE--------------
  describe "POST #create" do
    before(:all) do
      @kindergarten_params = { kindergarten: { name: 'Test', students: 10, open: true}}
    end
    it "sets the kindergarten instance variable" do
      post :create, @kindergarten_params
      expect(assigns(:kindergarten)).to_not eq(nil)
      expect(assigns(:kindergarten).name).to eq(@kindergarten_params[:kindergarten][:name])
    end

    it "creates a new kindergarten" do
      expect(Kindergarten.count).to eq(0)
      post :create, @kindergarten_params
      expect(Kindergarten.count).to eq(1)
      expect(Kindergarten.first.name).to eq(@kindergarten_params[:kindergarten][:name])
    end

    it "sets a flash message on success" do
      post :create, @kindergarten_params
      expect(flash[:success]).to eq('Kindergarten Created!')
    end

    it "sets a flash message on error" do
      post :create, { id: kindergarten.id, kindergarten: { name: 'school', students: 10, open: true } }
      expect(flash[:error]).to eq('Fix errors and try again')
    end
  end
  # -------------EDIT--------------
  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: kindergarten.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, id: kindergarten.id
      expect(response). to render_template(:edit)
    end

    it "sets kindergarten instance variable" do
      get :edit, id: kindergarten.id
      expect(assigns(:kindergarten).id).to eq(kindergarten.id)
    end
  end
  # --------------UPDATE-----------------
  describe 'PUT #update' do
    it "sets the kindergarten instance variable" do
      put :update, { id: kindergarten.id, kindergarten: { name: 'New Name'}}
      expect(assigns(:kindergarten).id).to eq(kindergarten.id)
    end

    it "updates the kindergarten" do
      put :update, { id: kindergarten.id, kindergarten: { name: 'New Name'}}
      expect(kindergarten.reload.name).to eq('New Name')
    end

    it "sets a flash message on success" do
      put :update, { id: kindergarten.id, kindergarten: { name: 'New Name'}}
      expect(flash[:success]).to eq('kindergarten Updated!')
    end

    it "redirect to show on success" do
      put :update, { id: kindergarten.id, kindergarten: { name: 'New Name'}}
      expect(response).to redirect_to(kindergarten_path(kindergarten.id))
    end
    # ---------Update Failures------------------
    describe 'update failures' do
      it "renders edit on fail" do
        put :update, { id: kindergarten.id, kindergarten: { name: nil, students: 11, open: true } } #Force fail
        expect(response).to render_template(:edit)
      end
      it "sets a flash message on error" do
        put :update, { id: kindergarten.id, kindergarten: { name: nil, students: 10, open: true } }
        expect(flash[:error]).to eq('kindergarten failed to update!')
      end
    end
  end
  #--------------- SHOW--------------------
  describe "GET #show" do
    it "returns http success" do
      get :show, id: kindergarten.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, id: kindergarten.id
      expect(response).to render_template(:show)
    end

    it "set the kindergarten instance variable" do
      get :show, id: kindergarten.id
      expect(assigns(:kindergarten).name).to eq(kindergarten.name)
    end
  end
  # --------------DESTROY-------------------
  describe "DELETE #destroy" do
    it "sets the kindergarten instance variable" do
      delete :destroy, id: kindergarten.id
      expect(assigns(:kindergarten)).to eq(kindergarten)
    end

    it "destroys the kindergarten" do
      kindergarten # (this is the let kindergarten at the top)
      expect(Kindergarten.count).to eq(1)
      delete :destroy, id: kindergarten.id
      expect(Kindergarten.count).to eq(0)
    end

    it "sets the flash message" do
      delete :destroy, id: kindergarten.id
      expect(flash[:success]).to eq('kindergarten Deleted!')
    end
    
    it "redirect to index path after destroy" do
      delete :destroy, id: kindergarten.id
      expect(response).to redirect_to(kindergartens_path)
    end
  end
end
