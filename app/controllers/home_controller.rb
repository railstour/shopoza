class HomeController < ApplicationController
  def index
    @books = Book.limit(10)
  end
end
