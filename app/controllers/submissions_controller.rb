class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :set_test, except: [:index]
  before_action :set_time, only: [:edit, :update]
  before_action :authenticate_user!, except: [:new]
  helper_method :get_result
  helper_method :get_user_answer

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = current_user.submissions.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = @test.submissions.build
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    if @test.done.blank?
      redirect_to root_path, warning: "This test have not finished yet"
      return
    end
    params[:submission] = {}
    params[:submission][:user_id] = current_user.id
    @submission = @test.submissions.create(submission_params)
    respond_to do |format|
      if @submission.save
        @test.questions.each do |question|
          question.answers.each do |answer|
            answer.answers_of_questions.create({choice: false, question_id: question.id, submission_id: @submission.id})
          end
        end
        format.html { redirect_to edit_test_submission_path(@test, @submission) }
      else
        format.html { render :new }
      end
    end
  end


  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    unless @submission.evaluated.blank?
      respond_to do |format|
        format.html { redirect_to test_submission_path(@test, @submission), info: "Evaluated!" }
      end
      return
    end

    unless Time.now > @timeout + 5.seconds
      @submission.answers_of_questions.each do |user_answer|
        user_answer.update(choice: submission_params.fetch(user_answer.answer_id.to_s, "false"))
      end
    end
    if Time.now > @timeout || params[:evaluate]
      @test.questions.each do |question|
        crrct = get_result(question)
        @submission.increment!(:point, question.point) if crrct
        @submission.question_evaluations.create({question_id: question.id, value: crrct})
      end
      @submission.update(evaluated: true)
      respond_to do |format|
        format.html { redirect_to test_submission_path(@test, @submission) }
      end
    else
      respond_to do |format|
        format.html { redirect_to submissions_path, success: 'Submission was successfully saved.' }
      end
    end

  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, success: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_user_answer answer_id
    @submission.answers_of_questions.find_by(answer_id: answer_id).choice
  end

  def get_result question
    question.answers.each do |answer|
      if answer.correct != get_user_answer(answer.id)
        return false
      end
    end
    return true
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_test
    @test = Test.find_by(token: params[:test_token])
  end

  def set_time
    @timeout = @submission.created_at + @test.length.minutes
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def submission_params
    params[:submission] ||= {lazy: true}
    params.require(:submission).permit!
  end
end
