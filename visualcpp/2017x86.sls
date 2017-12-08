vcpp2017x86-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2017\test_x86.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2017  x86
      arch: x86

vcpp2017x86-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2017\vcredist_x86.exe
    - source: https://aka.ms/vs/15/release/VC_redist.x86.exe
    - source_hash: sha256=e7d34f0a9d37d7221adc911bd49b316de68a75f3bfa910e2550849ad13d0573f
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2017\test_x86.ps1
    - require: 
      - file: vcpp2017x86-test
    
vcpp2017x86-install:
  cmd.run:
    - name: ./vcredist_x86.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2017\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2017\test_x86.ps1
    - require: 
      - file: vcpp2017x86-test
      - file: vcpp2017x86-packages
