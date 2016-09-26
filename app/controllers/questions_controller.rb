class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_test
  before_action :authority_check


  # GET /questions/new
  def new
    @question = @test.questions.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = @test.questions.create(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @test, success: 'Question was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html {redirect_to @test}
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html{redirect_to @test, success: "Question successful destroy"}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params[:question][:point] = 1
    params.require(:question).permit(:point, :question_text)
  end
  def authority_check
    if @test.User != current_user
      redirect_to @test, danger: 'You do not have the right to do this operation'
    end
  end
end
