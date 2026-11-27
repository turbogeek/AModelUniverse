/*
 * SysML v2 METADATA & #KEYWORDS cheat-sheet example (sheet 20).
 * The code is the textual notation card on the sheet, followed by a view a tool can render.
 * Bob's sticky notes: a tag (Untouchable), a structured note (Approval), a restricted note (FridgeNote, parts
 * only), semantic metadata as a user keyword (#beer), library metadata (Rationale), metadata ... about, and a
 * view filtered by metadata. Clauses: [S] 7.27 Metadata, 7.26 Views, 9.3 Metadata Domain Library.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsStickyNotes {
  private import ScalarValues::*;
  private import ModelingMetadata::*;
  private import Metaobjects::SemanticMetadata;
  metadata def Untouchable;          // a tag: no features
  metadata def Approval {            // usages must fill these
    attribute approved : Boolean;
    attribute approver : String;
  }
  metadata def FridgeNote {          // only on parts
    :> annotatedElement : SysML::PartUsage;
    attribute temp : Real;
  }
  item def Beer;
  item beers : Beer [0..*] nonunique;
  metadata def <beer> BeerKeyword :> SemanticMetadata {
    :>> baseType = beers meta SysML::Usage;
  }
  part lab {
    part fridge {
      @Untouchable;                  // about fridge
      @FridgeNote { temp = 4.0; }
      #beer item ipa;                // subsets beers
      #beer stout;                   // no other keyword
    }
    part reactor {
      @Approval {
        approved = false;
        approver = "Professor";
      }
      @Rationale { text = "Bob touched it."; }
    }
  }
  metadata bobSaysOk : Approval about lab::fridge {
    approved = true;
    approver = "Bob";
  }
  view untouchables {
    expose lab::**;
    filter @Untouchable;
  }

  // view (not on the sheet): the lab, its items and every metadata def and usage
  view stickyView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsStickyNotes::**;
    filter hastype SysML::MetadataDefinition | hastype SysML::MetadataUsage | hastype SysML::PartUsage
        | hastype SysML::ItemUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
