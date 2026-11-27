/*
 * Sheet 9, Expressions: EXAMPLE SUBMISSION (shows the format; not a challenge answer)
 * Idea: count the strong beers in Bob's fridge and pick the strongest cold one,
 *       so Bob can make a fully model-based beverage decision.
 * Author: example-contributor (GitHub)
 * Submitted under CONTRIBUTING.md: may be used, with credit, in A Model Universe books,
 * newsletters and merchandise; otherwise shared under CC BY-NC-SA 4.0.
 */
package StrongBeers {
  private import ScalarValues::*;
  private import SequenceFunctions::*;  // size
  private import ControlFunctions::*;   // select via .?{ }, reduce
  item def Beer {
    attribute abv : Real;   // percent
    attribute temp : Real;  // deg C
    attribute cold : Boolean = temp < 5.0;
  }
  part def Fridge { item beers : Beer[0..*] ordered; }
  part bobsFridge : Fridge {
    // beers over 6 percent: select, then count
    attribute countStrong : Natural = size(beers.?{in b : Beer; b.abv > 6.0});
    // strongest of the cold ones: navigate to every abv, then fold with max
    attribute strongestCold : Real[0..1] =
      beers.?{in b : Beer; b.cold}.abv -> reduce RealFunctions::max;
  }
}
