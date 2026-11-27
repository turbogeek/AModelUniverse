/*
 * SysML v2 ATTRIBUTES ON THEIR OWN cheat-sheet example (sheet 19).
 * The code is the textual notation card on the sheet, followed by a view a tool can render.
 * Bob's beer belly: attribute defs (Percent, BeerSpec), a standalone attribute usage (buzz), typing by a
 * library def (VolumeValue) vs subsetting a library usage (ISQ::mass), a roll-up, and kg vs lb values.
 * Clauses: [S] 7.7 Attributes, 7.6.3 Usages, 7.20 Constraints, 9.8 Quantities and Units.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsBeerBelly {
  private import ScalarValues::*;
  private import ISQ::*;
  private import SI::*;
  private import USCustomaryUnits::lb;
  private import QuantityCalculations::sum;
  attribute def Percent :> Real;      // a kind of value
  attribute def BeerSpec {            // a value with parts
    attribute abv : Percent;          // alcohol by volume
    attribute ibu : Real;             // bitterness
    constraint { abv >= 0 and abv <= 100 }
  }
  attribute buzz : Percent [*] nonunique; // standalone usage
  item def Beer {
    attribute spec : BeerSpec;        // typed by a def
    attribute volume : VolumeValue;
    attribute beerMass :> ISQ::mass [1]; // "this is a mass"
  }
  part def Person {
    attribute bodyMass :> ISQ::mass [1];
    attribute bloodAlcohol :> buzz [1];
    ref item drunk : Beer [0..*] nonunique;
    attribute totalMass :> ISQ::mass [1] =
      bodyMass + sum(drunk.beerMass);
  }
  part lab {
    item ipa : Beer {
      attribute :>> spec = new BeerSpec(6.5, 60.0);
      attribute :>> volume = 355 [mL];
      attribute :>> beerMass = 0.36 [kg];
    }
    part bob : Person {
      attribute :>> bodyMass = 80 [kg];
      ref item :>> drunk = (ipa, ipa, ipa);
    }
    part superBob : Person {
      attribute :>> bodyMass = 220 [lb]; // same def, other unit
    }
  }

  // view (not on the sheet): attribute defs and usages, standalone and inside the items and parts
  view bellyView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsBeerBelly::**;
    filter hastype SysML::AttributeDefinition | hastype SysML::AttributeUsage | hastype SysML::ItemDefinition
        | hastype SysML::PartDefinition | hastype SysML::ItemUsage | hastype SysML::PartUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
