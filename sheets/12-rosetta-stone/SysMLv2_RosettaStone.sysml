/*
 * SysML v1 TO v2 ROSETTA STONE cheat-sheet example (sheet 12).
 * The Professor's fridge, a v1 block translated: attributes, parts, refs, ports, enum, metadata,
 * specialization, redefinition, a requirement and satisfy. Comments name the v1 term (rules of thumb;
 * the normative mapping is SysML v2 Part 2, v1 to v2 Transformation).
 * Clauses: [S] 7.6 to 7.12, 7.21, 7.27.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package ProfessorsFridge {
  private import ScalarValues::*;
  private import ISQ::*;     // v1 ValueTypes live here now
  private import SI::*;      // units are values: 5 [kg]
  item def Beer;
  port def PowerPort {                // «interfaceBlock»
    in attribute volts : ElectricPotentialValue;
  }
  enum def DoorState { enum open; enum closed; }
  metadata def Approved {             // «stereotype»
    attribute approver : String;      // by is a keyword
  }
  part def Compressor;
  part def Person;
  part def Fridge {                   // «block»
    @Approved { approver = "Professor"; }
    attribute temp : TemperatureValue; // value property
    attribute door : DoorState;
    part compressor : Compressor;     // part property
    ref part owner : Person;          // reference property
    ref item beers : Beer[0..*];      // shared, not owned
    port power : PowerPort;           // proxy port
  }
  part def MiniFridge :> Fridge {     // generalization
    part :>> compressor[0..1];        // {redefines}
  }
  requirement def ColdBeer {          // «requirement»
    doc /* The beer shall be colder than 5 °C. */
    subject f : Fridge;
    require constraint { f.temp < 278.15 [K] }
  }
  part lab {                          // ibd context
    part fridge : MiniFridge;
    part prof : Person;
    requirement coldBeer : ColdBeer;
    satisfy coldBeer by fridge;       // «satisfy»
  }

  // view (not on the sheet): the fridge definitions, the lab and the satisfy
  view fridgeView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose ProfessorsFridge::**;
    filter hastype SysML::PartDefinition | hastype SysML::PortDefinition | hastype SysML::EnumerationDefinition
        | hastype SysML::MetadataDefinition | hastype SysML::RequirementDefinition | hastype SysML::PartUsage
        | hastype SysML::ReferenceUsage | hastype SysML::AttributeUsage | hastype SysML::PortUsage
        | hastype SysML::RequirementUsage | hastype SysML::SatisfyRequirementUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
