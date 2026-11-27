/*
 * SysML v2 OWN IT OR USE IT cheat-sheet example (sheet 13).
 * Bob owns Rex and borrows Ned's mower: composite part, ref part, attribute (never owns), perform and exhibit
 * (referential), and one owner / many users with ref + bind.
 * Clauses: [S] 7.6.1, 7.6.3, 7.7, 7.13.1, 7.13.3, 7.17.6, 7.18.4.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsBorrowedMower {
  private import ScalarValues::*;
  part def Person;
  part def Dog;
  part def Mower;
  part def TV;
  action def Mow;
  state def Mood;
  part neighborhood {
    part ned : Person {
      part mower : Mower;        // Ned owns it
    }
    action chores {              // the chore list
      action mowLawn : Mow;      // owns its steps
    }
    part bob : Person {
      part rex : Dog;            // Bob owns Rex
      ref part borrowed : Mower = ned.mower;
      attribute beers : Integer; // never owns
      perform chores.mowLawn;    // does it, owns it not
      exhibit state mood : Mood; // points, like perform
      part house {
        part livingRoom { part tv : TV; }
        part couchFort { ref part screen : TV; }
        // one owner, many users: bind them
        bind couchFort.screen = livingRoom.tv;
      }
    }
  }

  // view (not on the sheet): the neighborhood tree: what each usage owns and what it only points at
  view ownershipView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsBorrowedMower::**;
    filter hastype SysML::PartDefinition | hastype SysML::ActionDefinition | hastype SysML::StateDefinition
        | hastype SysML::PartUsage | hastype SysML::ReferenceUsage | hastype SysML::ActionUsage
        | hastype SysML::PerformActionUsage | hastype SysML::ExhibitStateUsage | hastype SysML::AttributeUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
