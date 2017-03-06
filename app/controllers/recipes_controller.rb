class RecipesController < ApplicationController

  require 'pry'

  before_action :find_recipe, only: [:show, :edit, :update, :delete]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @ingredients = Ingredient.all
  end

  def create
    @recipe = Recipe.create(name: recipe_params[:name])
    @recipe.ingredients = Ingredient.where(id: recipe_params[:ingredient_ids])
    redirect_to recipes_path
  end

  def edit
    @ingredients = Ingredient.all
  end

  def update
    if @recipe.update(recipe_params)
      @recipe.ingredients = Ingredient.where(id: recipe_params[:ingredient_ids])
      redirect_to @recipe
    else
      render :edit
    end
  end

  def delete

  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, ingredient_ids: [])
  end

end
