/*
 * SysML v2 REQUIREMENTS cheat-sheet examples, one self-contained package per card, for tool testing.
 *
 *   S3_01_BobsTransformation  card: BOB'S TRANSFORMATION  (scenario + requirement def/usage)
 *   S3_02_ConstraintFlavors   card: CONSTRAINT FLAVORS    (constraint / assert / assume / require)
 *   S3_03_ParametricReq       card: PARAMETRIC REQUIREMENT
 *   S3_04_AssumeRequire       card: ASSUME x REQUIRE      (the truth table, as four cases)
 *   S3_05_VerificationCase    card: VERIFICATION CASE (test)
 *   S3_06_TradeStudy          card: TRADE STUDY: REFRESHMENT
 *   S3_07_OrganizeTrace       card: ORGANIZE & TRACE
 *   S3_08_HeroTimeslice       newsletter: the SuperBob timeslice (snapshot + timeslice + use case)
 *
 * Scenario: when the city is in trouble and a hero is needed, Bob may transform into SuperBob only if his
 * blood alcohol (BAC) is below the legal limit. Law Enforcement raises the concern. The generic requirement
 * is SafeToOperateEquipment (it frames the BloodAlcohol concern); its usage for Bob is heroTransform
 * ('Safe Superhero').
 *
 * Conventions used so each package loads on its own:
 *   - each package imports what it uses (ScalarValues, VerificationCases, TradeStudies)
 *   - an attribute that is later redefined is declared with "default =" or with no value
 *   - a subject is bound EITHER with "subject x = y" OR by "satisfy r by y" - never both
 *     (a second binding is reported as "cannot override a non-default value")
 *
 * VIEWS: every package ends with view(s) that reproduce the card's graphic, written in the pattern that works
 *   - render Views::asTreeDiagram (boxes with relationships) or Views::asInterconnectionDiagram (action flow)
 *   - filter hastype SysML::<metaclass> | ...   keeps only the element kinds shown on the card
 *   - filter not KerML::Element::isLibraryElement   removes standard-library elements
 *   - hastype (exact metaclass) is used so a view, which is itself a kind of part, never lists itself
 *
 * NOTE: written from the SysML v2 textual BNF and the official training examples; NOT run through a parser.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package RequirementsExamples {

  // ---------------------------------------------------------------------------------
  // BOB'S TRANSFORMATION
  // ---------------------------------------------------------------------------------
  package S3_01_BobsTransformation {
    private import SysML::*;
    private import ScalarValues::*;

    part def Person { attribute bac : Real; }          // bac = blood alcohol, g/dL
    part def Bob :> Person;
    part def LawEnforcement;

    concern def BloodAlcohol {                         // the worry...
      doc /* Operators of equipment must not be impaired. */
      stakeholder police : LawEnforcement;             // ...and who raises it
    }

    requirement def SafeToOperateEquipment {           // generic, reusable
      doc /* Operator BAC under the legal limit. */
      subject operator : Person;
      attribute legalLimit : Real default = 0.08;
      attribute actual : Real = operator.bac;
      frame concern bac : BloodAlcohol;
      require constraint { actual < legalLimit }
    }

    part lab {
      part bob : Bob { attribute :>> bac = 0.03; }

      requirement <heroTransform> 'Safe Superhero' : SafeToOperateEquipment {
        attribute needSuperhero : Boolean;
        attribute cityInTrouble : Boolean;
        assume constraint { needSuperhero }
        assume constraint { cityInTrouble }
      }
      satisfy heroTransform by bob;                    // binds bob to the subject
    }

    // card graphic: requirement def, its usage, the concern and stakeholder, bob
    view scenarioView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_01_BobsTransformation::**;
      filter hastype SysML::RequirementDefinition | hastype SysML::RequirementUsage
          | hastype SysML::SatisfyRequirementUsage
          | hastype SysML::ConcernDefinition | hastype SysML::PartDefinition
          | hastype SysML::PartUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // CONSTRAINT FLAVORS
  // ---------------------------------------------------------------------------------
  package S3_02_ConstraintFlavors {
    private import SysML::*;
    private import ScalarValues::*;

    part def Person { attribute bac : Real; }
    part def Bob :> Person;

    constraint def BelowLimit { in value : Real; in limit : Real; value < limit }

    part lab {
      part bob : Bob { attribute :>> bac = 0.03; }

      constraint sober { bob.bac < 0.08 }                       // constraint: may be false
      constraint soberChecked : BelowLimit {                    // reusable constraint, inputs bound
        in value = bob.bac;
        in limit = 0.08;
      }
      assert constraint bacNotNegative { bob.bac >= 0.0 }       // must ALWAYS hold
      assert not constraint bacImpossible { bob.bac > 1.0 }     // asserted to be false
    }

    // card graphic: the constraint definition and the constraint / assert constraint usages
    view constraintsView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_02_ConstraintFlavors::**;
      filter hastype SysML::ConstraintDefinition | hastype SysML::ConstraintUsage
          | hastype SysML::AssertConstraintUsage | hastype SysML::PartUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // PARAMETRIC REQUIREMENT  (subject feeds the parameters; reuse by overriding / rebinding)
  // ---------------------------------------------------------------------------------
  package S3_03_ParametricReq {
    private import SysML::*;
    private import ScalarValues::*;

    part def Person { attribute bac : Real; }
    part def Bob :> Person;
    part def Trucker :> Person;
    part def LawEnforcement;

    concern def BloodAlcohol {
      doc /* Operators of equipment must not be impaired. */
      stakeholder police : LawEnforcement;
    }

    requirement def SafeToOperateEquipment {
      subject operator : Person;
      attribute legalLimit : Real default = 0.08;
      attribute actual : Real = operator.bac;
      frame concern bac : BloodAlcohol;
      require constraint { actual < legalLimit }
    }

    part lab {
      part bob : Bob { attribute :>> bac = 0.03; }
      part trucker : Trucker { attribute :>> bac = 0.05; }

      requirement <heroTransform> 'Safe Superhero' : SafeToOperateEquipment {
        attribute needSuperhero : Boolean;
        attribute cityInTrouble : Boolean;
        assume constraint { needSuperhero }
        assume constraint { cityInTrouble }
      }
      satisfy heroTransform by bob;                             // binds the subject

      requirement truckDriver : SafeToOperateEquipment {        // reuse: other subject, tighter limit
        subject operator = trucker;                             // (explicit binding; no satisfy here)
        attribute :>> legalLimit = 0.04;
      }
    }

    // card graphic: the requirement, its parameters (attributes) and its usages
    view parametricView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_03_ParametricReq::**;
      filter hastype SysML::RequirementDefinition | hastype SysML::RequirementUsage
          | hastype SysML::SatisfyRequirementUsage | hastype SysML::AttributeUsage
          | hastype SysML::PartDefinition | hastype SysML::PartUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // ASSUME x REQUIRE  (four cases = the four cells of the truth table)
  // ---------------------------------------------------------------------------------
  package S3_04_AssumeRequire {
    private import SysML::*;
    private import ScalarValues::*;

    part def Person { attribute bac : Real; }
    part def Bob :> Person;
    part def LawEnforcement;

    concern def BloodAlcohol {
      doc /* Operators of equipment must not be impaired. */
      stakeholder police : LawEnforcement;
    }

    requirement def SafeToOperateEquipment {
      subject operator : Person;
      attribute legalLimit : Real default = 0.08;
      frame concern bac : BloodAlcohol;
      require constraint { operator.bac < legalLimit }
    }

    requirement def HeroGate :> SafeToOperateEquipment {
      attribute needSuperhero : Boolean;
      attribute cityInTrouble : Boolean;
      assume constraint { needSuperhero }
      assume constraint { cityInTrouble }
    }

    part cases {
      part soberBob : Bob { attribute :>> bac = 0.03; }
      part drunkBob : Bob { attribute :>> bac = 0.12; }

      requirement crisisSober : HeroGate {                      // assume true,  require true  => satisfied
        subject operator = soberBob;
        attribute :>> needSuperhero = true;
        attribute :>> cityInTrouble = true;
      }
      requirement crisisDrunk : HeroGate {                      // assume true,  require false => VIOLATED
        subject operator = drunkBob;
        attribute :>> needSuperhero = true;
        attribute :>> cityInTrouble = true;
      }
      requirement calmSober : HeroGate {                        // assume false, require true  => not applicable
        subject operator = soberBob;
        attribute :>> needSuperhero = false;
        attribute :>> cityInTrouble = false;
      }
      requirement calmDrunk : HeroGate {                        // assume false, require false => not applicable
        subject operator = drunkBob;
        attribute :>> needSuperhero = false;
        attribute :>> cityInTrouble = false;
      }
    }

    // card graphic: the four cases (requirement usages) and the two Bobs
    view truthTableView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_04_AssumeRequire::**;
      filter hastype SysML::RequirementDefinition | hastype SysML::RequirementUsage
          | hastype SysML::PartUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // VERIFICATION CASE (test)
  // ---------------------------------------------------------------------------------
  package S3_05_VerificationCase {
    private import SysML::*;
    private import ScalarValues::*;
    private import VerificationCases::*;                  // PassIf, VerdictKind

    part def Person { attribute bac : Real; }
    part def Bob :> Person;
    part def LawEnforcement;

    concern def BloodAlcohol {
      doc /* Operators of equipment must not be impaired. */
      stakeholder police : LawEnforcement;
    }

    requirement def SafeToOperateEquipment {
      subject operator : Person;
      attribute legalLimit : Real default = 0.08;
      attribute actual : Real = operator.bac;
      frame concern bac : BloodAlcohol;
      require constraint { actual < legalLimit }
    }
    requirement <heroTransform> 'Safe Superhero' : SafeToOperateEquipment;

    verification def BacTest {
      subject bob : Bob;
      objective { verify heroTransform; }
      action measure {
        out reading : Real;
      }
      action evaluate {
        in reading : Real
          = measure.reading;
        out verdict : VerdictKind
          = PassIf(reading < 0.08);
      }
      first measure then evaluate;
      return verdict : VerdictKind
        = evaluate.verdict;
    }

    part me : Bob { attribute :>> bac = 0.03; }
    verification bacTest : BacTest { subject bob = me; }

    // card graphic (left): the verification case verifying the requirement
    view verificationView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_05_VerificationCase::**;
      filter hastype SysML::VerificationCaseDefinition
          | hastype SysML::VerificationCaseUsage | hastype SysML::RequirementUsage
          | hastype SysML::PartUsage;
      filter not KerML::Element::isLibraryElement;
    }

    // card graphic (inside the box): measure -> evaluate
    view bacTestFlow : DS_Views::SymbolicViews::gv {
      render Views::asInterconnectionDiagram;
      expose S3_05_VerificationCase::BacTest::**;
      filter hastype SysML::ActionUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // TRADE STUDY: REFRESHMENT  (minimize BAC rise = maximize hero availability)
  // Same pattern as a trade study that evaluates in Cameo: a base part USAGE with default values,
  // alternatives that specialize it (:>) and redefine the values, and a study whose subject subsets it.
  // (A part DEFINITION with unvalued attributes cannot be evaluated: "Unsupported argument(s)".)
  // BAC rise per drink ~ alcohol oz / 30  (about +0.02 for one standard drink, 160 lb).
  // ---------------------------------------------------------------------------------
  package S3_06_TradeStudy {
    private import SysML::*;
    private import ScalarValues::*;
    private import TradeStudies::*;

    part drink {
      attribute abv : Real default := 0.05;             // alcohol by volume
      attribute pour : Real default := 12;              // Bob's usual pour, oz
      attribute bacRise : Real
        = abv * pour / 30.0;                            // BAC rise per drink
    }

    part beer :> drink {                                // LIGHT beer: 12 oz x 4.2% = 0.504 oz -> +.017
      attribute :>> abv = 0.042;
      attribute :>> pour = 12;
      doc /* ‡ Bob's preference */
    }
    part wine :> drink {                                // 6 oz x 12%   = 0.72 oz -> +.024
      attribute :>> abv = 0.12;
      attribute :>> pour = 6;
    }
    part rye :> drink {                                 // 2 oz x 40%   = 0.80 oz -> +.027
      attribute :>> abv = 0.40;
      attribute :>> pour = 2;
    }

    analysis pick : TradeStudy {
      subject candidates :> drink
        = (beer, wine, rye);
      objective : MinimizeObjective {
        subject ;
      }
      calc :>> evaluationFunction {
        in part aDrink
          :> candidates :>> alternative;
        return :>> result
          = aDrink.bacRise;
      }
      return part lowestBac
        :>> selectedAlternative :> drink;
    }

    // card graphic: the alternatives and the study that picks one
    view tradeStudyView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_06_TradeStudy::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::AnalysisCaseUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // ORGANIZE & TRACE
  // ---------------------------------------------------------------------------------
  package S3_07_OrganizeTrace {
    private import SysML::*;
    private import ScalarValues::*;

    part def Person {
      attribute bac : Real;
      attribute conscious : Boolean;
    }
    part def LawEnforcement;

    concern def BloodAlcohol {
      stakeholder police : LawEnforcement;              // who cares
    }

    requirement def Awake {                             // a sub-requirement to nest
      subject operator : Person;
      require constraint { operator.conscious }
    }
    requirement def CapeSafe;
    requirement capeInspected : CapeSafe;               // a requirement to group by reference

    requirement def <'R1'> SafeToOperateEquipment {     // <'R1'> = readable ID
      subject operator : Person;
      attribute legalLimit : Real default = 0.08;
      require constraint { operator.bac < legalLimit }
      frame concern bac : BloodAlcohol;                 // why it exists
      requirement awake : Awake;                        // decompose: nest it
      require capeInspected;                            // group: by reference
    }

    requirement def HeroGate :> SafeToOperateEquipment; // flow-down: specialize

    // card graphic: the requirement hierarchy with its concern
    view organizeView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_07_OrganizeTrace::**;
      filter hastype SysML::RequirementDefinition | hastype SysML::RequirementUsage
          | hastype SysML::ConcernDefinition | hastype SysML::PartDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // ---------------------------------------------------------------------------------
  // HERO TIMESLICE + DAY CONTEXT  (newsletter)
  //
  // Time:  Bob is SuperBob only during a timeslice. snapshot = an instant; timeslice = a period.
  //        Before the bite super = false; at the bite and after, super = true.
  //        The use cases assume Bob has his powers (assert constraint heroHasPowers).
  //
  // Extension logic (SysML v1 "extend") is owned by the CONTEXT, here a day in Bob's life (BobsDay):
  //   extension point      ->  a named decision node           (decide callIn, decide fitness)
  //   extension guard      ->  a guarded succession            (if needSuperhero and cityInTrouble then measure)
  //   extension not taken  ->  the else branch                 (else dayOver = terminate)
  //   alternate flow       ->  another else branch             (else backup  = call a backup hero)
  //
  // The verification case (BacTest) is NOT part of the use case flow. It tests the design and reuses the
  // same action (MeasureBac) and the same limit (heroTransform.legalLimit) that the day uses.
  // ---------------------------------------------------------------------------------
  package S3_08_HeroTimeslice {
    private import SysML::*;
    private import ScalarValues::*;
    private import VerificationCases::*;                  // PassIf, VerdictKind

    part def Person {
      attribute bac : Real default = 0.0;               // default => the snapshot / timeslice can redefine it
    }
    part def Bob :> Person {
      attribute super : Boolean default = false;
    }
    individual part def BobI :> Bob;                    // an individual needs an individual definition
    part def City;
    part def LawEnforcement;

    concern def BloodAlcohol {
      doc /* Operators of equipment must not be impaired. */
      stakeholder police : LawEnforcement;
    }

    requirement def SafeToOperateEquipment {
      doc /* Operator BAC under the legal limit. */
      subject operator : Person;
      attribute legalLimit : Real default = 0.08;
      attribute actual : Real = operator.bac;
      frame concern bac : BloodAlcohol;
      require constraint { actual < legalLimit }
    }

    // package level, so the day, the test and the satisfy can all name it
    requirement <heroTransform> 'Safe Superhero' : SafeToOperateEquipment {
      attribute needSuperhero : Boolean;
      attribute cityInTrouble : Boolean;
      assume constraint { needSuperhero }
      assume constraint { cityInTrouble }
    }

    // ---- shared behavior: reused by the day (design) and by the test (verification)
    action def MeasureBac {
      in operator : Person;
      out reading : Real = operator.bac;
    }
    action def CallBackup;

    // ---- the test: verifies the design, reuses MeasureBac and the requirement's limit
    verification def BacTest {
      subject bob : Bob;
      objective { verify heroTransform; }
      action measure : MeasureBac { in operator = bob; }
      action evaluate {
        in reading : Real = measure.reading;
        out verdict : VerdictKind = PassIf(reading < heroTransform.legalLimit);
      }
      first measure then evaluate;
      return verdict : VerdictKind = evaluate.verdict;
    }

    // ---- the mission
    use case def Change;
    use case def SaveCity {
      subject city : City;
      actor hero : Bob;
      assert constraint heroHasPowers { hero.super }    // we assume Bob has his powers
      objective { doc /* The city lives. */ }
      include use case change : Change;
    }

    // ---- the context: a day in Bob's life owns the decisions (the extension points)
    use case def BobsDay {
      subject city : City;
      actor hero : Bob;
      attribute needSuperhero : Boolean;
      attribute cityInTrouble : Boolean;
      assert constraint heroHasPowers { hero.super }

      first start;
      then action relax;                                // a quiet evening and a light beer
      then decide callIn;                               // extension point: is it a crisis?
        if needSuperhero and cityInTrouble then measure;    // positive guard
        else dayOver;                                   // calm day

      action measure : MeasureBac { in operator = hero; }   // the check (the test reuses this action)
      then decide fitness;                              // extension point: is the hero fit to operate?
        if measure.reading < heroTransform.legalLimit then rescue;   // positive guard
        else backup;                                    // alternate flow

      include use case rescue : SaveCity;               // the mission
      then dayOver;

      action backup : CallBackup;                       // call a backup hero
      then dayOver;

      action dayOver terminate;                         // terminate node ends the day (preferred over done)
    }

    part world {
      individual part bob : BobI {
        snapshot beforeBite {                           // before the bite: no powers
          attribute :>> super = false;
        }
        snapshot bitten {                               // the instant Bob transforms: powers on
          attribute :>> super = true;
          attribute :>> bac = 0.03;
        }
        timeslice superBob {                            // from then on: SuperBob
          attribute :>> super = true;
          attribute :>> bac = 0.03;
        }
        first beforeBite then bitten;
        first bitten then superBob;
      }

      satisfy heroTransform by bob.superBob;            // the TIMESLICE is the subject (bound once, here)

      use case bobsDay : BobsDay {
        actor hero = bob.superBob;                      // the hero is the SuperBob timeslice
        attribute :>> needSuperhero = heroTransform.needSuperhero;    // the day reads the same two
        attribute :>> cityInTrouble = heroTransform.cityInTrouble;    // attributes the requirement assumes
      }
    }

    // newsletter graphic: Bob's timeline, the requirement, the use cases
    view timesliceView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose S3_08_HeroTimeslice::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::OccurrenceUsage
          | hastype SysML::RequirementDefinition | hastype SysML::RequirementUsage
          | hastype SysML::SatisfyRequirementUsage | hastype SysML::UseCaseDefinition
          | hastype SysML::UseCaseUsage | hastype SysML::VerificationCaseDefinition
          | hastype SysML::ConcernDefinition | hastype SysML::ActionDefinition;
      filter not KerML::Element::isLibraryElement;
    }

    // the day as an action flow: start -> relax -> decide -> measure -> decide -> rescue | backup -> terminate
    view bobsDayFlow : DS_Views::SymbolicViews::gv {
      render Views::asInterconnectionDiagram;
      expose S3_08_HeroTimeslice::BobsDay::**;
      filter hastype SysML::ActionUsage | hastype SysML::DecisionNode | hastype SysML::IncludeUseCaseUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }
}
