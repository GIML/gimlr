# gimlr

Ruby parser for GIML.

## Benchmarks

Small files (which in test folder):

```
Calculating -------------------------------------
               gimlr     1.487k i/100ms
                yaml   541.000  i/100ms
-------------------------------------------------
               gimlr     15.244k (± 3.7%) i/s -    153.161k
                yaml      5.777k (± 5.1%) i/s -     57.887k

Comparison:
               gimlr:    15244.1 i/s
                yaml:     5776.5 i/s - 2.64x slower
```

Big files (~43k lines - just replicated data with same structure as test/test_files)

```
Calculating -------------------------------------
               gimlr     1.000  i/100ms
                yaml     1.000  i/100ms
-------------------------------------------------
               gimlr     17.822  (±11.2%) i/s -    883.000
                yaml      3.536  (± 0.0%) i/s -    177.000

Comparison:
               gimlr:       17.8 i/s
                yaml:        3.5 i/s - 5.04x slower
```
