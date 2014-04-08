class HomeController < ApplicationController
  def index
    @test_model = TestModel.new
  end
end
