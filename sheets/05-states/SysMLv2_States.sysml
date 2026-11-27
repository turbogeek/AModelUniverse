/*
 * SysML v2 STATES cheat-sheet example (sheet 5).
 * Bob exhibits the state "modes": normal (chilling/drinking) and super, a parallel state whose regions
 * flight, eyes and fists hold the powers, so Bob can fly, zap and punch only while super.
 * Clauses: [S] SysML v2.1 Beta 2 7.18 (States), 7.17.8 (accept), 7.17.9 (assign), 7.17.10 (terminate).
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobStates {
  private import ScalarValues::Real;
  private import ScalarValues::Integer;
  private import SI::s; private import SI::h;
  item def Beer; item def Empty;
  item def HeroCall; item def AllClear;
  item def TakeOff; item def Land;
  item def Threat; item def Villain;
  item def Retire; item def BlueScreen;
  part def Bob {
    attribute bac : Real default 0.0; // Bob: 135 lb
    attribute strength : Integer default 83; // percent
    exhibit state modes {
      entry; then normal;
      state normal {
        entry; then chilling;
        state chilling;
        accept Beer then drinking;
        accept after 1 [h] if bac >= 0.015
          do assign bac := bac - 0.015
          then chilling;
        state drinking {
          entry assign bac := bac + 0.02;
        }
        accept Empty then chilling;
      }
      accept HeroCall if bac < 0.08 then super;
      state super parallel {
        entry assign strength := 2043;
        do action glow;
        exit assign strength := 83;
        state flight {
          entry; then grounded;
          state grounded;
          accept TakeOff then flying;
          state flying;
          accept Land then grounded;
        }
        state eyes {
          entry; then plain;
          state plain;
          accept Threat then laser;
          state laser { do action zap; }
          accept after 2 [s] then plain;
        }
        state fists {
          entry; then ready;
          state ready;
          accept Villain if strength > 100
            then punch;
          state punch;
          accept after 1 [s] then ready;
        }
      }
      accept AllClear then normal;
      accept Retire then done;
      accept BlueScreen then crash;
      action crash terminate;
      view modesView : DS_Views::SymbolicViews::stv {
        expose modes::**;
        filter @SysML::ActionUsage | @KerML::Step
          | @SysML::TransitionUsage | @KerML::Succession;
        filter not KerML::Element::isLibraryElement;
      }
    }
  }

  // view (not on the sheet): Bob, his attributes, the signals and the exhibited state
  view bobStructure : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobStates::**;
    filter hastype SysML::PartDefinition | hastype SysML::ItemDefinition | hastype SysML::AttributeUsage
        | hastype SysML::ExhibitStateUsage;
    filter not KerML::Element::isLibraryElement;
  }
}
