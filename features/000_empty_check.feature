Feature: Generate RSA key
  Device should support key generation

  Scenario: Smartcard should be visible by GnuPG
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When wait for 'PROMPT'
     And 'admin' -> '.*Admin commands are allowed.*'
#    TODO check listed information
     And ' ' -> 'PROMPT'
     And send 'exit'
    Then finish with success



  Scenario: Generate RSA key 2k
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When wait for 'PROMPT'
     And 'admin' results in '.*Admin commands are allowed.*'
     And send 'generate'
     And on 'Make off-card backup of encryption key?.*' say 'N'
     And (optional) on 'Please enter the PIN' say '123456'
     And (optional) on 'Please enter the Admin PIN' say '12345678'
     And on '.*Signature key.*' say '2048'
     And on '.*Encryption key.*' say '2048'
     And on '.*Authentication key.*' say '2048'
     And on 'valid for?' say '2'
     And on 'Key expires at.*Is this correct' say 'y'
     And on 'Real name' say 'asdasd'
     And on 'Email address' say 'asd@asd.com'
     And on 'Comment' say 'aaaa'
     And on 'Change' say 'O'
     And (optional) on 'Please enter the Admin PIN.*Admin PIN:' say '12345678'
     And fail if will see 'gpg: key generation failed: Card error' in 300 seconds
     And wait for 'PROMPT'
     And send 'exit'
    Then finish with success


    Scenario: Factory reset should be possible
     Given Run 'gpg --card-edit'
     And set 'PROMPT' to 'gpg/card> '
     When wait for 'PROMPT'
     And 'admin' -> '.*Admin commands are allowed.*'
#     And 'factory-reset' -> '.*Continue?.*'
#     And 'y' -> '.*Really.*'
#     And 'yes' -> 'PROMPT'
     And ' ' -> 'PROMPT'
     And send 'exit'
    Then finish with success
