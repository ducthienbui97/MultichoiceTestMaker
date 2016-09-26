class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question
  before_action :set_test
  before_action :authority_check

  # GET /answers/new
  def new
    @answer = @question.answers.build
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = @question.answers.create(answer_params)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @test, success: 'Answer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update

    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @test, success: 'Answer was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @test, success: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:description,:correct);
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.


  def authority_check
    if @test.User != current_user
      redirect_to @test, danger: 'You do not have the right to do this operation'
    end
  end
end
