require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2, question: question) }

    before { get :index, question_id: question }

    it 'populates an array of all answers belong to question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new, question_id: question }

    it 'assigns a new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, id: answer, question_id: question }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new answer in the databse' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'redirects to the question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the databse' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 're-render new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let!(:question) { create(:question, user: user) }
    let!(:another_answer) { create(:answer, question: question, user: user) }
    sign_in_user
    let!(:answer) { create(:answer, question: question, user: @user) }

    context 'answer owner' do
      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
          expect(assigns(:answer)).to eq answer
        end

        it 'changes answer attributes' do
          patch :update, id: answer, question_id: question, answer: { body: 'MyText2' }
          answer.reload
          expect(answer.body).to eq 'MyText2'
        end

        it 'redirects to the question show view' do
          patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        before { patch :update, id: answer, question_id: question, answer: attributes_for(:invalid_answer) }

        it 'does not change attributes' do
          answer.reload
          expect(answer.body).to eq 'MyText'
        end

        it 're-render edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'non-answer owner' do
      it 'does not change question attributes' do
        patch :update, id: another_answer, question_id: question, answer: { body: 'MyText2' }
        another_answer.reload
        expect(another_answer.body).to eq another_answer.body
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: user) }
    let!(:another_answer) { create(:answer, question: question, user: user) }
    sign_in_user
    let!(:answer) { create(:answer, question: question, user: @user) }

    context 'answer owner' do
      it 'delete answer' do
        expect { delete :destroy, id: answer, question_id: question }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question index view' do
        delete :destroy, id: answer, question_id: question
        expect(response).to redirect_to question
      end
    end

    context 'non-answer owner' do
      it 'delete answer' do
        expect { delete :destroy, id: another_answer, question_id: question }.to_not change(Answer, :count)
      end
    end
  end
end
