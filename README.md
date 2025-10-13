# 천지인 한글 입력기 (Chunjiin Korean Input Method)

C언어와 GTK3로 구현한 천지인 한글 입력 방식 애플리케이션입니다.

## 소개

천지인(天地人) 입력 방식은 한글의 창제 원리를 따라 만들어진 휴대폰 키패드 입력 방식입니다.
이 프로그램은 원래 Java/Android로 작성된 코드를 C 언어로 포팅하고 GTK3 GUI를 추가한 버전입니다.

### 특징

- ✅ 완전한 한글 입력 지원 (초성, 중성, 종성, 겹받침)
- ✅ 영문 입력 지원 (대문자/소문자)
- ✅ 숫자 입력 지원
- ✅ 4가지 입력 모드: 한글, 영문(대), 영문(소), 숫자
- ✅ 직관적인 GUI 인터페이스
- ✅ 정확한 wchar_t/UTF-8 변환으로 안정적인 한글 표시

## 빌드 요구사항

### Linux

```bash
# Ubuntu/Debian
sudo apt-get install build-essential libgtk-3-dev

# Fedora/RHEL
sudo dnf install gcc gtk3-devel

# Arch Linux
sudo pacman -S gcc gtk3
```

### Cygwin (Windows)

setup-x86_64.exe에서 다음 패키지 설치:
- gcc-core
- make
- pkg-config
- libgtk3-devel

### MSYS2 (Windows)

```bash
pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-gtk3
```

## 빌드 방법

```bash
# 프로젝트 디렉토리로 이동
cd Chunjiin

# 빌드
make

# 실행
./chunjiin      # Linux/Cygwin
# 또는
./chunjiin.exe  # Windows

# 빌드와 실행을 한번에
make run
```

## 사용 방법

### 버튼 레이아웃

```
┌──────┬──────┬──────┬──────┐
│  1   │  2   │  3   │  0   │
├──────┼──────┼──────┼──────┤
│  4   │  5   │  6   │Space │
├──────┼──────┼──────┼──────┤
│  7   │  8   │  9   │ Del  │
└──────┴──────┴──────┴──────┘
```

### 한글 모드

#### 자음 입력

- **버튼 0**: ㅇ → ㅁ → ㅇ (반복)
- **버튼 4**: ㄱ → ㅋ → ㄲ → ㄱ
- **버튼 5**: ㄴ → ㄹ → ㄴ
- **버튼 6**: ㄷ → ㅌ → ㄸ → ㄷ
- **버튼 7**: ㅂ → ㅍ → ㅃ → ㅂ
- **버튼 8**: ㅅ → ㅎ → ㅆ → ㅅ
- **버튼 9**: ㅈ → ㅊ → ㅉ → ㅈ

#### 모음 입력

- **버튼 1**: ㅣ (세로 획)
- **버튼 2**: · (점, 가로 획의 시작)
- **버튼 3**: ㅡ (가로 획)

#### 복합 모음 만들기

- ㅏ = ㅣ(1) + ·(2)
- ㅑ = ㅣ(1) + ·(2) + ·(2)
- ㅓ = ·(2) + ㅣ(1)
- ㅕ = ·(2) + ·(2) + ㅣ(1)
- ㅗ = ·(2) + ㅡ(3)
- ㅛ = ·(2) + ·(2) + ㅡ(3)
- ㅜ = ㅡ(3) + ·(2)
- ㅠ = ㅡ(3) + ·(2) + ·(2)
- ㅐ = ㅣ(1) + ·(2) + ㅣ(1)
- ㅔ = ·(2) + ㅣ(1) + ㅣ(1)

#### 예시: "한글" 입력하기

**"한"** 입력:
1. `8` (ㅎ)
2. `1` (ㅣ) + `2` (·) = ㅏ
3. `5` (ㄴ) - 종성

**"글"** 입력:
1. `4` (ㄱ)
2. `3` (ㅡ)
3. `5` (ㄹ) - 종성

### 영문 모드

각 버튼을 반복해서 눌러 해당 문자를 선택합니다.

- **버튼 0**: @ → ? → ! → @
- **버튼 1**: . → Q → Z → .
- **버튼 2**: A → B → C → A
- **버튼 3**: D → E → F → D
- **버튼 4**: G → H → I → G
- **버튼 5**: J → K → L → J
- **버튼 6**: M → N → O → M
- **버튼 7**: P → R → S → P
- **버튼 8**: T → U → V → T
- **버튼 9**: W → X → Y → W

