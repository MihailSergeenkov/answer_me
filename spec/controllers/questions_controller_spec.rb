require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:message) { create(:question, user: user) }

  it_behaves_like 'Voted'

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns the new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    let(:question) { create(:question, user: @user) }
    before { get :edit, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it 'current user is set in question' do
        post :create, question: attributes_for(:question)
        expect(question.user_id).to eq user.id
      end

      it 'publication object' do
        expect(PrivatePub).to receive(:publish_to).with('/questions', anything)
        post :create, question: attributes_for(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the database' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let!(:another_question) { create(:question, user: user) }
    sign_in_user
    let!(:question) { create(:question, user: @user) }

    context 'question owner' do
      context 'valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, id: question, question: attributes_for(:question), format: :js
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          patch :update, id: question, question: { title: 'new title', body: 'new body' }, format: :js
          question.reload
          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'redirects to the updated question' do
          patch :update, id: question, question: attributes_for(:question), format: :js
          expect(response).to render_template :update
        end
      end

      context 'invalid attributes' do
        before { patch :update, id: question, question: { title: 'new title', body: nil }, format: :js }

        it 'does not change question attributes' do
          question.reload
          expect(question.title).to_not eq 'new title'
          expect(question.body).to_not eq nil
        end

        it 're-render edit view' do
          expect(response).to render_template :update
        end
      end
    end

    context 'non-question owner' do
      it 'does not change question attributes' do
        patch :update, id: another_question, question: { title: 'new title', body: 'new body' }, format: :js
        another_question.reload
        expect(another_question.title).to_not eq 'new title'
        expect(another_question.body).to_not eq 'new body'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:another_question) { create(:question, user: user) }
    sign_in_user
    let!(:question) { create(:question, user: @user) }

    before { question }

    context 'question owner' do
      it 'delete question' do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'non-question owner' do
      it 'delete question' do
        expect { delete :destroy, id: another_question }.to_not change(Question, :count)
      end
    end
  end
end
