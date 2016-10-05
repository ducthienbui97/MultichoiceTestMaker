class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy, :done, :flip]
  before_action :authenticate_user!, except: [:index]
  before_action :authority_check, only: [:show, :edit, :update, :destroy, :done, :flip]
  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.where(done: true).where(public: true)
  end

  def flip
    if @test.update(public: @test.public.blank?)
      respond_to do |format|
        format.js
      end
    end
  end

  #GET /tests/all
  def all
  end

  # PATCH /tests/1/done
  def done
    unless @test.questions.size > 0
      redirect_to @test, danger: 'The test has to have at least one question'
      @test.update(done: false)
      return
    end
    @test.questions.each do |question|
      has_correct_answer = false
      question.answers.each do |answer|
        has_correct_answer ||= answer.correct
      end
      if !has_correct_answer
        redirect_to @test, danger: 'Each question has to have at least one correct answer'
        @test.update(done: false)
        return
      end
    end
    @test.update(done: true)
    redirect_to all_tests_path, success: "Done!"
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, success: 'Test was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to @test, success: 'Test was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to all_tests_path, success: 'Test was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_test
    @test = Test.find_by(token: params[:token])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def test_params
    params[:test][:user_id] = current_user[:id]
    params.require(:test).permit(:user_id, :title, :description, :length)
  end

  def authority_check
    if @test.user != current_user
      redirect_to root_path, danger: 'You do not have the right to modify this test'
    end
  end
end
