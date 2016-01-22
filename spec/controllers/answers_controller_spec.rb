require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:user) { create(:user) }
  let(:message) { create(:answer, user: user) }

  it_behaves_like 'Voted'

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
    let(:answer) { create(:answer, user: @user) }
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
        expect { post :create, question_id: question, format: :js, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, question_id: question, format: :js, answer: attributes_for(:answer)
        expect(response).to render_template :create
      end

      it 'current user is set in answer' do
        post :create, question_id: question, format: :js, answer: attributes_for(:answer)
        expect(answer.user_id).to eq user.id
      end
    end

    context 'with invalid attributes' do
      it 'does not save the databse' do
        expect { post :create, question_id: question, format: :js, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 're-render create template' do
        post :create, question_id: question, format: :js, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :create
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
          patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
          expect(assigns(:answer)).to eq answer
        end

        it 'changes answer attributes' do
          patch :update, id: answer, question_id: question, answer: { body: 'MyText2' }, format: :js
          answer.reload
          expect(answer.body).to eq 'MyText2'
        end

        it 'render update template' do
          patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
          expect(response).to render_template :update
        end
      end

      context 'with invalid attributes' do
        before { patch :update, id: answer, question_id: question, answer: attributes_for(:invalid_answer), format: :js }

        it 'does not change attributes' do
          answer.reload
          expect(answer.body).to_not eq nil
        end

        it 'render update template' do
          expect(response).to render_template :update
        end
      end
    end

    context 'non-answer owner' do
      it 'does not change question attributes' do
        patch :update, id: another_answer, question_id: question, answer: { body: 'MyText2' }
        another_answer.reload
        expect(another_answer.body).to_not eq 'MyText2'
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
        expect { delete :destroy, id: answer, question_id: question, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'render destroy template' do
        delete :destroy, id: answer, question_id: question, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'non-answer owner' do
      it 'delete answer' do
        expect { delete :destroy, id: another_answer, question_id: question, format: :js }.to_not change(Answer, :count)
      end
    end
  end

  describe 'POST #best' do
    sign_in_user
    let(:question) { create(:question, user: @user) }
    before { post :best, id: answer, question_id: question, format: :js }

    context 'question owner' do
      it 'post best answer' do
        answer.reload
        expect(answer.best).to eq true
      end

      it 'render best answer template' do
        expect(response).to render_template :best
      end
    end

    context 'non-question owner' do
      it 'post best answer' do
        expect(answer.best).to_not eq true
      end

      it 'render best answer template' do
        expect(response).to render_template :best
      end
    end
  end
end
