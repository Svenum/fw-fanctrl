{ lib
, python312Packages
, fetchFromGitHub
, python3
}:

python312Packages.buildPythonPackage rec {
  pname = "fw-fanctrl-gui";
  version = "26-08-2024";

  src = fetchFromGitHub {
    owner = "leopoldhub";
    repo = "fw-fanctrl-gui";
    rev = "8109ad9f107e575f16982930fa1ef7e978a2d2e1";
    hash = "sha256-bFygRjM8RBI8prTZ2feHEYBfJoQXwQj1aOddVzrOHLc=";
  };

  buildInputs = with python312Packages; [
    setuptools
    python3
  ];

  propagatedBuildInputs = with python312Packages; [
    pystray
    pyside6
  ];

  preBuild = ''
    substituteInPlace setup.py --replace 'packages=["src"]' 'packages=["src", "src.app", "src.service", "src.exception"]'
  '';

  postInstall = ''
    cp -r $src/resources $out/lib/python3.12/site-packages/
  '';

  doCheck = false;

  meta = with lib; {
    mainProgram = "fw-fanctrl-gui";
    homepage = "https://github.com/leopoldhub/fw-fanctrl-gui";
    description = "simple pyside Qt6 python gui with system tray to control Framework laptops fans with fw-fanctrl";
    platforms = with platforms; linux;
    license = licenses.bsd3;
    maintainers = with maintainers; [ "Svenum" ];
  };
}
