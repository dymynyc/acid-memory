(module
  ;; completely naive memory mismanagement,
  ;; allocate memory but never reclaim it.
  (export alloc {fun (size) [block
    ;;start of free memory stored in free global
    (def free (i32_load 0))
    ;; never alloc data at 0, because it looks like a null pointer.
    (if (eq 0 free) (set free 4) 0)
    ;;move it forward, by the amount requested
    ;;also store at memory location 0
    (def _free (add free size))
    (i32_store 0 _free)
    (set_global 0 _free)
    ;;return the old position
    free
  ]})
  ;;do nothing!
  (export free {fun (ptr) 0})
)
