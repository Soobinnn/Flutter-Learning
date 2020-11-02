# Provider

18년 Google IO 까지만 해도 구글은 Provider가 아닌 BloC패턴 사용을 권장했었다.

플러터는 UI와 Design 모두 소스코드로 관리되지 않으면 한 클래스에 여러 코드가 몰리게 되는 문제가 있음.

이를 해결하기 위해 UI와 데이터 처리 로직 분리가 되는 Bloc 패턴을 제공했었음.

하지만 Bloc 패턴은 사용하기 너무 어렵다는 사람들이 많았다.

단순 로직을 짜려고 해도 최소 4개의 클래스를 만들어야 했다.

반면 Provider패턴을 사용하면 데이터 공유나 로직의 분리를 좀 더 간단히 할 수 있게 된다.


## Provider Pattern 사용하는 이유

1. 관심사의 분리

일반적으로는 한개의 클래스가 여러 역할을 수행하면 할수록, 커지고 관리가 어렵게 된다.

그렇기에 클래스가 하나의 역할(관심)만 갖도록 클래스를 나눈다.

이를 관심사의 분리라고 의미한다.

Provider나 BloC 패턴 사용 이유의 주 목적

2. 데이터 공유의 원활함

하나의 데이터를 여러 페이지에서 공유를 간편하게 할 수 있다.
예를 들어 유저 인증 정보의 경우 장바구니, 회원 등급 등 여러 페이지에서 사용된다. 이를 페이지마다 인증 정보를 불러오게되면 앱이 복잡해지며 그만큼 비용도 많이 든다.
ㅤ
이럴 때 데이터 공유가 필요하다.
Provider 패턴은 데이터 공유를 조금 더 쉽게 할 수 있도록 도와준다.

3. 간결한 코드

Bloc 패턴의 경우 클래스들을 역할별로 나누는데 좋다.
하지만 코드 자체가 복잡해지는 경향이 존재한다.
ㅤ
Provider 패턴을 사용하면 좀 더 적은 코드로 클래스를 구분하여 사용할 수 있다.
ㅤ
구글에서는 중규모 프로젝트는 Provider 패턴을, 대규모 프로젝트는 BloC 패턴 사용을 권장


## Provider 구조

Provider의 구성 요소는 데이터를 생산하고 소비하는 2가지로 구분된다.

또한 어떤 데이터를 생산하느냐에 따라 Provider의 종류도 달라진다.
상황에 따라 일반적인 Provider와 실시간으로 변경되는 StreamProvider가 되기도 한다.

```
dependencies:
  provider: ^4.1.3
```

### 데이터 생산 코드
```dart
Provider<int>.value(
   value: 5,
   child: Container(),
)
```
데이터 생성에는 데이터 타입을 정의해줘야 한다.

### 데이터 소비 코드
```dart
var data = Provider.of<int>(context)
```

Provider에서 제공하는 데이터를 사용하기 위해서는 Provider.of(context)나 Consumer()위젯을 사용한다.


Consumer를 왜(why?) 사용하냐면,
보통 코드에서 context를 사용하게 되는데 해당 context를 build에서 알아서 찾아가지고 다른 메서드에 있어도 context를 끌고 올 수 있다!

해당 코드에서는 로그인 버튼과 Text부분에 대해서 다른 메서드에 만들었기에 context를 끌고 오지 못했다.
그래서 Consumer를 사용해서 가져와 provider를 사용할 수 있다
```
Consumer<JoinOrLogin>(
            builder: (context, joinOrLogin, child) =>
                RaisedButton(
                  child: Text(
                    joinOrLogin.isJoin ? "회원가입" :
                    "로그인",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  color: joinOrLogin.isJoin ? Colors.red : Colors.indigo,
```
우선 Cosumer는 builder로 가져오는 것이 3가지이다.
( context, value(데이터) , child(위젯) )이다.
여기서 context가 없다면? build에서 context를 찾아 제공(provider)하게 해준다.

변할때마다 rebuild해야하면 consumer 변화만 알려주면되면 watch 그냥 값만 읽어오면 read를 사용하는것 같다.