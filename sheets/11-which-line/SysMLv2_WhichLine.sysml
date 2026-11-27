/*
 * SysML v2 WHICH LINE DO I DRAW? cheat-sheet example (sheet 11).
 * Bob's beer pipeline: connect, interface (port ends, ~ conjugation), streaming flow, message, bind.
 * Clauses: [S] 7.12, 7.13.2, 7.13.3, 7.14, 7.16.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsBeerPipeline {
  private import ScalarValues::*;
  item def Beer;
  attribute def Refill;
  port def TapPort { out item beer : Beer; }
  interface def Hose {
    end port src : TapPort;
    end port dst : ~TapPort;   // ~ flips out to in
  }
  part def Kegerator {
    port spout : TapPort;
    attribute psi : Real;
    event occurrence refillRequest;
  }
  part def Couch {
    port cupHolder : ~TapPort;
    event occurrence wantsMore;
  }
  part def Regulator { attribute psi : Real; }
  part lounge {
    part fridge : Kegerator;
    part couch : Couch;
    part co2 : Regulator;
    // connect: linked; says nothing about what moves
    connect co2 to fridge;
    // interface: a connection whose ends are ports
    interface hose : Hose
      connect fridge.spout to couch.cupHolder;
    // flow: beer moves from an out to an in
    flow of Beer
      from fridge.spout.beer to couch.cupHolder.beer;
    // message: an event happens; no pipe named
    message of Refill
      from couch.wantsMore to fridge.refillRequest;
    // bind: one value, two names
    bind co2.psi = fridge.psi;
  }

  // view (not on the sheet): the lounge, its parts, ports and the five lines
  view pipelineView : DS_Views::SymbolicViews::iv {
    render Views::asInterconnectionDiagram;
    expose BobsBeerPipeline::**;
    filter hastype SysML::PartUsage | hastype SysML::PortUsage | hastype SysML::AttributeUsage
        | hastype SysML::EventOccurrenceUsage | @SysML::ConnectorAsUsage | @SysML::FlowUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
