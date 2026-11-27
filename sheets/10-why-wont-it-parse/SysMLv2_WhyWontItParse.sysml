/*
 * SysML v2 WHY WON'T IT PARSE? cheat-sheet example (sheet 10).
 * Bob's car: keywords quoted or renamed, 'names' vs "text", the three import forms, alias, doc and comments.
 * The FIND SEVEN BUGS listing on the sheet is deliberately broken and is not part of this model.
 * Clauses: [K] 7.2.2.2, 7.2.4, 7.2.5.2, 7.2.5.3, 8.2.2; [S] 8.2.2.1.2.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsGarage {
  private import ScalarValues::*;  // Real, String
  private import ISQ::MassValue;   // just one member
  private import SI::*;            // all of SI: kg, mm
  part def Frame;
  part def Filter;
  part def Dashboard;
  part def Car {
    doc /* Bob's 2003 hatchback, mostly tape */
    attribute mass : MassValue;
    // spaces in a name: quote it
    attribute 'emissions standard' : String;
    // frame is a keyword: quote it ...
    part 'frame' : Frame;
    // ... or rename it (filter is one too)
    part oilFilter : Filter;
    part dash : Dashboard;
    /* a comment: kept in the model */
    // a note: the parser throws it away
  }
  alias Chassis for Car::'frame';
  part bobsCar : Car {
    :>> mass = 1150 [kg];
    :>> 'emissions standard' = "Euro 4";
  }

  // view (not on the sheet): Bob's car, its quoted and renamed parts, and bobsCar
  view garageView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsGarage::**;
    filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::AttributeUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
