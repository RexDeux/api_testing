# spec/requests/books_spec.rb

require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  # Initialize test data
  let!(:category) { FactoryBot.create(:category) }
  let!(:books) { FactoryBot.create_list(:book, 10, category: category) }
  let(:book_id) { books.first.id }

  # Test suite for GET /books
  describe 'GET /books/all' do
    # Make HTTP request before each example
    before { get '/books/all' }

    it 'returns all books' do
      # Parse JSON response body
      json_response = JSON.parse(response.body)

      # Expect response status to be 200 (OK)
      expect(response).to have_http_status(200)

      # Expect the number of books returned to be equal to the number of created books
      expect(json_response.size).to eq(books.size)
    end
  end

  # Test suite for GET /books/:id
  describe 'GET /books/:id' do
    before { get "/books/#{book_id}" }

    context 'when the book exists' do
      it 'returns the book' do
        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(json_response['id']).to eq(book_id)
      end
    end

    context "when the book does not exist" do
      let(:non_existent_id) { Book.maximum(:id).to_i + 1 }

      before { get "/books/#{non_existent_id}" }

      it "returns a not found error" do
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq("Book not found")
      end
    end
  end
end
