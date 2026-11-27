/*
 * SysML v2 ALLOCATION WITHOUT DOUBLE DUTY cheat-sheet example (sheet 14).
 * Bob's barbecue: each party action is performed once by a logical role; roles are allocated to the
 * physical garage with an allocation def (two typed ends) and nested allocations. No performs in the garage.
 * Clauses: [S] 7.15.1, 7.15.2, 7.17.6.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsBarbecue {
  action def Party {
    action chill;
    action playMusic;
    action grill;
  }
  part def Fridge;
  part def Speaker;
  part def Person;
  part def PartyRoles {          // logical: who must do it
    part cooler;
    part dj;
    part chef;
  }
  part def Garage {              // physical: what is there
    part fridge : Fridge;
    part speaker : Speaker;
    part bob : Person;
    part superBob : Person;
  }
  allocation def RolesToGarage {
    end part logical : PartyRoles;
    end part physical : Garage;
  }
  action party : Party;
  part roles : PartyRoles {      // each role performs once
    part :>> cooler { perform party.chill; }
    part :>> dj { perform party.playMusic; }
    part :>> chef { perform party.grill; }
  }
  part garage : Garage;          // no performs down here
  allocation plan : RolesToGarage
    allocate logical ::> roles to physical ::> garage {
      allocate logical.cooler to physical.fridge;
      allocate logical.dj to physical.speaker;
      allocate logical.chef to physical.bob;
    }

  // view (not on the sheet): the party actions, the roles that perform them and the allocations to the garage
  view allocationView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsBarbecue::**;
    filter hastype SysML::ActionDefinition | hastype SysML::PartDefinition | hastype SysML::AllocationDefinition
        | hastype SysML::ActionUsage | hastype SysML::PartUsage | hastype SysML::PerformActionUsage
        | hastype SysML::AllocationUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
