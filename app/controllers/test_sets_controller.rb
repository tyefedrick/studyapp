class TestSetsController < ApplicationController
  before_action :set_test_set, only: [ :show, :edit, :update, :destroy, :take_test, :submit_answer, :submit_test, :reset_recent_stats, :test_results ]
  before_action :require_authentication

  def index
    @test_sets = current_user.test_sets
  end

  def show
  end

  def new
    @test_set = current_user.test_sets.new
  end

  def create
    @test_set = current_user.test_sets.build(test_set_params)

    if @test_set.save
      redirect_to @test_set, notice: "Test set was successfully created."
    else
      # Add answer options if validation fails
      @test_set.questions.each do |question|
        question.answer_options.build if question.answer_options.empty?
      end

      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @test_set.update(test_set_params)
      redirect_to @test_set, notice: "Test set was successfully updated."
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test_set.destroy
    redirect_to test_sets_url, notice: "Test set was successfully deleted."
  end

  def take_test
    # Only clear test session when explicitly starting a new test
    if params[:question].to_i == 0 && params[:new_test]
      session.delete(:test_session_id)
    end

    @current_question_index = [ params[:question].to_i, 0 ].max
    @total_questions = @test_set.questions.count

    if @current_question_index >= @total_questions
      render "test_submission"
      return
    end

    @current_question = @test_set.questions.order(:position).offset(@current_question_index).first
    session[:test_session_id] ||= SecureRandom.uuid

    @show_answer = params[:show_answer] == "1"
    @show_explanation = params[:show_explanation] == "1"
    @show_score = params[:show_score_as_you_go] == "1"

    @user_answer = UserResponse.find_by(
      user: current_user,
      question: @current_question,
      test_set_id: @test_set.id,
      test_session: session[:test_session_id]
    )

    calculate_current_score if @show_score
  end

  def submit_answer
    @question = @test_set.questions.find(params[:question_id])
    session[:test_session_id] ||= SecureRandom.uuid

    @user_response = current_user.user_responses.find_or_create_by(
      question: @question,
      test_set_id: @test_set.id,
      test_session: session[:test_session_id]
    )

    @user_response.update(selected_answer: params[:answer])

    if correct_answer?(params[:answer])
      handle_correct_answer
    else
      handle_incorrect_answer
    end

    redirect_to take_test_test_set_path(
      @test_set,
      question: params[:current_question_index],
      show_explanation: params[:show_explanation],
      show_answer: params[:show_answer],
      show_score_as_you_go: params[:show_score_as_you_go]
    )
  end

  def submit_test
    @test_responses = UserResponse.where(
      test_set_id: @test_set.id,
      test_session: session[:test_session_id]
    )

    @total_questions = @test_set.questions.count
    @correct_answers = @test_responses.count { |r| r.correct_recent_attempts > 0 }
    @current_score = (@correct_answers.to_f / @total_questions * 100).round(1)

    # Store the score in session for the test_results action
    session[:final_score] = @current_score
    session[:correct_answers] = @correct_answers
    session[:total_questions] = @total_questions

    redirect_to test_results_test_set_path(@test_set)
  end

  def test_results
    @test_responses = UserResponse.includes(question: :answer_options).where(
      test_set_id: @test_set.id,
      user_id: current_user.id,
      test_session: session[:test_session_id]
    ).order("questions.position")

    # Get the final score from session
    @current_score = session[:final_score]
    @correct_answers = session[:correct_answers]
    @total_questions = session[:total_questions]

    # Clean up session after retrieving values
    session.delete(:final_score)
    session.delete(:correct_answers)
    session.delete(:total_questions)
  end

  def reset_recent_stats
    current_user.user_responses.where(question_id: @test_set.question_ids).update_all(
      correct_recent_attempts: 0,
      incorrect_recent_attempts: 0
    )
    redirect_to @test_set, notice: "Recent statistics have been reset."
  end

  private

  def set_test_set
    @test_set = TestSet.find(params[:id])
  end

  def test_set_params
    params.require(:test_set).permit(
      :title,
      :description,
      :show_score_as_you_go,
      :show_explanation,
      :show_answer,
      questions_attributes: [
        :id,
        :content,
        :explanation,
        :question_type,
        :position,
        :_destroy,
        answer_options_attributes: [ :id, :content, :correct, :matching_id, :_destroy ]
      ]
    )
  end

  def correct_answer?(answer)
    case @question.question_type
    when "multiple_choice"
      answer == @question.answer_options.find_by(correct: true).id.to_s
    when "multiple_selection"
      Set.new(answer.map(&:to_i)) == Set.new(@question.answer_options.where(correct: true).pluck(:id))
    when "fill_in_blank"
      answer.downcase.strip == @question.answer_options.find_by(correct: true).content.downcase.strip
    when "matching"
      answer.all? { |pair| pair["target"] == @question.answer_options.find(pair["source"]).matching_id.to_s }
    end
  end

  def calculate_current_score
    @correct_answers = UserResponse.where(
      test_set_id: @test_set.id,
      test_session: session[:test_session_id],
      user_id: current_user.id
    ).where("correct_recent_attempts > 0").count

    @current_score = (@correct_answers.to_f / @total_questions * 100).round(1)
  end

  def handle_correct_answer
    @user_response.increment!(:correct_recent_attempts)
    @user_response.increment!(:correct_all_time_attempts)
    @user_response.update(correct: true)
    flash[:success] = "Correct!"
  end

  def handle_incorrect_answer
    @user_response.increment!(:incorrect_recent_attempts)
    @user_response.increment!(:incorrect_all_time_attempts)
    @user_response.update(correct: false)
    flash[:error] = "Incorrect"
  end
end