### 숫자 모드

각 버튼이 해당하는 숫자를 입력합니다 (0~9).

### 모드 전환

하단의 **"모드 변경"** 버튼을 클릭하여 다음 순서로 모드를 전환할 수 있습니다:

```
한글 → 영문(대) → 영문(소) → 숫자 → 한글 → ...
```

## 파일 구조

```
Chunjiin/
├── chunjiin.h           # 헤더 파일 (구조체 및 함수 선언)
├── chunjiin.c           # 핵심 로직 및 유틸리티
├── chunjiin_hangul.c    # 한글 입력 로직 (hangul_make, write 함수)
├── main.c               # GTK GUI 애플리케이션
├── Makefile             # 빌드 설정
├── README.md            # 이 파일
├── Chunjiin.java        # 원본 Java 코드 (참고용)
└── Chunjiinactivity.java # 원본 Android Activity (참고용)
```

## 기술 세부사항

### 문자 인코딩

- 내부적으로 `wchar_t` (UTF-32 on Linux) 사용
- GTK 디스플레이를 위해 UTF-8로 자동 변환
- 한글 유니코드 조합 알고리즘 구현 (초성 + 중성 + 종성)

### 한글 조합 원리

한글 완성형 유니코드 = `44032 + (초성 × 588) + (중성 × 28) + 종성`

예: "한" = ㅎ(18) + ㅏ(0) + ㄴ(4)
     = 44032 + (18 × 588) + (0 × 28) + 4
     = 54620 (0xD55C)

### 겹받침 지원

다음 겹받침을 완벽하게 지원합니다:
- ㄳ (ㄱ + ㅅ)
- ㄵ (ㄴ + ㅈ)
- ㄶ (ㄴ + ㅎ)
- ㄺ (ㄹ + ㄱ)
- ㄻ (ㄹ + ㅁ)
- ㄼ (ㄹ + ㅂ)
- ㄽ (ㄹ + ㅅ)
- ㄾ (ㄹ + ㅌ)
- ㄿ (ㄹ + ㅍ)
- ㅀ (ㄹ + ㅎ)
- ㅄ (ㅂ + ㅅ)

## 라이선스

MIT License

원본 저작권: Copyright (c) 2014 KimYs (a.k.a ZeDA)
- Blog: http://blog.naver.com/irineu2
- GitHub: https://github.com/sigigi/dotnet_chunjiin

C/GTK 포트: Copyright (c) 2025 Claude (Anthropic)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 문제 해결

### GTK3를 찾을 수 없다는 오류

```bash
# pkg-config가 GTK3를 찾을 수 있는지 확인
pkg-config --modversion gtk+-3.0

# GTK3가 설치되어 있지 않다면 위의 "빌드 요구사항" 섹션을 참고하여 설치하세요
```

### Cygwin에서 실행 시 디스플레이 오류

```bash
# X11 서버가 실행 중인지 확인
# Cygwin/X를 설치하고 startxwin을 실행하세요
```

### Windows에서 한글이 깨지는 경우

한글 폰트가 설치되어 있는지 확인하세요. Windows에는 기본적으로 맑은 고딕, 돋움 등의 한글 폰트가 포함되어 있습니다.

### 버튼 클릭 시 텍스트가 업데이트되지 않는 경우

이 문제는 wchar_t to UTF-8 변환 이슈로 이미 수정되었습니다. 최신 버전을 사용하고 있는지 확인하세요.

## 기여

버그 리포트나 개선 제안은 환영합니다!

## 참고

- 원본 Java/Android 코드: [GitHub - sigigi/dotnet_chunjiin](https://github.com/sigigi/dotnet_chunjiin)
- 천지인 입력법: https://ko.wikipedia.org/wiki/천지인_(입력기)
- 한글 유니코드: https://ko.wikipedia.org/wiki/한글_유니코드

## 스크린샷

애플리케이션은 다음을 포함합니다:
- 상단: 제목 및 현재 입력 모드 표시
- 중앙: 입력 텍스트 표시 영역 (스크롤 가능)
- 하단: 0-9 숫자 키패드 (4x3 그리드)
- 최하단: 모드 변경 및 전체 지우기 버튼

---

Made with ❤️ using C and GTK3
