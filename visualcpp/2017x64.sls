vcpp2017x64-test:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2017\test_x64.ps1
    - template: jinja
    - source: salt://visualcpp/templates/test.ps1.jinja
    - makedirs: True
    - context:
      test: 2017  x64
      arch: x64

vcpp2017x64-packages:
  file.managed:
    - name: c:\alkivi\packages\visualcpp2017\vcredist_x64.exe
    - source: https://aka.ms/vs/15/release/VC_redist.x64.exe
    - source_hash: sha256=52dcfaf0c7cf62c333e12457339a581ac369e06576f93ded45ac002a1b3621fb
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2017\test_x64.ps1
    - require: 
      - file: vcpp2017x64-test
    
vcpp2017x64-install:
  cmd.run:
    - name: ./vcredist_x64.exe /q /norestart
    - cwd: c:\alkivi\packages\visualcpp2017\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\visualcpp2017\test_x64.ps1
    - require: 
      - file: vcpp2017x64-test
      - file: vcpp2017x64-packages
