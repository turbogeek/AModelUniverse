/*
 * SysML v2 WHEN THERE IS NO DEF cheat-sheet example (sheet 18, "contradictions in SysML v2").
 * The code is the textual notation card on the sheet, followed by a view a tool can render.
 * Usage-only kinds marked "no def": alias, variant, snapshot, perform, transition, bind, message,
 * control nodes, succession, satisfy, dependency and comment. flow has both a def and a usage.
 * Clauses: [S] 7.5, 7.6.7, 7.9.3, 7.13.3, 7.13.5, 7.16, 7.17.3, 7.17.6, 7.18.3, 7.21.4.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package WhereIsTheDef {
  private import ScalarValues::*;
  item def Beer;
  flow def BeerRun;               // flow: def AND usage
  state def Mood;
  part def Fridge {
    out item cold : Beer;
    attribute stock : Integer;
    event occurrence serve;
  }
  part def Person {
    in item mouth : Beer;
    attribute beers : Integer;
    event occurrence ask;
  }
  requirement def Hydrated { subject p : Person; }
  alias Lager for Beer;           // alias: no def
  variation item def Snack {
    variant item chips;           // variant: no def
    variant item pretzels;
  }
  part lab {
    part fridge : Fridge;
    part bob : Person {
      snapshot sixPm;             // portion: no def
      perform evening;            // perform: no def
      exhibit state mood : Mood {
        entry; then sober;
        state sober; state tipsy;
        transition first sober    // transition: no def
          accept Beer then tipsy;
      }
    }
    bind bob.beers = fridge.stock; // binding: no def
    message order of Beer         // message: no def
      from bob.ask to fridge.serve;
    flow run : BeerRun of Beer    // flow: has a def
      from fridge.cold to bob.mouth;
    action evening {
      action grab; action drink; action burp;
      fork split; join together;  // control: no def
      first start then grab;      // succession: no def
      first grab then split;
      first split then drink;
      first split then burp;
      first drink then together;
      first burp then together;
      first together then done;
    }
    requirement hydrated : Hydrated;
    satisfy hydrated by bob;      // satisfy: no def
  }
  dependency thirst from lab::bob to lab::fridge;
  comment /* a comment has no def either */

  // view (not on the sheet): the lab: parts, items, actions and the usage-only connectors
  view noDefView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose WhereIsTheDef::**;
    filter hastype SysML::PartUsage | hastype SysML::ItemUsage | @SysML::ActionUsage
        | @SysML::ConnectorAsUsage | @SysML::FlowUsage | hastype SysML::RequirementUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
