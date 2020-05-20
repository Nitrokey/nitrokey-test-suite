Feature: Generate RSA key
  Device should support key generation

  Scenario: Smartcard should be visible by GnuPG
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When fail if will see '.*No such device' in 2 seconds
     And wait for 'PROMPT'
     And 'admin' -> '.*Admin commands are allowed.*'
#    TODO check listed information
     And ' ' -> 'PROMPT'
     And send 'exit'
    Then finish with success


  Scenario: Factory reset should be possible
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When fail if will see '.*No such device' in 2 seconds
     And wait for 'PROMPT'
     And 'admin' -> '.*Admin commands are allowed.*'
     And 'factory-reset' -> '.*Continue?.*'
     And 'y' -> '.*Really.*'
     And 'yes' -> 'PROMPT'
     And ' ' -> 'PROMPT'
     And send 'exit'
    Then finish with success

  Scenario: Generate ECC key Curve
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When fail if will see '.*No such device' in 2 seconds
     And wait for 'PROMPT'
     And 'admin' results in '.*Admin commands are allowed.*'
     And send 'key-attr'
     And (optional) on 'Replace existing keys' say 'y'
     And (optional) on 'Please enter the PIN' say '123456'
     And (optional) on 'Please enter the Admin PIN' say '12345678'
     And (optional) on '^Admin PIN:' say '12345678'
     And (optional) on 'PIN:' say '123456'
     And on 'Changing card key attribute for: Signature key' say '2'
     And on 'Please select which elliptic curve you want' say '1'
     And on 'Changing card key attribute for: Encryption key' say '2'
     And on 'Please select which elliptic curve you want' say '1'
     And on 'Changing card key attribute for: Authentication key' say '2'
     And on 'Please select which elliptic curve you want' say '1'
     And send 'generate'
     And on 'Make off-card backup of encryption key?.*' say 'N'
     And (optional) on 'Key is valid for?' say '2'
     And on 'Is this correct' say 'y'
     And on 'Real name' say 'Test Suite ECC'
     And on 'Email address' say 'test-suite-ECC@example.com'
     And on 'Comment' say 'Key generation session ECC '
     And on 'Change' say 'O'
     And fail if will see 'gpg: key generation failed: Card error' in 5 seconds
     And wait for 'PROMPT'
     And send 'exit'
    Then finish with success

  Scenario: Generate RSA key 2k
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When fail if will see '.*No such device' in 2 seconds
     And wait for 'PROMPT'
     And 'admin' results in '.*Admin commands are allowed.*'
     And send 'generate'
     And fail if will see '.*No such device' in 2 seconds
     And on 'Make off-card backup of encryption key?.*' say 'N'
     And (optional) on 'Replace existing keys' say 'y'
     And (optional) on 'Please enter the PIN' say '123456'
     And (optional) on 'Please enter the Admin PIN' say '12345678'
     And (optional) on '^Admin PIN:' say '12345678'
     And (optional) on 'PIN:' say '123456'
     And (optional) on 'Key is valid for?' say '2'
     And (optional) on '.*Signature key.*' say '2048'
     And (optional) on '.*Encryption key.*' say '2048'
     And (optional) on '.*Authentication key.*' say '2048'
     And on 'Is this correct' say 'y'
     And on 'Real name' say 'Test Suite 2048'
     And on 'Email address' say 'test-suite-2048@example.com'
     And on 'Comment' say 'Key generation session RSA 2048'
     And on 'Change' say 'O'
     # And (optional) on 'Please enter the Admin PIN.*Admin PIN:' say '12345678'
     And fail if will see 'gpg: key generation failed: Card error' in 60 seconds
     And wait for 'PROMPT'
     And send 'exit'
    Then finish with success


  Scenario: Generate RSA key 4k
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When fail if will see '.*No such device' in 2 seconds
     And wait for 'PROMPT'
     And 'admin' results in '.*Admin commands are allowed.*'
     And send 'generate'
     And fail if will see '.*No such device' in 2 seconds
     And on 'Make off-card backup of encryption key?.*' say 'N'
     And (optional) on 'Replace existing keys' say 'y'
     And (optional) on 'Please enter the PIN' say '123456'
     And (optional) on 'Please enter the Admin PIN' say '12345678'
     And (optional) on '^Admin PIN:' say '12345678'
     And (optional) on 'PIN:' say '123456'
     And (optional) on 'Key is valid for?' say '2'
     And (optional) on '.*Signature key.*' say '4096'
     And (optional) on '.*Encryption key.*' say '4096'
     And (optional) on '.*Authentication key.*' say '4096'
     And on 'Is this correct' say 'y'
     And on 'Real name' say 'Test Suite 4096'
     And on 'Email address' say 'test-suite-4096@example.com'
     And on 'Comment' say 'Key generation session RSA 4096'
     And on 'Change' say 'O'
     # And (optional) on 'Please enter the Admin PIN.*Admin PIN:' say '12345678'
     And fail if will see 'gpg: key generation failed: Card error' in 600 seconds
     And wait for 'PROMPT'
     And send 'exit'
    Then finish with success


