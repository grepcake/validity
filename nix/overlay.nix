final:
  previous:
    with final.haskell.lib;
    {
      validityPackages =
            let validityPkg = name:
                doBenchmark (failOnAllWarnings (final.haskellPackages.callCabal2nix name (final.gitignoreSource (../. + "/${name}")) {}));
            in final.lib.genAttrs [
              "genvalidity"
              "genvalidity-aeson"
              "genvalidity-bytestring"
              "genvalidity-containers"
              "genvalidity-criterion"
              "genvalidity-hspec"
              "genvalidity-hspec-aeson"
              "genvalidity-hspec-binary"
              "genvalidity-hspec-cereal"
              "genvalidity-hspec-hashable"
              "genvalidity-hspec-optics"
              "genvalidity-hspec-persistent"
              "genvalidity-path"
              "genvalidity-property"
              "genvalidity-scientific"
              "genvalidity-text"
              "genvalidity-time"
              "genvalidity-unordered-containers"
              "genvalidity-uuid"
              "genvalidity-vector"
              "validity"
              "validity-aeson"
              "validity-bytestring"
              "validity-containers"
              "validity-path"
              "validity-primitive"
              "validity-scientific"
              "validity-text"
              "validity-time"
              "validity-unordered-containers"
              "validity-uuid"
              "validity-vector"
            ] validityPkg;

      haskellPackages = previous.haskellPackages.override (old: {
        overrides = final.lib.composeExtensions (old.overrides or (_: _: {})) (
          self: super: final.validityPackages
        );
      });
    }
