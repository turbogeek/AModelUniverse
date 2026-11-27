/*
 * SysML v2 ACTIONS cheat-sheet example (sheet 6).
 * Bob and SuperBob play pickleball, first to 11 (win-by-2 left out). court performs game; each player
 * performs his share of it (swimlanes). Warm-up is a fork/join of a for loop and a while loop; each rally
 * is send/accept, a decide, an assign, and a merge back to rally until someone reaches the target.
 * Clauses: [S] SysML v2.1 Beta 2 7.17 (Actions): 7.17.2 to 7.17.12; graphical 8.2.3.17.
 *
 * From "A Model Universe: Cheat Sheets for SysML v2 and the stories behind them"
 * by Daniel Brookshier. https://github.com/turbogeek/AModelUniverse
 * License: CC BY-NC-SA 4.0 (https://creativecommons.org/licenses/by-nc-sa/4.0/)
 */
package BobsPickleball {
  private import ScalarValues::*;
  item def Ball { attribute high : Boolean; }
  part def Player;
  action def Game {
    in attribute target : Integer;
    attribute bobPts : Integer := 0;
    attribute sbPts : Integer := 0;
    attribute laps : Integer := 0;
    first start;
    then fork warmUp;
      then stretch;
      then flyLaps;
    action stretch for i : Integer in 1..3 {
      action touchToes;
    }
    then ready;
    action flyLaps while laps < 3 {
      assign laps := laps + 1;
    }
    then ready;
    join ready;
    then merge rally;
    then action serve
      send new Ball() to court.superBob;
    then action receive
      accept ball : Ball via court.superBob;
    then decide shot;
      if receive.ball.high then smash;
      else dink;
    action smash;
    then action sbScores assign sbPts := sbPts + 1;
    then point;
    action dink;
    then action bobScores assign bobPts := bobPts + 1;
    then point;
    merge point;
    then decide;
      if bobPts >= target or sbPts >= target
        then celebrate;
      else rally;
    action celebrate if bobPts > sbPts {
      action bobDance;
    } else {
      action superFlyby;
    }
    then done;
  }
  action game : Game { in :>> target = 11; }
  part court {
    perform game {
      view swimlanes : DS_Views::SymbolicViews::afv {
        expose court::**;
        filter hastype SysML::PartUsage | @KerML::Step
          | @KerML::Succession;
        filter not KerML::Element::isLibraryElement;
      }
    }
    part bob : Player {
      perform game.stretch; perform game.serve;
      perform game.dink; perform game.bobScores;
    }
    part superBob : Player {
      perform game.flyLaps; perform game.receive;
      perform game.smash; perform game.sbScores;
      perform game.celebrate;
    }
  }

  // view (not on the sheet): the ACTION DEF / ACTION / PERFORM card: Game, game, court and the players
  view gameStructure : DS_Views::SymbolicViews::gv {
    render Views::asTreeDiagram;
    expose BobsPickleball::**;
    filter hastype SysML::ActionDefinition | hastype SysML::ActionUsage | hastype SysML::PartDefinition
        | hastype SysML::PartUsage | hastype SysML::ItemDefinition | hastype SysML::PerformActionUsage;
    filter not KerML::Element::isLibraryElement;
  }
  // view (not on the sheet): the swimlane flow: every action node and succession of Game, no attributes
  view gameFlow : DS_Views::SymbolicViews::afv {
    render Views::asInterconnectionDiagram;
    expose BobsPickleball::Game::**;
    filter @SysML::ActionUsage | @SysML::SuccessionAsUsage | @KerML::Step
        | @KerML::Succession;
    filter not KerML::Element::isLibraryElement;
  }
}
