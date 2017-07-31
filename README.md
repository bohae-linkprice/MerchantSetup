## 머천트 셋업작업 이란

제휴마케팅에서 광고주가 돈을 지불하는 성과는 어필리에이트 사이트(또는 페이지) 방문자가 광고 배너 또는 링크를 클릭하여 머천트 사이트로 이동, 약속된 행위 (회원가입, 이벤트 참여, 상품구매등)을 하는 것입니다.성과를 정확히 측정하기 위해서는 어필리에이트 사이트 방문자의 이동경로와 머천트 사이트에서의 구매(가입)에 대해 추적이 가능해야 하며, 이를 위해 필요한 것이 셋업 작업입니다.



## 셋업 요약

1. LPINFO 쿠키생성 - 랜딩페이지


2. 실적전송

   * 주문 테이블에 network_name, network_value, user_agent, remote_address 필드 추가(CPA:회원가입 테이블, CPS:order 테이블)
   * 실적이 발생하여 완료되는 페이지에 실적전송 코드(샘플제공) 삽입(Server to Server 방식으로 전송)


3. 실적출력 테스트(daily_fix)

   * 머천트 DB에 저장되어진 링크프라이스 데이터 출력 테스트


4. 자동 실적 취소(auto_cancel)

   * 주문 상태 출력 테스트




## 랜딩페이지(CPS, CPA 공용)

1. lpfront

   - 사용자가 Affiliate의 광고를 통하여 머천트 사이트에 방문시 Affiliate의 정보를 기억하기 위한 Cookie(**LPINFO**)를 생성합니다.

   - "LPINFO"(Affiliate 정보)를 사용 하여 쿠키를 만들고 "URL"(이동할 페이지)를 사용하여 이동합니다.(샘플코드 참조) 

   - RETURN_DAYS(광고 인정 기간) 값은 **계약서에 명시되어있는 광고 인정 기간**으로 맞게 변경하여 주십시요. 광고 인정 기간을 계약서와 다르게 임의로 바꿀시 계약위반으로 불이익을 받으실수 있습니다.

     ​

