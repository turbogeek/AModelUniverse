/*
 * SysML v2 SPACE & TIME cheat-sheet example (sheet 16).
 * Bob lands a tall lunar lander: center of gravity from masses and heights, static tip-over angle from
 * leg count and span, the lander placed in the site frame by a Rotation, a timeslice and two snapshots.
 * Lander numbers are illustrative (Starship-class: 50 m tall, 9 m wide), not vendor data.
 * Clauses: [S] 9.7.2 SpatialItems, 9.7.3 ShapeItems, 9.8.3 MeasurementReferences, 9.8.4 ISQ, 9.8.8 Time, 7.9.3.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobOnTheMoon {
  private import ISQ::*;
  private import SI::*;
  private import MeasurementReferences::*;
  private import SpatialItems::*;
  private import ShapeItems::*;
  private import Time::*;
  private import QuantityCalculations::*;  // sum
  private import TrigFunctions::*;  // cos, arctan, deg, pi
  private import ScalarValues::Natural;
  // SI::tonne says 1 tonne = 0.001 kg: make our own t
  attribute <t> ton : MassUnit {
    :>> unitConversion : ConversionByConvention {
      :>> referenceUnit = kg; :>> conversionFactor = 1000; } }
  item def Load {           // one lump of mass
    attribute mass : MassValue;
    attribute z : LengthValue;  // its height above the feet
  }
  calc def CenterOfGravity {
    in loads : Load[1..*];
    return zCG : LengthValue =
      sum(loads.{in l : Load; l.mass * l.z}) / sum(loads.mass);
  }
  calc def MaxSlope {       // static tip-over angle
    in n : Natural; in span : LengthValue; in zCG : LengthValue;
    // nearest tipping edge: span/2 * cos(pi/n)
    return tilt : PlaneAngleValue =
      deg(arctan(span.num / 2 * cos(pi / n) / zCG.num)) ['°'];
  }
  part def Lander :> SpatialItem {
    item :>> shape : RightCircularCylinder {
      :>> radius = 4.5 [m]; :>> height = 50 [m]; }
    attribute legCount : Natural;
    attribute legSpan : LengthValue;   // foot to foot
    item dry  : Load { :>> mass = 120 [t]; :>> z = 20 [m]; }
    item fuel : Load { :>> z = 12 [m]; }  // tanks: low
    item beer : Load { :>> z = 38 [m]; }  // cargo: high
    item bob  : Load { :>> mass = 0.09 [t]; :>> z = 40 [m]; }
    attribute zCG : LengthValue =
      CenterOfGravity((dry, fuel, beer, bob));
    attribute maxSlope : PlaneAngleValue =
      MaxSlope(legCount, legSpan, zCG);
  }
  item moonSite : SpatialItem {    // its z = local vertical
    attribute slope : PlaneAngleValue = 10 ['°'];
    part starship : Lander :> componentParts {
      :>> legCount = 4; :>> legSpan = 12 [m];
      :>> beer { :>> mass = 10 [t]; }
      // its frame: the site's frame, turned by the slope
      attribute :>> coordinateFrame {
        :>> transformation : TranslationRotationSequence {
          :>> source = moonSite.coordinateFrame;
          :>> elements = new Rotation((1, 0, 0)[source], slope);
      } }
      // time: a slice of its life, and two instants
      timeslice part onTheMoon : Lander;
      snapshot part touchdown : Lander {
        :>> fuel { :>> mass = 200 [t]; } }
      snapshot part liftoff : Lander {
        :>> fuel { :>> mass = 50 [t]; } }
    }
    attribute touchdownAt : Iso8601DateTime {
      :>> val = "2029-07-20T20:17:40Z"; }
    assert constraint staysUp { slope <= starship.maxSlope }
  }

  // view (not on the sheet): the loads, the two calcs, the lander, the site, its time slice and snapshots
  view landingView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobOnTheMoon::**;
    filter hastype SysML::AttributeUsage | hastype SysML::ItemDefinition | hastype SysML::CalculationDefinition
        | hastype SysML::PartDefinition | hastype SysML::PartUsage | hastype SysML::ItemUsage
        | hastype SysML::OccurrenceUsage | hastype SysML::AssertConstraintUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
