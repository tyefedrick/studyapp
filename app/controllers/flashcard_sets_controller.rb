class FlashcardSetsController < ApplicationController
  before_action :require_authentication
  before_action :set_flashcard_set, only: %i[show edit update destroy]

  def index
    @flashcard_sets = current_user.flashcard_sets
  end

  def new
    @flashcard_set = FlashcardSet.new
  end

  def create
    @flashcard_set = current_user.flashcard_sets.build(flashcard_set_params)

    if @flashcard_set.save
      redirect_to @flashcard_set, notice: "Flashcard set was successfully created."
    else
      render :new
    end
  end

  def show
    @flashcard_set = current_user.flashcard_sets.find(params[:id])
  end

  def edit
    @flashcard_set.flashcards.build # Prepare a new flashcard form in case a user wants to add cards.
  end

  def update
    if @flashcard_set.update(flashcard_set_params)
      redirect_to @flashcard_set, notice: "Flashcard set and flashcards were successfully updated."
    else
      render :edit, alert: "There was an error updating the flashcard set."
    end
  end

  def destroy
    @flashcard_set.destroy
    redirect_to flashcard_sets_path, notice: "Flashcard set was successfully deleted."
  end

  private

  def set_flashcard_set
    @flashcard_set = current_user.flashcard_sets.find(params[:id])
  end

  def flashcard_set_params
    params.require(:flashcard_set).permit(
      :title,
      :description,
      :visibility,
      flashcards_attributes: %i[id question answer _destroy]
    )
  end
end
