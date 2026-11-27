/*
 * SysML v2 INSIDE AN INTERFACE cheat-sheet example (sheet 17).
 * Blackout in the lab: Algernon the lab mouse runs a wheel generator for Bob's beer fridge. A composite port
 * (FridgePlug) holds power and data ports; the SmartPlug interface def nests a PowerLink interface (with a
 * Kirchhoff constraint) and a flow of BeerLow. The same def connects the backup generator, SuperBob.
 * Clauses: [S] 7.12 Ports, 7.14 Interfaces, 7.17.7 Send actions, 9.2.7 Interfaces library.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsBlackout {
  private import ISQ::*;
  private import SI::*;
  item def BeerLow;
  port def PowerPort {
    attribute across : ElectricPotentialDifferenceValue;
    attribute through : ElectricCurrentValue;
  }
  port def DataPort { out item alert : BeerLow; }
  port def FridgePlug {     // ports inside a port
    port power : PowerPort;
    port data : DataPort;
  }
  interface def PowerLink {
    end load : PowerPort;
    end supply : ~PowerPort;
    constraint { load.across == supply.across and
      load.through + supply.through == 0 [A] }
  }
  interface def SmartPlug {
    end fridgeSide : FridgePlug;
    end wallSide : ~FridgePlug;
    interface power : PowerLink
      connect fridgeSide.power to wallSide.power;
    flow of BeerLow
      from fridgeSide.data.alert to wallSide.data.alert;
  }
  part def Fridge {
    port plug : FridgePlug;
    action nag { send new BeerLow() via plug.data; }
  }
  part def PowerSource { port socket : ~FridgePlug; }
  part def AlgernonWheel :> PowerSource;
  part def SuperBob :> PowerSource;
  part lab {
    part fridge : Fridge;
    part algernon : AlgernonWheel;
    part superBob : SuperBob;
    interface tonight : SmartPlug
      connect fridge.plug to algernon.socket;
    // backup: same def, no name needed
    interface : SmartPlug
      connect fridge.plug to superBob.socket;
  }

  // view (not on the sheet): the lab during the blackout: fridge, Algernon, SuperBob, their plugs and the two interfaces
  view blackoutView : DS_Views::SymbolicViews::iv {
    render Views::asInterconnectionDiagram;
    expose BobsBlackout::**;
    filter hastype SysML::PartUsage | hastype SysML::PortUsage | hastype SysML::InterfaceUsage
        | @SysML::ConnectorAsUsage | @SysML::FlowUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
