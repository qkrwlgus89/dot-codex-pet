# 닷 펫 · Dot Pet

체크리스트를 들고 곁에서 함께 일하는 보라색 코덱스 펫입니다. 머리 위 동그란 점, 배의 세 점, 둥근 몸체를 담았습니다.

![닷 펫 미리보기](docs/idle.gif)

ZIP을 푼 뒤 `preview.html`을 더블클릭하면 9개 동작과 16방향 시선을 미리 볼 수 있습니다.

## 한 줄 설치

커스텀 펫 v2를 지원하는 Codex 데스크톱 앱이 필요합니다. 설치 스크립트는 펫 파일을 배치합니다. 앱을 다시 시작한 뒤 펫 선택 화면에서 **닷 펫**을 선택하세요. 앱 버전에 따라 메뉴와 지원 여부가 다를 수 있습니다.

### macOS · Bash

아래 명령 전체를 터미널에 붙여 넣으세요. GitHub의 설치 스크립트를 다운로드하여 실행합니다.

```bash
curl -fsSL https://raw.githubusercontent.com/OWNER/REPO/main/install.sh | bash -s -- OWNER/REPO
```

### Windows · PowerShell

```powershell
& ([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/OWNER/REPO/main/install.ps1').Content)) -Repository 'OWNER/REPO'
```

공개 저장소의 `main` 브랜치를 기준으로 합니다. 비공개 저장소는 ZIP 또는 로컬 설치를 사용하세요. 릴리스 태그로 고정하려면 URL의 `main`을 해당 태그로 바꾸고 Bash에는 두 번째 인수, PowerShell에는 `-Ref`로 같은 태그를 전달하세요.

## ZIP으로 설치

ZIP을 풀고 저장소 폴더 안에서 실행합니다.

```bash
bash install.sh
```

Windows에서는 해당 폴더를 열어 PowerShell에서 `powershell -NoProfile -ExecutionPolicy Bypass -File .\install.ps1`을 실행합니다. 이 실행 정책 옵션은 해당 프로세스에만 적용됩니다.

수동 설치는 `pets/dot-pet` 폴더를 `~/.codex/pets/dot-pet`에 복사하면 됩니다. Windows 기본 경로는 `%USERPROFILE%\.codex\pets\dot-pet`입니다. `CODEX_HOME`을 별도로 설정했다면 그 경로 아래 `pets/dot-pet`에 설치됩니다.

기존 설치는 `dot-pet.backup.*` 폴더로 보관합니다. 제거할 때는 설치된 `dot-pet` 폴더만 삭제하고 앱을 다시 시작하세요. 백업이 필요 없으면 백업 폴더도 직접 삭제할 수 있습니다.

## 들어 있는 동작

| 동작 | 표현 |
|---|---|
| 기본 | 숨쉬기·눈 깜빡임 |
| 좌우 이동 | 좌우로 달리기 |
| 인사 | 손 흔들기 |
| 점프 | 준비·도약·착지 |
| 실패 | 시무룩한 반응 |
| 입력 대기 | 사용자를 기다리는 표정 |
| 작업 중 | 체크리스트를 다루며 집중 |
| 검토 | 체크리스트 확인 |
| 시선 | 마우스 방향을 바라보는 16방향 |

## 파일 구성

```text
pets/dot-pet/pet.json           펫 설정
pets/dot-pet/spritesheet.webp   투명 애니메이션 시트
pets/dot-pet/SHA256SUMS         다운로드 무결성 확인
install.sh                     macOS/Bash 설치
install.ps1                    Windows 설치
docs/                          미리보기·검수 정보·업로드 안내
```

시트 규격은 v2, 1536×2288px, 8열×11행, 셀당 192×208px입니다. 기본 동작 57프레임과 16방향 시선, 총 73프레임입니다. 사용하지 않는 셀은 투명합니다.

## GitHub에 처음 올리는 사람

[업로드 안내](docs/PUBLISH.md)를 참고하세요. 이 README의 `OWNER/REPO`를 실제 공개 저장소 주소로 한 번 설정하면 방문자가 위 명령으로 설치할 수 있습니다.

## 권리 및 제작

닷 캐릭터 원본은 사용자가 제공한 자료를 기반으로 합니다. 캐릭터·브랜드에 대한 권리를 새로 부여하는 오픈소스 라이선스는 포함하지 않았습니다. 설치·개인 사용 목적의 배포이며, 캐릭터의 재배포·변형·상업 이용 조건은 저장소 운영자에게 확인하세요. OpenAI 공식 배포 펫은 아닙니다.

애니메이션 제작에는 내장 ImageGen을 사용했고, 시트 조립·투명화·규격 검증은 hatch-pet 도구로 처리했습니다. 세부 검수 범위는 [검수 기록](docs/VALIDATION.md)을 참고하세요.
