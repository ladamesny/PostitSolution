require 'rails_helper'

describe CommentsController do
  shared_examples 'public access to comments' do
    before :each do
      @post = create(:post)
      @comment = create(:comment, post: @post)
    end

    describe 'GET post#show' do
      it "populates an array of comments" do
        get @post
        expect(assigns(@post.comments)).to match_array [@comment]
      end
    end
  end

  shared_examples 'full access to comments' do
    describe 'GET #new' do
      it "assigns a new comment to @comment" do
        get :new
        expect(assigns(:comment)).to be_a_new(comment)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it "assigns the requested comment to @comment" do
        comment = create(:comment)
        get :edit, id: comment
        expect(assigns(:comment)).to eq comment
      end

      it "renders the :edit template" do
        comment = create(:comment)
        get :edit, id: comment
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do

      context "with valid attributes" do
        it "saves the new comment in the database" do
          expect{
            post :create, comment: attributes_for(:comment)
          }.to change(comment, :count).by(1)
        end

        it "redirects to posts#show" do
          post :create, comment: attributes_for(:comment)
          expect(response).to redirect_to posts_path(comment.post)
        end
      end

      context "with invalid attributes" do
        it "does not save the new comment in the database" do
          expect{
            post :create,
              comment: attributes_for(:invalid_comment)
          }.not_to change(Comment, :count)
        end

        it "re-renders the :new template" do
          post :create,
            comment: attributes_for(:invalid_comment)
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'administrator access' do
    before :each do
      set_user_session create(:admin_user)
    end

    it_behaves_like 'public access to comments'
    it_behaves_like 'full access to comments'
  end

  describe 'guest access' do
    it_behaves_like 'public access to comments'
  end
end
