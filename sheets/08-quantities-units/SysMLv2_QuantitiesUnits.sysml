/*
 * SysML v2 QUANTITIES & UNITS cheat-sheet example (sheet 8).
 * Extending the SI library: prefixed units (Mkm, ks), units by convention (au, parsec, car, elephant, blue whale),
 * an ordinal scale (toastiness) and a non-linear scale computed by a calc (warp factor, v = c * w^(10/3)).
 * Clauses: [S] 9.8.1 to 9.8.5 (Quantities and Units Domain Library), 7.7 Attributes, 7.19 Calculations.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package SuperBobsUnits {
  private import ScalarValues::*;
  private import Quantities::*;
  private import MeasurementReferences::*;
  private import SI::*;  // units + ISQ + prefixes
  // scale it: a prefix on a unit
  attribute <Mkm> megakilometre : LengthUnit {
    :>> unitConversion : ConversionByPrefix {
      :>> prefix = mega; :>> referenceUnit = km; } }
  attribute <ks> kilosecond : DurationUnit {
    :>> unitConversion : ConversionByPrefix {
      :>> prefix = kilo; :>> referenceUnit = s; } }
  // by convention: a factor to a reference unit
  attribute <au> astronomicalUnit : LengthUnit {
    :>> unitConversion : ConversionByConvention {
      :>> referenceUnit = m;
      :>> conversionFactor = 149597870700; } }
  attribute <pc> parsec : LengthUnit {
    :>> unitConversion : ConversionByConvention {
      :>> referenceUnit = au;
      :>> conversionFactor = 206264.806;
      :>> isExact = false; } }
  attribute car : MassUnit {  // moderately priced
    :>> unitConversion : ConversionByConvention {
      :>> referenceUnit = kg; :>> conversionFactor = 1500;
      :>> isExact = false; } }
  attribute elephant : MassUnit {
    :>> unitConversion : ConversionByConvention {
      :>> referenceUnit = kg; :>> conversionFactor = 6000;
      :>> isExact = false; } }
  attribute <whale> blueWhale : MassUnit {
    :>> unitConversion : ConversionByConvention {
      :>> referenceUnit = kg; :>> conversionFactor = 150000;
      :>> isExact = false; } }
  // toastiness is ordinal: a scale, not a unit
  attribute <shade> toastShade : OrdinalScale { :>> unit = one; }
  attribute def ToastinessValue :> ScalarQuantityValue {
    attribute :>> num : Integer;
    attribute :>> mRef : OrdinalScale;
  }
  // warp factor is not linear: use a calc
  calc def WarpSpeed {
    in w : Real;
    return v : SpeedValue = 299792458 [m/s] * w ** (10.0 / 3.0);
  }
  part def Breakfast { attribute toastiness : ToastinessValue; }
  part superBob {
    attribute lift :> ISQ::mass = 3 [elephant];
    attribute record :> ISQ::mass = 0.5 [whale];
    attribute commute :> ISQ::length = 1.5 [au];
    attribute hop :> ISQ::length = 57.9 [Mkm];
    attribute flight :> ISQ::duration = 7.2 [ks];
    attribute cruise : SpeedValue = WarpSpeed(9.0);
  }
  part bob {
    part breakfast : Breakfast { :>> toastiness = 9 [shade]; }
  }

  // view (not on the sheet): the new units, the toast scale, the warp calc and SuperBob's values
  view unitsView : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose SuperBobsUnits::**;
    filter hastype SysML::AttributeUsage | hastype SysML::AttributeDefinition | hastype SysML::CalculationDefinition
        | hastype SysML::PartDefinition | hastype SysML::PartUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
