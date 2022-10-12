import { LightningElement } from "lwc";
import getRandomReceipe from "@salesforce/apex/spponacularRestAPI.getRandomReceipe";
import getReceipeByIngredient from "@salesforce/apex/spponacularRestAPI.getReceipeByIngredient";

export default class RecipeSearch extends LightningElement {
  recipes = [];
  fetchRandomRecipe() {
    getRandomReceipe()
      .then((data) => {
        this.recipes =
          JSON.parse(data) && JSON.parse(data).recipes
            ? JSON.parse(data).recipes
            : [];
      })
      .catch((error) => {
        console.error(error);
      });
  }

  fetchRecipesByIngredients() {
    const ingredients = this.template.querySelector(".ingredient-input").value;
    getReceipeByIngredient({ ingredients })
      .then((data) => {
        this.recipes = JSON.parse(data);
      })
      .catch((error) => {
        console.error(error);
      });
  }
}