/*
 * SysML v2 EXPRESSIONS cheat-sheet example (sheet 9).
 * Bob's fridge: flat sequences, # indexing from 1, . collect, .? select, -> reject/reduce/exists,
 * ?? fallback, if ? else values, and/or short-circuit, a calc def and an asserted constraint.
 * Clauses: [K] 7.4.9.2 to 7.4.9.4, Table 6 (8.2.5.8.1), 9.4.17 ControlFunctions; [S] 7.19, 7.20.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsFridge {
  private import ScalarValues::*;
  private import SequenceFunctions::*;  // size, notEmpty
  private import ControlFunctions::*;   // reject, reduce, exists
  item def Beer {
    attribute abv : Real;   // percent
    attribute temp : Real;  // deg C
    attribute cold : Boolean = temp < 5.0;
  }
  part def Fridge { item beers : Beer[0..*] ordered; }
  calc def Tab {
    in prices : Real[0..*];
    return total : Real = prices -> reduce RealFunctions::'+';
  }
  part bob {
    part fridge : Fridge;
    attribute bac : Real := 0.0;
    // sequences are flat: (3, (2, 1)) is (3, 2, 1)
    attribute countdown : Integer[3] = (3, (2, 1));
    // # counts from 1; the parentheses are required
    attribute firstAbv : Real = fridge.beers#(1).abv;
    // . over many: one abv per beer
    attribute abvs : Real[0..*] = fridge.beers.abv;
    // .? keeps the matches; -> calls a function
    ref item coldOnes : Beer[0..*] =
      fridge.beers.?{in b : Beer; b.cold};
    ref item warmOnes : Beer[0..*] =
      fridge.beers -> reject {in b : Beer; b.cold};
    attribute strongest : Real =
      abvs -> reduce RealFunctions::max;
    attribute count : Natural = size(fridge.beers);
    attribute total : Real = Tab((4.5, 5.0, 6.25));
    // if ? else is a value, not an action
    attribute driver : String =
      if bac > 0.08 ? "SuperBob" else "Bob";
    // ?? falls back when there is no value
    ref item backup : Beer[0..1] =
      fridge.beers#(7) ?? fridge.beers#(1);
    // and / or skip the right side if the left decides
    attribute safe : Boolean =
      notEmpty(fridge.beers) and fridge.beers#(1).cold;
    attribute anyWarm : Boolean =
      fridge.beers -> exists {in b : Beer; not b.cold};
    // a constraint is a Boolean: compare with ==, never =
    assert constraint designated {
      bac <= 0.08 or driver == "SuperBob"
    }
  }

  // view (not on the sheet): the fridge, the beers, the Tab calc and Bob's computed values
  view fridgeView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsFridge::**;
    filter hastype SysML::ItemDefinition | hastype SysML::PartDefinition | hastype SysML::CalculationDefinition
        | hastype SysML::PartUsage | hastype SysML::ItemUsage | hastype SysML::ReferenceUsage
        | hastype SysML::AttributeUsage | hastype SysML::AssertConstraintUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
