# GitHub 업로드

1. GitHub에서 공개 저장소를 만드세요. 권장 이름은 `dot-pet`입니다. 기본 브랜치는 `main`을 사용합니다.
2. ZIP을 풀고 `dot-pet` 폴더의 **내용물**을 저장소 루트에 올리세요. `install.sh`와 `README.md`가 저장소 첫 화면에서 보여야 합니다.
3. 업로드 전 아래 명령의 `OWNER/REPO`를 실제 주소로 바꾸어 실행하세요. README의 설치 주소가 자동 설정됩니다.

```bash
bash scripts/configure-repository.sh OWNER/REPO
```

명령을 사용하지 않으려면 `README.md`의 모든 `OWNER/REPO`를 직접 바꾸어도 됩니다. 변경한 README도 GitHub에 올리세요.

Git을 사용한다면 ZIP을 푼 폴더에서 다음 순서로 실행합니다. `OWNER/REPO`는 실제 GitHub 계정과 저장소로 바꾸세요.

```bash
git init -b main
git add .
git commit -m "Add Dot Pet for Codex"
git remote add origin https://github.com/OWNER/REPO.git
git push -u origin main
```

GitHub 웹의 **Add file → Upload files**로 올려도 됩니다. 이미 파일이 있는 저장소라면 기존 작업에 맞추어 업로드하고, 위 초기화 명령을 그대로 적용하지 마세요.

공개된 README의 설치 명령을 새 환경에서 실행해 최종 배포를 확인하세요. 로컬 설치 검사와 GitHub 공개 URL 검사는 별개입니다. 이 패키지 제작 단계에서는 아직 존재하지 않는 공개 URL에 대한 설치 성공을 보장하지 않습니다.