2. lpfront 샘플

   * [PHP](https://github.com/linkprice/MerchantSetup/blob/master/sample/PHP/lpfront.php)
   * [JSP](https://github.com/linkprice/MerchantSetup/blob/master/sample/JSP/lpfront.jsp)
   * [ASP](https://github.com/linkprice/MerchantSetup/blob/master/sample/ASP/lpfront.asp)

   ​



## CPS - 실시간 실적전송

1. 실시간 실적 전송
   - LPINFO 쿠키가 있고 실적이 이루어졌을 때 링크프라이스로 실적이 전송되어야 합니다.

   - 주문관련 테이블에 network_name, network_value, remote_address 그리고 user_agent 필드를 추가합니다.

   - **결제완료 시점**에  network_value에 LPINFO(cookie)값을, network_name에는"linkprice", remote_address 에는 실적 발생 사용자 IP 그리고 user_agent 에는 실적발생 사용자 HTTP_USER_AGENT  값을 저장하여 주십시요.

     |     FIELD      |                VALUE                |
     | :------------: | :---------------------------------: |
     | network_value  |           LPINFO(cookie)            |
     |  network_name  | 링크프라이스를 구분할 수 있는 값(예-linkprice, lp) |
     | remote_address |             REMOTE_ADDR             |
     |   user_agent   |           HTTP_USER_AGENT           |
2. 실시간 실적 전송 시점
   - 실시간 실적 전송은 실적이 발생하여 완료되는 시점(구매완료)에 이루어 져야 합니다. 즉 **구매 완료** 페이지에 실적전송 코드(샘플 참조)를 삽입하여 주십시요.
   - 모든 실적은 Server to Server 방식으로 전송됩니다.(**스크립트(script) 및 이미지(image) 방식으로 전달시 링크프라이스로 별도 문의 주셔야 합니다**)
3. 개발 내역
   - 샘플코드는 각 머천트 환경에 맞게 수정하여 사용하여 주십시요.
   - 실적은 JSON 형식으로 보내지게 되며 KEY 이름은 **수정 불가** 이며, VALUE 값을 머천트 실적에 맞게 넣어 주시면 됩니다. (아래 KEY 설명 참고)

|     KEY      |      VALUE      |      KEY      |                 VALUE                 |
| :----------: | :-------------: | :-----------: | :-----------------------------------: |
|     a_id     | LPINFO cookie 값 |  merchant_id  | 링크프라이스 머천트 ID(링크프라이스에서 지정, 셋업시 전달 드림) |
|  member_id   |   실적 발생 회원ID    |  order_code   |           주문번호(**Unique**값)           |
| product_code |   실적 발생 상품코드    |  item_count   |                  개수                   |
|    sales     | 실적 총금액(가격 * 개수) | category_code |                카테고리 코드                |
| product_name |    실적 발생 상품명    |  user_agent   |            HTTP_USER_AGENT            |
| remote_addr  |   REMOTE_ADDR   |               |                                       |



4. 샘플코드
   * [PHP](https://github.com/linkprice/MerchantSetup/blob/master/sample/PHP/index.php)

   * [JSP](https://github.com/linkprice/MerchantSetup/blob/master/sample/JSP/index.jsp)

   * [ASP](https://github.com/linkprice/MerchantSetup/blob/master/sample/ASP/index.aspx.vb)

     ​


## CPS - 실적 출력 스크립트(daily_fix)

1. 실적출력(daily_fix)

   * 링크프라이스와 머천트의 실적을 비교하여 누락된 실적을 복구하기 위한 작업입니다.

2. 실적출력 셋업

   * 머천트의 DB에 저장된 링크프라이스 실적을 출력합니다.
   * 샘플코드는 머천트 환경에 맞게 수정하여 사용하여 주십시요.
   * 실적 출력을 원하는 날짜를 "yyyymmdd"의 이름으로 GET방식으로 전송합니다.
     * 예 - www.example.com/linkprice/daily_fix.php?yyyymmdd=20170701
   * 실적은 json 형식으로 출력하여 주십시요.

   |      KEY      |      VALUE      |     KEY     |      VALUE       |
   | :-----------: | :-------------: | :---------: | :--------------: |
   |     a_id      | network_value 값 | order_time  | 주문시간(예 - hhmmss) |
   |   member_id   |   실적 발생 회원 ID   | order_code  |       주문번호       |
   | product_code  |   실적 발생 상품 코드   |    sales    | 실적 총 금액(가격 * 개수) |
   | product_name  |    실적 발생 상품명    | item_count  |        개수        |
   | category_code |     카테고리 코드     | remote_addr |   실적 발생 사용자 IP   |
   |  user_agent   | HTTP_USER_AGENT |             |                  |

   ​

3. 샘플코드

   * [PHP](https://github.com/linkprice/MerchantSetup/blob/master/sample/PHP/daily_fix.php)
   * [JSP](https://github.com/linkprice/MerchantSetup/blob/master/sample/JSP/daily_fix.jsp)
   * [ASP](https://github.com/linkprice/MerchantSetup/blob/master/sample/ASP/daily_fix.asp)

   ​


## CPS - 자동 실적 취소

1. 실적취소(auto_cancel)
   - 머천트에서는 발생한 실적에 대하여 취소된 경우(반품, 미입금, 취소 등 기타 적합하지 않은 경우) 링크프라이스 실적을 취소할수 있습니다.
2. 실적취소 셋업
   * 샘플코드는 각 머천트 환경에 맞게 수정하여 사용하여 주십시요.
   * 링크프라이스의 DB에 있는 머천트 실적에서 주문번호(order_code)와 상품코드(product_code)를 머천트에게 GET방식으로 전송합니다.
   * 자동취소 페이지 호출시 json 형식으로 출력하여 줍니다.

   |     KEY      |      VALUE      |
   | :----------: | :-------------: |
   | order_status | 결과코드(결과 코드표 참조) |
   |    reason    |       이유        |

   * 결과 코드표

   | 결과코드 |      의미      |         링크프라이스 처리지침          |
   | :--: | :----------: | :--------------------------: |
   |  0   |   미입금, 미결제   | 결제 익월 20일까지 미입금 또는 미결제 경우 취소 |
   |  1   |   주문 최종 확정   |            주문 확정             |
   |  2   |   주문 취소/환불   |              취소              |
   |  3   | 주문번호의 주문이 없음 |              취소              |
   |  9   |  확인요망(예외상황)  |      링크프라이스 담당자 확인 후 처리      |

   ​


3. 샘플 코드(auto_cancel)
   * [PHP](https://github.com/linkprice/MerchantSetup/blob/master/sample/PHP/auto_cancel.php)
   * [JSP](https://github.com/linkprice/MerchantSetup/blob/master/sample/JSP/auto_cancel.jsp)
   * [ASP](https://github.com/linkprice/MerchantSetup/blob/master/sample/ASP/auto_cancel.asp)




## CPA - 실시간 실적전송

1. 실시간 실적 전송

   - LPINFO 쿠키가 있고 실적이 이루어졌을 때 링크프라이스로 실적이 전송되어야 합니다.

   - 회원가입 테이블에 network_name, network_value, remote_address 그리고 user_agent 필드를 추가합니다.

   - **회원가입 완료시점**에  network_value에 LPINFO(cookie)값을, network_name에는"linkprice", remote_address 에는 실적 발생 사용자 IP 그리고 user_agent 에는 실적발생 사용자 HTTP_USER_AGENT  값을 저장하여 주십시요.

     |     FIELD      |                VALUE                |
     | :------------: | :---------------------------------: |
     | network_value  |           LPINFO(cookie)            |
     |  network_name  | 링크프라이스를 구분할 수 있는 값(예-linkprice, lp) |
     | remote_address |             REMOTE_ADDR             |
     |   user_agent   |           HTTP_USER_AGENT           |

2. 실시간 실적 전송 시점

   - 실시간 실적 전송은 실적이 발생하여 완료되는 시점(가입완료)에 이루어 져야 합니다. 즉 **회원 가입 완료** 페이지에 실적전송 코드(샘플 참조)를 삽입하여 주십시요.
   - 모든 실적은 Server to Server 방식으로 전송됩니다.(스크립트(script) 및 이미지(image) 방식으로 전달시 링크프라이스로 별도 문의 주셔야 합니다)

3. 개발 내역

   - 샘플코드는 각 머천트 환경에 맞게 수정하여 사용하여 주십시요.
   - 실적은 JSON 형식으로 보내지게 되며 KEY 이름은 **수정 불가** 이며, VALUE 값을 머천트 실적에 맞게 넣어 주시면 됩니다. (아래 KEY 설명 참고)

|     KEY      |      VALUE      |      KEY      |                 VALUE                 |
| :----------: | :-------------: | :-----------: | :-----------------------------------: |
|     a_id     | LPINFO cookie 값 |  merchant_id  | 링크프라이스 머천트 ID(링크프라이스에서 지정, 셋업시 전달 드림) |
|  member_id   |   실적 발생 회원ID    |  order_code   |           회원번호(**Unique**값)           |
| product_code |     member      | category_code |                 FREE                  |
|  user_agent  | HTTP_USER_AGENT |  remote_addr  |              REMOTE_ADDR              |



1. 샘플코드

   - [PHP](https://github.com/linkprice/MerchantSetup/blob/master/sample/PHP/index.php)

   - [JSP](https://github.com/linkprice/MerchantSetup/blob/master/sample/JSP/index.jsp)

   - [ASP](https://github.com/linkprice/MerchantSetup/blob/master/sample/ASP/index.aspx.vb)

     ​

## CPA - 실적 출력 스크립트(daily_fix)

1. 실적출력(daily_fix)

   - 링크프라이스와 머천트의 실적을 비교하여 누락된 실적을 복구하기 위한 작업입니다.

2. 실적출력 셋업

   - 머천트의 DB에 저장된 링크프라이스 실적을 출력합니다.
   - 샘플코드는 머천트 환경에 맞게 수정하여 사용하여 주십시요.
   - 실적 출력을 원하는 날짜를 "yyyymmdd"의 이름으로 GET방식으로 전송합니다.
     - 예 - www.example.com/linkprice/daily_fix.php?yyyymmdd=20170701
   - 실적은 json 형식으로 출력하여 주십시요.

   |      KEY      |      VALUE      |     KEY     |      VALUE      |
   | :-----------: | :-------------: | :---------: | :-------------: |
   |     a_id      | network_value 값 | order_time  |  가입시간(hhmmss)   |
   |   member_id   |   실적 발생 회원 ID   | order_code  |      주문번호       |
   | product_code  |     member      | user_agent  | HTTP_USER_AGENT |
   | category_code |      FREE       | remote_addr |  실적 발생 사용자 IP   |

   ​

3. 샘플코드

   - [PHP](https://github.com/linkprice/MerchantSetup/blob/master/sample/PHP/daily_fix.php)
   - [JSP](https://github.com/linkprice/MerchantSetup/blob/master/sample/JSP/daily_fix.jsp)
   - [ASP](https://github.com/linkprice/MerchantSetup/blob/master/sample/ASP/daily_fix.asp)

   ​