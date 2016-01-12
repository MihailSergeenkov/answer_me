require 'rails_helper'

describe 'Answers for questions API' do
  let(:question) { create(:question) }
  let(:access_token) { create(:access_token) }

  describe 'GET /index' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let!(:answers) { create_list(:answer, 2, question: question) }
      let(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token, question_id: question }

      %w(id body created_at updated_at question_id user_id best).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/1/#{attr}")
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers", { format: :json }.merge(options)
    end
  end

  describe 'GET /show' do
    let(:answer) { create(:answer, question: question) }
    let!(:comment) { create(:answer_comment, commentable: answer) }
    let!(:attachment) { create(:answer_attachment, attachable: answer) }

    it_behaves_like 'API Authenticable'

    context 'authorized' do
      before { get "/api/v1/questions/#{question.id}/answers/#{answer.id}", format: :json, access_token: access_token.token, question_id: question }

      %w(id body created_at updated_at question_id user_id best).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      context 'comments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(1).at_path('answer/comments')
        end

        %w(id body commentable_id commentable_type user_id created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("answer/comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(1).at_path('answer/attachments')
        end

        it "contains url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path('answer/attachments/0/url')
        end
      end
    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}/answers/#{answer.id}", { format: :json }.merge(options)
    end
  end

  describe 'POST /create' do
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      it 'saves the new answer for question in the database' do
        expect { post "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end
    end

    def do_request(options = {})
      post "/api/v1/questions/#{question.id}/answers", { format: :json, question_id: question, answer: attributes_for(:answer) }.merge(options)
    end
  end
end
