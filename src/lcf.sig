(* This signature should implemented by the logic in order to use this
 * library's machinery. It requires them to specify the structure of
 * goals as well as what counts as evidence that a goal is proven.
 *
 * The tactics library is completely agnostic to how the underlying goals
 * and evidence are structured.
 *)
signature LCF =
sig
  type goal

  (* The type of evidence (justification) that we've succeeded
   * in proving a goal
   *)
  type evidence

  (* A validation is the proof a tactic returns of its correctness
   * It maps the evidence of the subgoals the theorem produced and
   * gives back evidence for the original goal it was working on.
   *)
  type validation = evidence list -> evidence

  (* A tactic maps a goal to a list of subgoals and a validation. The
   * outputs are supposed to cohere in that the evidence generated by
   * proving the subgoals can be fed to the validation to produce
   * evidence for the input goal
   *)
  type tactic = goal -> goal list * validation
end

(* If goals have an apartness relation, then we may express
 * the notion of "progress".
 *)
signature LCF_APART =
sig
  include LCF

  (* goalApart should return true if two goals are different.
   * The exact meaning of different is left up to the implementer
   * of this signature.
   *)
  val goalApart : goal * goal -> bool
end
