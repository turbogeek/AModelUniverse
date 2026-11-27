/*
 * SysML v2 VALIDATION PATTERNS cheat-sheet examples (sheet 4), one self-contained package per card.
 * sheet's right (✓) code; the wrong (✗) forms are kept as comments. Each package ends with a view
 * Advanced View Patterns sheet.
 *
 *   V01_FixedVsDefault         FIXED vs DEFAULT             [S] 7.13.1 · 7.17.1
 *   V02_BindSubjectOnce        BIND THE SUBJECT ONCE        [S] 7.21.4
 *   V03_TradeStudy             TRADE STUDY THAT EVALUATES   [S] 7.23.3 · 9.4.5
 *   V04_ImportWhatYouUse       IMPORT WHAT YOU USE          [K] 7.2.5.4
 *   V05_AssumeVsAssert         ASSUME vs ASSERT             [S] 7.21.2 · 7.20.3
 *   V06_TestsOutOfUseCases     TESTS STAY OUT OF USE CASES  [S] 7.24
 *   V07_NoExtend               NO «extend» IN v2            [S] 7.17.5
 *   V08_FlowEnds               FLOW ENDS                    [S] 7.16.2
 *   V09_LookAlikeOperators     LOOK-ALIKE OPERATORS         [K] 7.4.9.2 · Table 5
 *   V10_CrossSubsetEnds        CROSS-SUBSETTING ENDS        [S] 7.13.2
 *
 * Clauses: [S] SysML v2.1 Beta 2, [K] KerML v1.1 Beta 2 (Aug 2026).
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package ValidationPatterns {

  // -------------------------------------------------------------------------------------
  // FIXED vs DEFAULT   [S] 7.13.1 · 7.17.1
  //   CONSTRAINT:  validateFeatureValueOverriding   [K] 8.3.4.10.2
  //   WRONG:  part def Bob { attribute beers = 6; }
  //   WRONG:  part def SuperBob :> Bob {
  //   WRONG:    attribute :>> beers = 0; }
  //   `=` and `:=` are fixed: never redefined
  //   only a `default` value can be redefined
  // -------------------------------------------------------------------------------------
  package V01_FixedVsDefault {
    part def Bob {
      attribute beers default := 6;
      attribute cap = 12;
    }
    part def SuperBob :> Bob {
      attribute :>> beers = 0;
    }

    // view (not on the sheet): Bob, SuperBob and the redefined attribute
    view fixedVsDefaultView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V01_FixedVsDefault::**;
      filter hastype SysML::PartDefinition | hastype SysML::AttributeUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // BIND THE SUBJECT ONCE   [S] 7.21.4
  //   CONSTRAINT:  validateRequirementUsageOnlyOneSubject   [S] 8.3.21.9
  //   WRONG:  satisfy r by bob { subject s = bob; }
  //   `by` already binds the subject
  // -------------------------------------------------------------------------------------
  package V02_BindSubjectOnce {
    private import ScalarValues::*;
    part def Person { attribute bac : Real; }
    part bob : Person { attribute :>> bac = 0.03; }
    requirement def Sober {
      subject s : Person;
      require constraint { s.bac < 0.08 }
    }
    requirement r : Sober;
    satisfy r by bob;

    // view (not on the sheet): the requirement, its usage and the satisfy
    view bindSubjectView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V02_BindSubjectOnce::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::RequirementDefinition
          | hastype SysML::RequirementUsage | hastype SysML::SatisfyRequirementUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // TRADE STUDY THAT EVALUATES   [S] 7.23.3 · 9.4.5
  //   CONSTRAINT:  validateFeatureValueOverriding   [K] 8.3.4.10.2
  //   WRONG:  part def Drink { … = 0.02; }
  //   vary `part` usages that have `default` values
  // -------------------------------------------------------------------------------------
  package V03_TradeStudy {
    private import ScalarValues::*;
    private import TradeStudies::*;
    part drink {
      attribute rise default := 0.02; }
    part beer :> drink {
      attribute :>> rise = 0.017; }
    part rye :> drink {
      attribute :>> rise = 0.027; }
    analysis pick : TradeStudy {
      subject cands :> drink
        = (beer, rye);
      objective : MinimizeObjective {
        subject ; }
      calc :>> evaluationFunction {
        in part x :> cands
          :>> alternative;
        return :>> result = x.rise; }
      return part best
        :>> selectedAlternative :> drink;
    }

    // view (not on the sheet): the alternatives and the study
    view tradeStudyView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V03_TradeStudy::**;
      filter hastype SysML::PartUsage | hastype SysML::AnalysisCaseUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // IMPORT WHAT YOU USE   [K] 7.2.5.4
  //   WRONG:  attribute r : Real;   // no import
  //   library names resolve only by `import`
  //   scope it: import the members you use;
  //   `::*` pulls every visible member in
  // -------------------------------------------------------------------------------------
  package V04_ImportWhatYouUse {
    private import ScalarValues::Real;
    private import ScalarValues::Boolean;
    part def Gauge {
      attribute r : Real;
      attribute ok : Boolean; }
    calc def Judge {
      in g : Gauge;
      return pass : Boolean
        = g.ok and g.r < 0.08; }

    // view (not on the sheet): the gauge and the calculation
    view importView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V04_ImportWhatYouUse::**;
      filter hastype SysML::PartDefinition | hastype SysML::AttributeUsage | hastype SysML::CalculationDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // ASSUME vs ASSERT   [S] 7.21.2 · 7.20.3
  //   CONSTRAINT:  validateRequirementConstraintMembershipOwningType   [S] 8.3.21.7
  //   WRONG:  use case def SaveIt {
  //   WRONG:    assume constraint { hero.super } }
  //   `assume` · `require` : inside requirements
  //   `assert` : must hold, use it anywhere
  // -------------------------------------------------------------------------------------
  package V05_AssumeVsAssert {
    private import ScalarValues::*;
    part def Bob { attribute super : Boolean default = false; }
    part def City;
    requirement def HeroReady {
      subject hero : Bob;
      assume constraint { hero.super }
      require constraint { true }
    }
    use case def SaveCity {
      subject city : City;
      actor hero : Bob;
      assert constraint { hero.super }
    }

    // view (not on the sheet): the requirement (assume) and the use case (assert)
    view assumeAssertView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V05_AssumeVsAssert::**;
      filter hastype SysML::PartDefinition | hastype SysML::RequirementDefinition | hastype SysML::UseCaseDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // TESTS STAY OUT OF USE CASES   [S] 7.24
  //   WRONG:  use case def Night {
  //   WRONG:    verification t : BacTest; }
  //   share the action and the limit
  // -------------------------------------------------------------------------------------
  package V06_TestsOutOfUseCases {
    private import ScalarValues::*;
    private import VerificationCases::*;
    part def Person { attribute bac : Real default = 0.0; }
    requirement def Sober {
      subject s : Person;
      attribute legalLimit : Real default = 0.08;
      require constraint { s.bac < legalLimit }
    }
    requirement sober : Sober;
    action def MeasureBac {
      in operator : Person;
      out reading : Real
        = operator.bac; }
    use case def Day {
      actor hero : Person;
      action measure : MeasureBac {
        in operator = hero; } }
    verification def BacTest {
      subject p : Person;
      objective { verify sober; }
      action measure : MeasureBac {
        in operator = p; }
      return verdict : VerdictKind
        = PassIf(measure.reading
          < sober.legalLimit); }

    // view (not on the sheet): the test kept out of the use case
    view testsView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V06_TestsOutOfUseCases::**;
      filter hastype SysML::PartDefinition | hastype SysML::RequirementDefinition | hastype SysML::RequirementUsage
          | hastype SysML::ActionDefinition | hastype SysML::UseCaseDefinition | hastype SysML::VerificationCaseDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // NO «extend» IN v2   [S] 7.17.5
  //   WRONG:  v1 «extend» has no v2 keyword
  //   the owning context holds the decision
  //   (extension point) and guarded successions
  // -------------------------------------------------------------------------------------
  package V07_NoExtend {
    private import ScalarValues::*;
    part def City;
    part def Bob;
    use case def Rescue;
    use case def Night {
      subject city : City;
      actor hero : Bob;
      attribute crisis : Boolean;
      first start;
      then decide callIn;
        if crisis then rescue;
        else calm;
      include use case rescue : Rescue;
      action calm;
    }

    // view (not on the sheet): the use case flow with decide and include
    view noExtendView : DS_Views::SymbolicViews::afv {
      render Views::asInterconnectionDiagram;
      expose V07_NoExtend::**;
      filter hastype SysML::UseCaseDefinition | @SysML::ActionUsage | @SysML::SuccessionAsUsage
          | @KerML::Step | @KerML::Succession;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // FLOW ENDS   [S] 7.16.2
  //   WRONG:  flow of Fuel from tank.p to eng.q;
  //   end the chain at the `in` / `out` feature
  // -------------------------------------------------------------------------------------
  package V08_FlowEnds {
    item def Fuel;
    part def Tank { port p : FuelPort; }
    part def Eng  { port q : ~FuelPort; }
    port def FuelPort {
      out item fuel : Fuel;
    }
    part def Rig {
      part tank : Tank;
      part eng : Eng;
      connect tank.p to eng.q;
      flow of Fuel
        from tank.p.fuel to eng.q.fuel;
    }

    // view (not on the sheet): the parts, ports, connection and flow
    view flowEndsView : DS_Views::SymbolicViews::iv {
      render Views::asInterconnectionDiagram;
      expose V08_FlowEnds::**;
      filter hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::PortDefinition
          | hastype SysML::PortUsage | hastype SysML::ItemDefinition | @SysML::ConnectorAsUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // LOOK-ALIKE OPERATORS   [K] 7.4.9.2 · Table 5
  //   WRONG:  attribute off = ~on;
  //   `~` is not a v2 operator (only `~Port`)
  //   `not` : logical not
  //   `and` `or` : conditional (2nd only if needed)
  //   `&` `|` : logical (both sides evaluated)
  //   `??` : null coalescing, `(null ?? B)` returns `B`
  // -------------------------------------------------------------------------------------
  package V09_LookAlikeOperators {
    private import ScalarValues::*;
    part def Panel {
      attribute on : Boolean default = true;
      attribute armed : Boolean default = false;
      attribute maybe : Real [0..1];
      attribute off = not on;
      attribute both = on and armed;
      attribute bothL = on & armed;
      attribute r = maybe ?? 0.0;
    }

    // view (not on the sheet): the panel and its Boolean attributes
    view operatorsView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V09_LookAlikeOperators::**;
      filter hastype SysML::PartDefinition | hastype SysML::AttributeUsage;
      filter not KerML::Element::isLibraryElement;
    }
  }

  // -------------------------------------------------------------------------------------
  // CROSS-SUBSETTING ENDS   [S] 7.13.2
  //   CONSTRAINT:  validateFeatureEndMultiplicity   [K] 8.3.3.3.4
  //   same meaning, shorthand (cross features implied):
  //   the end itself is always `[1]`; `[ ]` is the cross multiplicity
  // -------------------------------------------------------------------------------------
  package V10_CrossSubsetEnds {
    part def Bob { ref part bugs : Bug [*]; }
    part def Bug { ref part victims : Bob [1..*]; }
    connection def Bite {
      end bug : Bug crosses bob.bugs;
      end bob : Bob => bug.victims; }
    connection def BiteShort {
      end [*] bug : Bug;  end [1..*] bob : Bob; }

    // view (not on the sheet): the connection definitions and their ends
    view crossSubsetView : DS_Views::SymbolicViews::gv {
      render Views::asTreeDiagram;
      expose V10_CrossSubsetEnds::**;
      filter hastype SysML::PartDefinition | hastype SysML::ReferenceUsage | hastype SysML::PartUsage
          | hastype SysML::ConnectionDefinition;
      filter not KerML::Element::isLibraryElement;
    }
  }

}
