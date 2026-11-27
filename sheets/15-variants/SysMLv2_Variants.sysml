/*
 * SysML v2 VARIANTS AND VARIATIONS cheat-sheet example (sheet 15).
 * Bob's pizza family: a variation def (toppings), a variation usage (crust), an optional beer, a selection
 * constraint, and two configurations (Bob: thin + anchovy; SuperBob: deep dish + pineapple).
 * Clauses: [S] 7.6.1 Variability, 7.6.7, 8.3.6 (variation constraints), Annex A.12.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsPizzaFamily {
  part def Pizza;
  part def Crust;
  part def Thin :> Crust;
  part def DeepDish :> Crust;
  part def Topping;
  part def Pineapple :> Topping;
  part def Anchovy :> Topping;
  item def Beer;
  variation part def ToppingChoices :> Topping {
    variant part pineapple : Pineapple;
    variant part anchovy : Anchovy;
  }
  abstract part pizzaFamily : Pizza {   // superset model
    variation part crust : Crust {
      variant part thin : Thin;
      variant part deepDish : DeepDish;
    }
    part topping : ToppingChoices;      // one of its variants
    item beer : Beer[0..1];             // optional, not a variation
    assert constraint whoOrdered {
      (crust == crust::thin and
         topping == ToppingChoices::anchovy) xor
      (crust == crust::deepDish and
         topping == ToppingChoices::pineapple)
    }
  }
  part bobsPizza :> pizzaFamily {       // a configuration
    part :>> crust = crust::thin;
    part :>> topping = ToppingChoices::anchovy;
  }
  part superBobsPizza :> pizzaFamily {
    part :>> crust = crust::deepDish;
    part :>> topping = ToppingChoices::pineapple;
  }

  // view (not on the sheet): the superset pizza family, its variations and variants, and the two configurations
  view pizzaFamilyView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsPizzaFamily::**;
    filter hastype SysML::PartDefinition | hastype SysML::ItemDefinition | hastype SysML::PartUsage
        | hastype SysML::ItemUsage | hastype SysML::AssertConstraintUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
