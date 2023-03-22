# 2022 캡스톤 디자인 - 저작 운동 모니터링 시스템
</br>
</br>

## 맡은 역할 : 플러터 어플 개발 

</br>
</br>

<a href='https://ifh.cc/v-qW3nsv' target='_blank'><img src='https://ifh.cc/g/qW3nsv.jpg' border='0'></a>
</br>

## 작품 설명
1. 저작 운동을 감지할 웨어러블 기기의 프로토타입은 귀, 머리 등에 두르는 형태이며 피에조 압전 센서, 아두이노, 블루투스 모듈로 구성됩니다.
2. 피에조 압전 센서는 음식을 씹을 때마다 센서에서 진동 변화를 측정합니다. 측정된 저작 횟수는 웨어러블 기기의 블루투스 모듈을 통해 어플리케이션으로 전송되고, 사용자는 어플리케이션을 통해 실시간으로 확인할 수 있습니다.
3. 저작 횟수 데이터를 그래프로 시각화합니다.

</br>
</br>

---
</br>
</br>

## H/W와 S/W 구성도
</br>
<a href='https://ifh.cc/v-a4Q4w1' target='_blank'><img src='https://ifh.cc/g/a4Q4w1.png' border='0'></a>
</br>
1. 웨어러블 기기를 착용한 사용자의 저작 횟수를 블루투스 통신을 통해 어플에 전송, 증가하는 저작 운동 측정 횟수가 실시간으로 반영 <br>
2. Firebase 저장소에 측정 횟수 데이터를 전송하여 저장<br>
3. Firebase 저장소에 저장되어 있는 저작 횟수 데이터를 통해 어플에 저작 횟수 데이터를 시각화

</br>
</br>

----
<br>

# 어플 화면

## 홈 화면

<br>
<a href='https://ifh.cc/v-26Ov0s' target='_blank'><img src='https://ifh.cc/g/26Ov0s.png' border='0'></a>
</br>

저작 횟수 측정 시작 전 화면의 구성은 식사시간을 선택할 수 있는 체크박스와 저작 횟수 측정 시작버튼으로 구성되어 있다.

---
<br>

## 저작횟수 측정 화면
<br>
<a href='https://ifh.cc/v-ggrcAO' target='_blank'><img src='https://ifh.cc/g/ggrcAO.png' border='0'></a>
저작 횟수 측정 시작 후 화면의 구성은 저작 운동 횟수와 식사 시간을 측정해주는 위젯과 식사 종료 버튼으로 구성되어 있다.
식사 종료 버튼을 누르면 측정된 저작 횟수와 식사시간은 Firebase 저장소에 저장된다.
<br>

---
<br>

## 레포트 페이지

<a href='https://ifh.cc/v-hGpSxc' target='_blank'><img src='https://ifh.cc/g/hGpSxc.jpg' border='0'></a>

레포트 화면은 가장 최근 일곱 끼니에 대한 데이터를 그래프로 시각화한 위젯과 달력 형태로 원하는 날짜에 데이터를 조회할 수 있는 위젯으로 구성되어 있다