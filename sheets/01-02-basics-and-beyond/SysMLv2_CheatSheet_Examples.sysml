/*
 *
 * Sheet 1 (basics)            -> packages S1_01 ... S1_08
 * Sheet 2 (Beyond the Basics) -> packages S2_01 ... S2_09
 *
 * Every package declares what it needs, so a package that fails to load in your tool does not
 * hide problems in the others. To test one package alone, copy it into its own file.
 * Cast: Bob (drinks beer), SuperBob (Bob after a radioactive software bug bite).
 *
 * VIEWS: every package ends with a view (not on the sheet) that exposes the package and filters to the
 *
 * Lines that differ from the (simplified) cheat-sheet text are marked "SHEET DIFFERS".
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package CheatSheetExamples {

  // =====================================================================================
  // SHEET 1 : THE BASICS
  // =====================================================================================

  // ---- Cards: PACKAGE, DEFINITION, USAGE, REFERENCE USAGE
  package S1_01_DefinitionUsage {
    private import ScalarValues::*;

    package Vehicles {
      part def Car;
      part car;
    }

    part def Vehicle {
      attribute mass : Real;                       // definition (square corners)
    }
    part car : Vehicle {                           // usage (rounded corners)
      attribute :>> mass = 1200.0;                 // sheet shows this as ^mass (inherited)
    }

    part def Bob;
    part def Cab {
      ref part driver : Bob;                       // reference usage (dashed outline)
    }

    // view (not on the sheet): packages, definitions, usages and the reference usage
    view defUsageView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S1_01_DefinitionUsage::**;
      filter hastype SysML::Package | hastype SysML::PartDefinition | hastype SysML::PartUsage
          | hastype SysML::AttributeUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: SPECIALIZATION  (symbols and their keyword forms)
  package S1_02_Specialization {
    private import ScalarValues::*;

    part def Bob { attribute beers : Integer default = 6; }   // default => can be redefined

    part def SuperBob :> Bob {                     // :>  specializes (definitions)
      attribute :>> beers = 0;                     // :>> redefines
    }

    part bobs : Bob [*] nonunique;
    part heroes : SuperBob :> bobs;                // :>  subsets (usages)
    part me : Bob;                                 // :   defined by (typing)

    part def Office {
      part worker : Bob;
      ref part boss ::> worker;                    // ::> references
    }

    // keyword forms of the same relationships
    part meKw defined by Bob;
    part def SuperBobKw specializes Bob {
      attribute redefines beers = 0;
    }
    part crewKw : Bob subsets bobs;
    part def OfficeKw {
      part worker : Bob;
      ref part bossKw references worker;
    }

    // view (not on the sheet): specializes, redefines, subsets, typing and references
    view specializationView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S1_02_Specialization::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::AttributeUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: ACTION FLOW
  package S1_03_ActionFlow {
    // Exactly the text on the card (review 2026-11-24: full textual notation for the diagram).
    // "then X;" names a target only, so both successions after "fork f" have f as source ([S] 7.17.4).
    action def Photo {
      first start; then fork f;
        then shoot; then save;
      action shoot; then j;
      action save; then j;
      join j; then terminate;                      // terminate node: ends the action now ([S] 7.17.10)
    }
    action def Quit {
      terminate;                                   // terminate node
    }

    // view (not on the sheet): the action flow: start, fork, join, terminate
    view photoFlow : DS_Views::SymbolicViews::afv {
      render Views::asInterconnectionDiagram;
      expose S1_03_ActionFlow::**;
      filter hastype SysML::ActionDefinition | @SysML::ActionUsage | @SysML::SuccessionAsUsage
          | @KerML::Step | @KerML::Succession;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: STATE MACHINE
  package S1_04_StateMachine {
    item def Go;
    item def Stop;
    state def Lamp {
      entry; then off;                             // start -> off
      state off; accept Go then on;                // shorthand: source = closest previous state ([S] 7.18.3)
      state on; accept Stop then off;
      // long form of the first transition: transition first off accept Go then on;
      // done (final state) and terminate in state machines: see sheet 5 STATES
    }

    // view (not on the sheet): the Lamp state machine
    view lampStates : DS_Views::SymbolicViews::stv {
      render Views::asInterconnectionDiagram;
      expose S1_04_StateMachine::**;
      filter hastype SysML::StateDefinition | @SysML::ActionUsage | @SysML::TransitionUsage
          | @KerML::Step | @KerML::Succession;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: PORT / CONNECT (+ RELATIONSHIPS: flow, binding, dependency, allocate, composite/referential)
  package S1_05_PortsConnections {
    private import ScalarValues::*;

    item def Fuel;
    port def FuelPort { out item fuel : Fuel; }
    part def Tank { port p : FuelPort; }
    part def Eng  { port q : ~FuelPort; }          // ~ = conjugated port

    part def Rig {
      part tank : Tank;
      part eng : Eng;
      // A flow is itself a connector (FlowUsage is a ConnectorAsUsage, [S] 8.3.16.3): no separate connect.
      // SHEET DIFFERS: sheet shows "flow of Fuel from tank.p to eng.q;" (shortened).
      // The flow must end on the item features carried by the ports:
      flow of Fuel from tank.p.fuel to eng.q.fuel;
    }

    part def Pair {
      attribute x : Integer;
      attribute y : Integer;
      bind x = y;                                  // binding connector
    }

    part supplier;
    part client;
    dependency from client to supplier;            // dashed open arrow
    allocate client to supplier;                   // allocation

    part def Assembly {
      part engine : Eng;                           // composite (filled diamond)
      ref part spare : Eng;                        // referential (hollow diamond)
      derived attribute total : Integer = 3;       // sheet shows derived as /total
    }

    // view (not on the sheet): parts, ports, flow, binding, dependency and allocation
    view portsView : DS_Views::SymbolicViews::iv {
      render Views::asInterconnectionDiagram;
      expose S1_05_PortsConnections::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::PortDefinition
          | hastype SysML::PortUsage | hastype SysML::ItemDefinition | hastype SysML::AttributeUsage
          | @SysML::ConnectorAsUsage | hastype SysML::Dependency;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: REQUIREMENT
  package S1_06_Requirement {
    private import ScalarValues::*;

    part def Vehicle { attribute mass : Real; }

    requirement def MaxMass {
      doc /* mass ≤ 1500 kg */                    // the diagram's doc compartment shows this text without /* */
      subject vehicle : Vehicle;
      require constraint { vehicle.mass <= 1500.0 }
    }

    part testbed {
      part car : Vehicle { attribute :>> mass = 1200.0; }
      requirement maxMass : MaxMass;               // satisfy names a requirement USAGE ([S] 8.3.21.10)
      satisfy maxMass by car;
    }

    // view (not on the sheet): the requirement, its usage and the satisfy
    view requirementView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S1_06_Requirement::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::RequirementDefinition
          | hastype SysML::RequirementUsage | hastype SysML::SatisfyRequirementUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: TEXTUAL NOTATION (qualified names, $::, import, [ ], =, :=, direction, { } ;, comments, metadata)
  package S1_07_TextualSymbols {
    private import ScalarValues::*;

    package Vehicles { part def Car; }

    package Users {
      private import Vehicles::*;                  // ::*  import all members
      private import Vehicles::**;                 // ::** import recursively
      part car1 : Vehicles::Car;                   // ::   qualified name
      attribute asReal : $::ScalarValues::Real;    // $::  resolve from the global namespace
      alias Auto for Vehicles::Car;                // alias
    }

    part def Wheel;
    part def Axle { part wheels : Wheel [4]; }     // [ ] multiplicity
    part 'left wheel' : Wheel;                     // ' ' quoted name
    part <p1> 'pump 1';                            // < > short name

    part def Counter {
      attribute cap : Integer = 12;                // =  fixed (bound) value: cannot be redefined
      attribute count : Integer := 0;              // := fixed initial value: cannot be redefined
      attribute beers : Integer default := 6;      // default := initial value that :>> CAN redefine
    }

    part outer {                                   // . feature chain
      part inner { attribute value : Integer = 5; }
      attribute chained : Integer = outer.inner.value;
    }

    item def Fuel;
    part def Pump {                                // in / out / inout
      in item fuelIn : Fuel;
      out item fuelOut : Fuel;
      inout item recirc : Fuel;
    }

    part bobUsage { part beer; }                   // { } body, ; empty body

    comment /* a comment element */
    doc /* documentation of this package */
    // a plain line note

    metadata def Safety;
    #Safety part pump2;                            // #  user keyword (metadata prefix)
    @Safety;                                       // @  metadata annotation of this package

    // view (not on the sheet): the named elements behind the textual symbols
    view textualView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S1_07_TextualSymbols::**;
      filter hastype SysML::Package | hastype SysML::PartDefinition | hastype SysML::PartUsage
          | hastype SysML::AttributeUsage | hastype SysML::ItemDefinition | hastype SysML::ItemUsage
          | hastype SysML::MetadataDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: MATH · LOGIC · TYPE TESTS
  package S1_08_MathLogic {
    private import ScalarValues::*;

    package Arithmetic {
      part ops {
        attribute x : Real = 7.0;
        attribute y : Real = 2.0;
        attribute sum  : Real = x + y;
        attribute diff : Real = x - y;
        attribute prod : Real = x * y;
        attribute quot : Real = x / y;
        attribute rem  : Real = x % y;
        attribute pow1 : Real = x ** y;
        attribute pow2 : Real = x ^ y;
        attribute span = 1..5;                     // range
        attribute list : Integer [*] ordered = (10, 20, 30);
        attribute second : Integer = list#(2);     // #( ) index
      }
    }

    package Comparison {
      part cmp {
        attribute x : Real = 7.0;
        attribute y : Real = 2.0;
        attribute eq     : Boolean = x == y;
        attribute neq    : Boolean = x != y;
        attribute same   : Boolean = x === y;      // same element
        attribute notSame: Boolean = x !== y;
        attribute lt : Boolean = x < y;
        attribute gt : Boolean = x > y;
        attribute le : Boolean = x <= y;
        attribute ge : Boolean = x >= y;
      }
    }

    package Logic {
      part lg {
        attribute p : Boolean = true;
        attribute q : Boolean = false;
        attribute a1 : Boolean = p and q;          // conditional and ([K] 7.4.9.2)
        attribute o1 : Boolean = p or q;
        attribute x1 : Boolean = p xor q;
        attribute n1 : Boolean = not p;
        attribute i1 : Boolean = p implies q;
        attribute a2 : Boolean = p & q;            // logical and ([K] 7.4.9.2)
        attribute o2 : Boolean = p | q;
      }
    }

    package Conditional {
      part cd {
        attribute p : Boolean = true;
        attribute x : Real = 7.0;
        attribute y : Real = 2.0;
        attribute pick : Real = if p ? x else y;   // if ? else
        attribute maybe : Real [0..1] = null;
        attribute fallback : Real = maybe ?? 0.0;  // ?? null fallback
      }
    }

    package TypeTests {
      part def Bob;
      part def SuperBob :> Bob;
      part bob : SuperBob;
      // istype : true if ALL values of the operand are classified by the type, subtypes included
      // hastype: true if ALL values are classified by the type itself, subtypes NOT included
      // @      : true if AT LEAST ONE value is classified by the type (like istype, "any" not "all")
      // as     : cast; does an istype test on each value and keeps only the values that pass,
      //          so every result value is guaranteed to be an instance of the type (may be empty)
      part tests {
        attribute t1 : Boolean = bob istype Bob;   // true : a SuperBob is a Bob
        attribute t2 : Boolean = bob hastype Bob;  // false: bob's type is SuperBob, not exactly Bob
        attribute t3 : Boolean = bob @ Bob;        // true : at least one value is a Bob
        attribute asBob = bob as Bob;              // cast: keeps only the values that are Bobs
        attribute everyone = all Bob;              // all instances
      }
    }

    // view (not on the sheet): the parts whose attributes hold each expression
    view mathView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S1_08_MathLogic::**;
      filter hastype SysML::Package | hastype SysML::PartDefinition | hastype SysML::PartUsage
          | hastype SysML::AttributeUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // =====================================================================================
  // SHEET 2 : BEYOND THE BASICS
  // =====================================================================================

  // ---- Card: SNAPSHOT · TIMESLICE  (Bob's origin story)
  package S2_01_SnapshotTimeslice {
    private import ScalarValues::*;

    part def Bob { attribute super : Boolean default = false; }   // default => can be redefined
    individual part def BobI :> Bob;               // an individual must have an individual definition

    individual part bob : BobI {
      snapshot bitten   { attribute :>> super = true; }   // the bite: an instant
      timeslice superBob { attribute :>> super = true; }  // SuperBob: Bob during a period
      first bitten then superBob;
    }

    // view (not on the sheet): Bob, the snapshot and the timeslice
    view originView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_01_SnapshotTimeslice::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::OccurrenceUsage
          | hastype SysML::AttributeUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: CROSS-SUBSETTING
  package S2_02_CrossSubsetting {
    part def Bob { ref part bugs    : Bug [*];    }
    part def Bug { ref part victims : Bob [1..*]; }

    connection def Bite {
      end bug : Bug crosses bob.bugs;              // crosses  ==  =>
      end bob : Bob => bug.victims;
    }

    // view (not on the sheet): Bob, Bug and the Bite connection ends
    view crossSubsetView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_02_CrossSubsetting::**;
      filter hastype SysML::PartDefinition | hastype SysML::ReferenceUsage | hastype SysML::PartUsage
          | hastype SysML::ConnectionDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: SEMANTIC METADATA
  package S2_03_SemanticMetadata {
    private import Metaobjects::SemanticMetadata;

    part def Hero;
    part heroes : Hero [*] nonunique;

    metadata def <hero> HeroMeta :> SemanticMetadata {
      :>> baseType = heroes meta SysML::Usage;
    }
    metadata def Origin;

    part bob;
    #hero part superBob;                           // shown as «#hero», implicitly subsets heroes
    @Origin about superBob;                        // ordinary metadata (no keyword)

    // view (not on the sheet): the hero metadata and what it marks
    view metadataView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_03_SemanticMetadata::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::MetadataDefinition
          | hastype SysML::MetadataUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: STATES
  package S2_04_States {
    private import ScalarValues::*;

    item def Bite;

    state def BobLife {
      attribute radioactive : Boolean = true;
      action glow;
      entry; then normal;
      state normal;
      state super { do glow; }                     // entry / do / exit actions
      transition first normal accept Bite
        if radioactive then super;                 // trigger + guard
    }

    state def Both parallel { state think; state drink; }   // parallel regions

    part def Hero {
      exhibit state life : BobLife;
    }

    // view (not on the sheet): BobLife, the parallel state and the exhibit
    view lifeStates : DS_Views::SymbolicViews::stv {
      render Views::asInterconnectionDiagram;
      expose S2_04_States::**;
      filter hastype SysML::StateDefinition | hastype SysML::PartDefinition | @SysML::ActionUsage
          | @SysML::TransitionUsage
          | @KerML::Step | @KerML::Succession;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: ACTIONS
  package S2_05_Actions {
    private import ScalarValues::*;
    private import SI::*;

    item def Bite;
    item def Alert;
    port def SignalPort { in item bite : Bite; out item alert : Alert; }

    part def Hero {
      port p : SignalPort;
      item alert : Alert;
      attribute beers : Integer := 6;
      attribute bugs : Integer [*] nonunique = (1, 2, 3);

      action reactions {
        accept Bite via p;
        accept after 5 [s];                        // time trigger
        send alert via p;
        assign beers := beers - 1;
        if beers > 0 { assign beers := beers - 1; } else { assign beers := 0; }
        while beers > 0 { assign beers := beers - 1; }
        loop { assign beers := beers - 1; } until beers == 0;
        for b in bugs { assign beers := beers + 1; }
      }
    }

    action def Stop { terminate; }

    // view (not on the sheet): the reactions: accept, send, assign, if, loops, terminate
    view reactionsFlow : DS_Views::SymbolicViews::afv {
      render Views::asInterconnectionDiagram;
      expose S2_05_Actions::**;
      filter hastype SysML::PartDefinition | hastype SysML::ActionDefinition | @SysML::ActionUsage
          | @SysML::SuccessionAsUsage
          | @KerML::Step | @KerML::Succession;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: USE CASE
  package S2_06_UseCase {
    part def City;
    part def SuperBob;
    use case def Change;
    use case def SaveCity {
      subject city : City;
      actor hero : SuperBob;
      objective { doc /* The city lives. */ }
      include use case change : Change;
    }

    // view (not on the sheet): the use case, subject, actor and include
    view useCaseView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_06_UseCase::**;
      filter hastype SysML::PartDefinition | hastype SysML::UseCaseDefinition | hastype SysML::IncludeUseCaseUsage
          | hastype SysML::ReferenceUsage | hastype SysML::PartUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: CASE FAMILY + JUST IN CASE
  package S2_07_CaseFamily {
    private import ScalarValues::*;

    part def Bob { attribute super : Boolean = false; }

    case def JustInCase :> Cases::Case {           // your extension of Case
      subject bob : Bob;
      objective { doc /* Be ready. */ }
      return ready : Boolean = bob.super;
    }
    case justInCase : JustInCase;

    // the rest of the family, by keyword
    use case def AUseCase;
    analysis def AnAnalysis;
    verification def AVerification;

    // view (not on the sheet): the case family
    view caseFamilyView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_07_CaseFamily::**;
      filter hastype SysML::PartDefinition | hastype SysML::CaseDefinition | hastype SysML::CaseUsage
          | hastype SysML::UseCaseDefinition | hastype SysML::AnalysisCaseDefinition | hastype SysML::VerificationCaseDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: TEST CASE (verification case)
  package S2_08_TestCase {
    private import ScalarValues::*;
    private import VerificationCases::*;           // PassIf, VerdictKind

    part def Bob { attribute super : Boolean = false; }

    requirement def SuperReq {
      subject b : Bob;
      require constraint { b.super }
    }
    part bob : Bob;
    // SHEET DIFFERS: sheet writes "verify SuperReq;" - verify names a requirement USAGE
    requirement superReq : SuperReq;

    verification def SuperTest {
      subject b : Bob;
      objective { verify superReq; }
      return verdict = PassIf(b.super);
    }
    verification t : SuperTest { subject b = bob; }

    // view (not on the sheet): the test, the requirement it verifies and Bob
    view testCaseView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_08_TestCase::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::RequirementDefinition
          | hastype SysML::RequirementUsage | hastype SysML::VerificationCaseDefinition | hastype SysML::VerificationCaseUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---- Card: ANALYSIS CASE
  package S2_09_AnalysisCase {
    private import ScalarValues::*;

    part def Bob { attribute beers : Integer = 6; }
    part bob : Bob;

    analysis def BeerBudget {
      subject b : Bob;
      objective { doc /* Minimize beers. */ }
      return result : Integer = b.beers * 2;
    }
    analysis plan : BeerBudget { subject b = bob; }

    // view (not on the sheet): the analysis and its subject
    view analysisView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S2_09_AnalysisCase::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::AnalysisCaseDefinition
          | hastype SysML::AnalysisCaseUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }
}
