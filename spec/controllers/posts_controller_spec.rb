require 'rails_helper'

describe PostsController do
  shared_examples 'public access to posts' do
    before :each do
      @post = create(:post)
    end

    describe 'GET #index' do
      it "populates an array of posts" do
        get :index
        expect(assigns(:posts)).to match_array [@post]
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  shared_examples 'full access to posts' do
    describe 'GET #new' do
      it "assigns a new Post to @post" do
        get :new
        expect(assigns(:post)).to be_a_new(Contact)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it "assigns the requested Post to @post" do
        post = create(:post)
        get :edit, id: post
        expect(assigns(:post)).to eq post
      end

      it "renders the :edit template" do
        post = create(:post)
        get :edit, id: post
        expect(response).to render_template :edit
      end
    end

    describe "POST #create" do
      before :each do
        @user = attributes_for(:user)
      end

      context "with valid attributes" do
        it "saves the new post in the database" do
          expect{
            post :create, post: attributes_for(:post, user_attributes: @user)
          }.to change(Post, :count).by(1)
        end

        it "redirects to posts#index" do
          post :create, post: attributes_for(:post,
            user_attributes: @user)
          expect(response)to redirect_to posts_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new post in the database" do
          expect{
            post :create,
              post: attributes_for(:invalid_post)
          }.not_to change(Contact, :count)
        end

        it "re-renders the :new template" do
          post :create,
            post: attributes_for(:invalid_post)
          expect(response).to render_template :new
        end
      end

      describe 'PATCH #updates' do
        before :each do
          @post = create(:post, title: "Some title", url: "www.example.com", description: "Some description here")
        end

        context 'valid attributes' do
          it 'locates the requested @post' do
            patch :update, id: @post, post: attributes_for(:post)
            expect(assigns(:post))to eq(@post)
          end

          it 'changes @post attributes' do
            patch :update, id: @post,
              post: attributes_for(:post,
                title: 'Another title', url: 'www.anotherexample.com', description: 'Another description here'
                )
            @post.reload
            expect(@post.title).to eq('Another title')
            expect(@post.url).to eq('www.anotherexample.com')
            expect(@post.description).to eq('Another description here')
          end

          it 'redirects to the updated post' do
            patch :update, id: @post, post: attributes_for(:post)
            expect(response).to redirect_to @post
          end
        end

        context 'with invalid attributes' do
          it "does not change the contact's attributes" do
            patch :update, id: @post,
              post: attributes_for(:post,
                title: nil,
                url: "www.example.com",
                description: "another description"
                )
            @post.reload
            expect(@post.title)
          end

          it "re-renders the edit template" do
            patch :update, id: @post,
              post: attributes_for(:invalid_post)
            expect(response).to render_template :edit
          end
        end
      end
    end
  end

end
