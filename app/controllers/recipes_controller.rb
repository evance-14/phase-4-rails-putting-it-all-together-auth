class RecipesController < ApplicationController
  before_action :authorize
  def index
      user = User.find_by(id: session[:user_id])
      recipes = Recipe.all
      render json: recipes, status: :created, each_serializer: RecipeSerializer
  end
  def create
      user = User.find_by(id: session[:user_id])
      if user
          recipe = Recipe.new(recipe_params.merge({user_id: user.id}))
          if recipe.save
              render json: recipe, status: :created
          else
              render json: { errors: recipe.errors.full_messages}, status: :unprocessable_entity
          end
      end
  end
  private
  def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
  end
  def authorize
      return render json: { errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
  end
end