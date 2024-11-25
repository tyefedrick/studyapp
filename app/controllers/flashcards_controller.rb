class FlashcardsController < ApplicationController
  before_action :require_authentication
  before_action :set_flashcard_set
  before_action :set_flashcard, only: %i[edit update destroy]

  def new
    @flashcard = @flashcard_set.flashcards.build
  end

  def create
    @flashcard = @flashcard_set.flashcards.build(flashcard_params)
    if @flashcard.save
      redirect_to @flashcard_set, notice: "Flashcard was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @flashcard.update(flashcard_params)
      redirect_to @flashcard_set, notice: "Flashcard was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @flashcard.destroy
    redirect_to @flashcard_set, notice: "Flashcard was successfully deleted."
  end

  private

  def set_flashcard_set
    @flashcard_set = current_user.flashcard_sets.find(params[:flashcard_set_id])
  end

  def set_flashcard
    @flashcard = @flashcard_set.flashcards.find(params[:id])
  end

  def flashcard_params
    params.require(:flashcard).permit(:question, :answer)
  end
end
