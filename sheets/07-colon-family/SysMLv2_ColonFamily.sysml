/*
 * SysML v2 THE COLON FAMILY cheat-sheet example (sheet 7).
 * After the MBSE lab's sushi Friday, Bob hosts a 9 m tapeworm. Every colon in SysML v2, shown inside Bob's colon:
 * :: address, : defined by, :> specializes/subsets, :>> redefines, ::> references, plus = := default ==.
 * Clauses: [K] 7.2.5.1, 7.3.3.3, 7.3.4.3 to 7.3.4.5, 7.4.6.2, 7.4.9.2, 7.4.11; [S] 7.6.3, 7.6.4, 7.13.4.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package TheColonFamily {
  private import ScalarValues::*;
  private import SI::kg;  // :: is an address
  private import SI::m;
  item def Poop {
    attribute bristolType : Integer; // 1 rocks..7 soup
    attribute mass :> ISQ::mass;
  }
  part def Parasite { ref part host : Human; }
  part def Gut {
    part inhabitants : Parasite[0..*];
    item contents : Poop[0..*];
  }
  part def Human {
    part gut : Gut;
    attribute strength : Integer default 83;
    attribute appetite : Integer default 100;
    attribute bristol : Integer default 4;
    attribute codeBrown : Boolean = bristol == 7;
  }
  part def Bob :> Human;
  part def Tapeworm :> Parasite {
    attribute length :> ISQ::length;
  }
  part def Hookworm :> Parasite;
  part def MBSELab {
    attribute toiletPaper : Natural := 12;
    item spills : Poop[0..*];
  }
  part lab : MBSELab {
    part bob : Bob {
      :>> strength = 41;  // the worm took half
      :>> appetite = 300; // eating for two
      :>> bristol = 7;    // so codeBrown is true
      part :>> gut {
        part tapeworm : Tapeworm :> inhabitants {
          ref part :>> host = bob;
          :>> length = 9.0 [m];
        }
        item morningPoop : Poop :> contents {
          :>> bristolType = 7;
          :>> mass = 0.4 [kg];
        }
      }
    }
    item splatter :> spills;
    part centrifuge {
      ref item sample ::> bob.gut.morningPoop;
    }
    part notebook {
      ref item exhibitA references bob.gut.morningPoop;
    }
  }

  // view (not on the sheet): the family tree of definitions and the lab's usages
  view colonFamilyView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose TheColonFamily::**;
    filter hastype SysML::PartDefinition | hastype SysML::ItemDefinition | hastype SysML::PartUsage
        | hastype SysML::ItemUsage | hastype SysML::ReferenceUsage | hastype SysML::AttributeUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
